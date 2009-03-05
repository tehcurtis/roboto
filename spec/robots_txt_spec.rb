require File.expand_path(File.dirname(__FILE__)+'/spec_helper.rb')

describe Roboto::RobotsTxt, 'get_robots_txt_path(uri)' do  
  it 'should generate a path to the robots.txt file' do
    @base_uri = "http://shorturi.com/this/is/awesome"
    @obj = Roboto::RobotsTxt.new(@base_uri)
    @base_uri.should_receive(:host).and_return('shorturi.com')
    URI.should_receive(:parse).and_return(@base_uri)
    @obj.get_robots_txt_path.should == "http://shorturi.com/robots.txt"
  end
  
end

# describe Roboto::RobotsTxt, 'allows?' do
#   before do
#     @obj = Roboto::RobotsTxt.new('a valid uri')
#   end
#   
#   it 'should check to see if there is a robots.txt file' do
# 
#   end
#   
#   it 'should check to see if anyone can access the site if a robots.txt exists'
#   
#   it 'should not ping the site anymore if everyone is disallowed'
#   
#   it 'should return a blank string if everyone is disallowed'
# end
