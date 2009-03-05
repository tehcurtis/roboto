require 'open-uri'
require File.dirname(__FILE__)+'/roboto/robots_txt'

module Roboto
  VERSION = '0.0.1'
  
  module OpenR
    def open_r(dest, options={})
      data = ''
      if uri_valid?(dest)
        @robots_txt = Roboto::RobotsTxt.new(dest, options['User-Agent'])
        if @robots_txt.allows?(dest)
          open(dest, options) {|file|
            data = file.read
          }
        end
      end
      block_given? ? yield(data) : data
    end
    
    def uri_valid?(dest)
      return false unless !dest.empty? && dest.is_a?(String)
      !(dest =~ /http:\/\//).nil? && !(dest =~ /(.*\.[a-z]{2})/).nil?
    end
    
    
    def pull_robots_txt(uri, user_agent)
      @robots_txt = ''
      options = {}
      options['User-Agent'] = user_agent if user_agent
      open(uri, options) {|file|
        @robots_txt = file.read
      }
    end

  end
  
end