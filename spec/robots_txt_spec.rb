require File.expand_path(File.dirname(__FILE__)+'/spec_helper.rb')

describe Roboto::RobotsTxt, 'init' do
  before do
    @base_uri = "http://shorturi.com/this/is/awesome"
    @obj = Roboto::RobotsTxt.new(@base_uri)
  end
  
  describe Roboto::RobotsTxt, '#get_robots_txt_path(uri)' do  
    it 'should generate a path to the robots.txt file' do
      @base_uri.should_receive(:host).and_return('shorturi.com')
      URI.should_receive(:parse).and_return(@base_uri)
      @obj.get_robots_txt_path(@base_uri).should == "http://shorturi.com/robots.txt"
    end
  end
  
  describe Roboto::RobotsTxt, '#store_permissions(content)' do  
    it do
      @obj.store_permissions(MULTIPLE_AGENTS).should_not be_empty
    end
  
    it do
      @obj.store_permissions(MULTIPLE_AGENTS)['*']['allow'].size == 1
      @obj.store_permissions(MULTIPLE_AGENTS)['*']['allow'].select {|a| a == '/z/cg/vp.htm'}.should_not be_empty
    end
  
    it do
      @obj.store_permissions(MULTIPLE_AGENTS)['*']['disallow'].size == 20
      @obj.store_permissions(MULTIPLE_AGENTS)['*']['disallow'].select {|a| a == '/cgi/'}.should_not be_empty
    end
  end

  describe Roboto::RobotsTxt, '#everyone_allowed?' do
    
    def all_access
      <<-TXT
       User-agent: *
       Allow: /
      TXT
    end
    
    def all_access2
      <<-TXT
       User-agent: *
       Disallow:
      TXT
    end
    
    it do
      @obj.perms = @obj.store_permissions('')
      @obj.everyone_allowed?.should be_true
    end
    
  
    it do
      @obj.perms = @obj.store_permissions(all_access)
      @obj.everyone_allowed?.should be_true
    end
    
    it do
      @obj.perms = @obj.store_permissions(all_access2)
      @obj.everyone_allowed?.should be_true
    end
  
  end
end