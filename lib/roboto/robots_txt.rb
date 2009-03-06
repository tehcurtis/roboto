module Roboto
  class RobotsTxt
    require 'open-uri'
    attr_accessor :perms, :path, :sitemaps
    # a few sample options are:
    # 'User-Agent' => @@config_agent, 
    # 'If-None-Match' => site.etag,
    # 'If-Modified-Since' => site.last_modified.rfc2822
    def initialize(uri, options={})
      self.sitemaps = []
      
      # we'll try storing this data in a hash
      # this may need to be broken off into it's own object if things get hairy
      self.perms = {}

      # set the path to the robots.txt file from the original given uri
      self.path = get_robots_txt_path(uri)
      
      # grab the content out of the robots.txt and keep it around for later
      # TODO: check for 404s, Timeouts, etc
      content = open(@path, options).read
      
      # parse the contents what we took out of the robots.txt file
      # and pack it into a hash for future reference
      self.perms = store_permissions(content)
    end
    
    def allows?(uri)
      return true if everyone_allowed_everywhere?
      # you're next
      # return false if noone_allowed_anywhere
      # return true if current_agent_allowed?(uri)   
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
      prefix = uri.include?('https://') ? 'https://' : 'http://'
      prefix = 'http://' if prefix.nil?
      base_uri = prefix + URI.parse(uri).host
      base_uri + '/robots.txt'
    end
        
    def everyone_allowed?
      return true if self.perms.empty? 
      return true if self.perms['*'] && self.perms['*']['allow'].find {|r| r == '/'}
      self.perms['*'] && self.perms['*']['disallow'].find {|r| r == ''}
    end
    
    def noone_allowed_anywhere
      
    end
  end
end