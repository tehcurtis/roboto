require 'open-uri'
require File.dirname(__FILE__)+'/roboto/robots_txt'

module Roboto
  module VERSION #:nodoc:
    Major = 0
    Minor = 0
    Tiny = 4
    
    String = [Major, Minor, Tiny].join('.')
  end
end


module Kernel
  # A wrapper for OpenUri's "open" method that respects the given site's robots.txt file.
  # Example usage: open_r('http://curtis.wordpress.com', 'user-agent' => 'the batman v1').read
  def open_r(dest, options={}, &block)
    data = ''
    return false if dest.empty? || !dest.is_a?(String)
    if !(dest =~ /http:\/\//).nil? && !(dest =~ /(.*\.[a-z]{2})/).nil?
      @robots_txt = Roboto::RobotsTxt.new(dest, options)
      if @robots_txt.allows?(dest) && @robots_txt.errors.empty?
        return open(dest, options, &block)
      elsif @robots_txt.errors
        RAILS_DEFAULT_LOGGER.warn(@robots_txt.errors) if defined? RAILS_DEFAULT_LOGGER
        Merb.logger.warn(@robots_txt.errors) if defined? Merb
      end
    end
  end
end