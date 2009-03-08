module Roboto
  class RobotsTxt
    require 'open-uri'
    attr_accessor :perms, :path, :sitemaps, :destination, :user_agent
    # a few sample options are:
    # 'User-Agent' => @@config_agent, 
    # 'If-None-Match' => site.etag,
    # 'If-Modified-Since' => site.last_modified.rfc2822
    def initialize(destination, options={})
      @destination = destination
      
      self.sitemaps = []
      
      # we'll try storing this data in a hash
      # this may need to be broken off into it's own object if things get hairy
      self.perms = {}
      
      self.user_agent = options['User-agent'] if options
      
      # set the path to the robots.txt file from the original given uri
      self.path = get_robots_txt_path(@destination)
      
      # grab the content out of the robots.txt and keep it around for later
      # TODO: check for 404s, Timeouts, etc
      begin
        content = open(@path, options).read
      rescue
        content = ''
      end
      
      # parse the contents what we took out of the robots.txt file
      # and pack it into the hash for future reference
      self.perms = store_permissions(content)
    end
    
    def allows?(uri)
      return true if everyone_allowed_everywhere?
      return false if noone_allowed_anywhere
      return true if current_agent_allowed?(uri)   
    end

    def store_permissions(content)
      agents = {}
      rules = content.scan /\s*(.*?)$/mi
      i = 0
      opts = ['allow', 'disallow', 'crawl-delay', 'request-rate', 'visit-time']
      until i >= rules.length 
        rule = rules[i]
        rule = rule[0]
        rule = rule.downcase
        
        if rule =~ /user-agent/
          agent = rule.gsub(/(user-agent:\s*)/, '')
          agents[agent] = {}
          opts.each {|o| agents[agent][o] = [] }
          @current_agent = agent
        end
        
        opts.each do |o| 
          agents[@current_agent][o] << rule.gsub(Regexp.new("^#{o}:"), '').strip if !rule.scan(Regexp.new("^#{o}:")).empty?
        end
        
        @sitemaps << rule if rule =~ /sitemap/

        i+=1
      end
      agents
    end
   
    def get_robots_txt_path(uri)
      # TODO: take into account subdomains, each subdomain has it's own robots.txt
      prefix = uri.include?('https://') ? 'https://' : 'http://'
      prefix = 'http://' if prefix.nil?
      base_uri = prefix + URI.parse(uri).host
      base_uri + '/robots.txt'
    end
        
    def everyone_allowed_everywhere?
      # the robots.txt was empty or not found at all
      # in either case, this site is open for all bots
      return true if @perms.empty? 
      
      return true if @perms['*'] && @perms['*']['allow'].find {|r| r == '/'}
      
      # if the disallow is blank, then nothing is blocked
      return true if @perms['*'] && @perms['*']['disallow'].find {|r| r == ''}
  
      false
    end
    
    
    def noone_allowed_anywhere
      # this just kind of feels wrong
      !(self.perms['*'] && self.perms['*']['disallow'].find {|r| r == '/'}).nil?
    end
    
    def current_agent_allowed?(uri)
      # no soup for those who don't set their user-agent
      if @user_agent.nil?
        # log to logger that the user agent wasn't set
        return false
      end
      
      # support name* and name
      # this will also bring us the user-agent * and any matches we find
      user_agents = @perms.keys.select {|k| (@user_agent == k) || (@user_agent.include?(k.gsub(/(\*.*)/, ''))) }
      user_agents.each do |ua|
        @perms[ua]['disallow'].each do |r|
          return true if r == ''
          return false if r == '/' || uri.include?(r) || uri.include?(r.gsub(/\*/, ''))
        end
      end
      
      # the uri isn't specifially disallowed for this user-agent so 
      true
    end
  end
end