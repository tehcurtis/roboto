module Roboto
  class RobotsTxt
    require 'open-uri'
    
    attr_accessor :perms, :path, :sitemaps, :destination, :user_agent, :errors
    
    # Takes the given destination uri and tries to find and store the content
    # from the given site's robots.txt file.
    # Pass your User-agent in the options hash to be extra carefup6
    def initialize(destination, options={})
      @destination = destination
      
      # If a robots.txt defines any sitemaps
      self.sitemaps = []
      
      # Holds the rules found in a robots.txt file in 
      # a hash where the base keys are the user-agents
      self.perms = {}
      
      # Store the passed in user-agent if one was passed in
      self.user_agent = options['User-agent'] if options
      
      # Set the path to the robots.txt file from the original given uri
      self.path = get_robots_txt_path(@destination)
      
      # Errors that we get when trying to access a site's robots.txt file
      self.errors = ''
      
      # Try to grab the robots.txt
      begin
        content = open(@path, options).read
      rescue => e
        self.errors << "*"*5 + ' Roboto: ' + e
        content = ''
      end
      
      # Take the contents of the robots.txt and store it's content
      self.perms = store_permissions(content)
    end
    
    # Checks the given uri against the rules from the robots.txt file to see
    # if the given uri is ok to access
    def allows?(uri)
      return true if everyone_allowed_everywhere?
      return false if noone_allowed_anywhere
      return true if current_agent_allowed?(uri)   
    end

    # Takes the given robots.txt content and stores the rules it contains in a hash
    # where the keys are the found user-agents
    # example: {'googlebot' => {'crawl-delay'=>[], 
                            # 'request-rate'=>[], 
                            # 'allow'=>['/sitemap.xml', '/seekrits'], 
                            # "disallow"=>["/index.xml", "/excerpts.xml"] }
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
   
   # Sets the path where the robots.txt file will most
   # likely be found at.
    def get_robots_txt_path(uri)
      prefix = uri.include?('https://') ? 'https://' : 'http://'
      prefix = 'http://' if prefix.nil?
      base_uri = prefix + URI.parse(uri).host
      base_uri + '/robots.txt'
    end
    
    # Checks to see if there's a rule that allows
    # everyone in.
    def everyone_allowed_everywhere?
      # the robots.txt was empty or not found at all
      # in either case, this site is open for all bots
      return true if @perms.empty? 
      
      # check to see if there's a rule to allow everything
      return true if @perms['*'] && @perms['*']['allow'].find {|r| r == '/'}
      
      # if the disallow is blank, then nothing is blocked
      return true if @perms['*'] && @perms['*']['disallow'].find {|r| r == ''}
      
      false
    end
    
    # Checks for a rule that blocks everyone from everything.
    def noone_allowed_anywhere
      # checks for Disallow: /
      !(self.perms['*'] && self.perms['*']['disallow'].find {|r| r == '/'}).nil?
    end
    
    # Checks to see if there's a specific rule for the current user-agent
    # and if so, can the user-agent access the given uri.
    def current_agent_allowed?(uri)
      # be a good net citizen and set your user-agent!
      if @user_agent.nil? || @user_agent.empty?
        # log to logger that the user agent wasn't set
        log('*'*5 + ' ROBOTO: cannot determine if your bot is allowed since you did not ser the user-agent. 
        Set it in the open_r options hash like so
        \'user-agent\' => \'YOUR BOT\'s NAME\' and try again.')
        return false
      end
      
      # This will also bring us the user-agent * (for everyone) and any matches we find
      user_agents = @perms.keys.select {|k| (@user_agent == k) || (@user_agent.include?(k.gsub(/(\*.*)/, ''))) }
      user_agents.each do |ua|
        @perms[ua]['disallow'].each do |r|
          return true if r == ''
          return false if r == '/' || uri.include?(r) || uri.include?(r.gsub(/\*/, ''))
        end
      end
      
      # the uri isn't specifially disallowed for this user-agent 
      # so let it through
      true
    end
    
    private
    def log(msg) 
      RAILS_DEFAULT_LOGGER.warn(msg) if defined? RAILS_DEFAULT_LOGGER
      Merb.logger(msg) if defined? Merb
    end
  end
end