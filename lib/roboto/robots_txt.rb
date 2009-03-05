module Roboto
  class RobotsTxt
    require 'open-uri'
    
    attr_accessor :txt, :original_uri, :robot_options
    
    # A few recommend good samaritan flags to pass 
    # 'User-Agent' => @@config_agent, 
    # 'If-None-Match' => site.etag,
    # 'If-Modified-Since' => site.last_modified.rfc2822
    def initialize(uri, options={})
      self.original_uri = uri
      self.robot_options = options
    end
    
    def allows?(uri)
      path = get_robots_txt_path
      self.txt = open(path, options).read
    end
    
    def get_robots_txt_path
      prefix = @original_uri.include?('https://') ? 'https://' : 'http://'
      prefix = 'http://' if prefix.nil?
      base_uri = prefix + URI.parse(@original_uri).host
      base_uri + '/robots.txt'
    end
    
  end
end