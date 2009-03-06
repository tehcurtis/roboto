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
    
    it do
      @obj.perms = @obj.store_permissions('')
      @obj.everyone_allowed?.should be_true
    end
    
    it do
      @obj.perms = @obj.store_permissions(NO_ACCESS)
      @obj.everyone_allowed?.should be_false
    end
    
    it do
      @obj.perms = @obj.store_permissions(MULTIPLE_AGENTS)
      @obj.everyone_allowed?.should be_false
    end
  end

  describe Roboto::RobotsTxt, '#noone_allowed_anywhere' do
    it do
      @obj.perms = @obj.store_permissions(NO_ACCESS)
      @obj.noone_allowed_anywhere.should be_true
    end
    
    it do
      @obj.perms = @obj.store_permissions(MULTIPLE_AGENTS)
      @obj.noone_allowed_anywhere.should be_false
    end
    
  end

  describe Roboto::RobotsTxt, '#current_agent_allowed?' do
    before do
      @uri = "http://this.net/is/just/a/test"
    end
    
    it 'should return false if no user-agent is passed' do
      @obj.user_agent = nil
      @obj.current_agent_allowed?(@uri).should be_false
    end
    
    it 'should return false if there is an explicit rule for the given user-agent' do
      @obj.perms = @obj.store_permissions(BLOCK_ROBOTO1)
      @obj.user_agent = 'mr-roboto v1.2'
      @obj.current_agent_allowed?(@uri).should be_false
    end
    
    it 'should return true if the agent is set and there is no rule for the destination uri' do
      @obj.perms = @obj.store_permissions(BLOCK_ROBOTO2)
      @obj.user_agent = 'mr-roboto v1.2'
      @obj.current_agent_allowed?(@uri).should be_true
    end
    
    it 'should return false if the agent is set and there is a rule that disallows access to the destination' do
      @obj.perms = @obj.store_permissions(BLOCK_ROBOTO2)
      @obj.user_agent = 'mr-roboto v1.2'
      @obj.current_agent_allowed?('http://thisishowweroll.com/mchammer/seeekrit/lyrics').should be_false
    end
    
    it 'should return false if the agent is set and there is a rule that disallows access to the destination' do
      @obj.perms = @obj.store_permissions(BLOCK_ROBOTO2)
      @obj.user_agent = 'mr-roboto v1.2'
      @obj.current_agent_allowed?('http://thisishowweroll.com/mchammer/seeekrit/cant/touch/this.html').should be_false
    end
    
    it do
      @obj.perms = @obj.store_permissions(BLOCK_ROBOTO2)
      @obj.user_agent = 'mr-roboto v1.2'
      @obj.current_agent_allowed?('http://thisishowweroll.com/a/seeekrit/cant/touch/this.html').should be_false
    end
    
    it  do
      @obj.perms = @obj.store_permissions(BLOCK_ROBOTO3)
      @obj.user_agent = 'mr-roboto v1.2'
      @obj.current_agent_allowed?('http://thisishowweroll.com/thisisabeat/youanttouch/seeekrit/cant/touch/oober.php').should be_true
    end
  end
  
end