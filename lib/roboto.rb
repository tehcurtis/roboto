require 'open-uri'
require File.dirname(__FILE__)+'/roboto/robots_txt'

module Roboto
  VERSION = '0.0.2'
end

module Kernel
  def open_r(dest, options={}, &block)
    data = ''
    return false if dest.empty? || !dest.is_a?(String)
    if !(dest =~ /http:\/\//).nil? && !(dest =~ /(.*\.[a-z]{2})/).nil?
      @robots_txt = Roboto::RobotsTxt.new(dest, options)
      if @robots_txt.allows?(dest)
        open(dest, options, &block)
      end
    end
  end
end