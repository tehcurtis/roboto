require File.expand_path(File.dirname(__FILE__)+'/spec_helper.rb')

class TestClass
  include Roboto::OpenR
end

describe Roboto, "#open_r" do
  
  before do
    @tc = TestClass.new
  end
  
  
  it 'should return a blank string if not given a valid uri' do
    @tc.open_r("junk").should == ''
  end
  
  it 'should return a blank string if not given a valid uri' do
    @tc.open_r('junktrash').should == ''
  end  
  describe Roboto, "open_r in general" do
    before do
      @dest = 'http://example.com/best/page/evar.html'
      @faux_txt = mock('i am a robot')     
      Roboto::RobotsTxt.stub!(:new).with(@dest, nil).and_return(@faux_txt) 
      @faux_txt.stub!(:allows?).and_return(false)
    end
    
    it 'should grab the robots txt when given a valid uri' do
      Roboto::RobotsTxt.should_receive(:new).with(@dest, nil).and_return(@faux_txt)
      @tc.open_r(@dest)
    end
    
    it 'should check to see if the robots_txt allows us to get to our destination' do
      @faux_txt.should_receive(:allows?).and_return(false)
      @tc.open_r(@dest)
    end
    
  
    it 'should try to access the given uri if allowed' do
      @faux_txt.should_receive(:allows?).and_return(true)
      @tc.should_receive(:open).with(@dest, {})
      @tc.open_r(@dest)
    end
  end
end

describe Roboto, '#uri_valid?' do
  before do
    @blk = lambda {|str| TestClass.new.uri_valid?(str)}
  end
  
  it "should return false for 'example' " do
    @blk.call('example').should be_false
  end
  
  it "should return false for 'example.com' " do
    @blk.call('example.com').should be_false
  end
  
  it "should return true for example.co.uk" do
    @blk.call('example.co.uk').should be_false
  end
  
  it "should return false for htp://example.com" do
    @blk.call('http://example.com').should be_true
  end
  
  it "should return true for http://example.co.uk" do
    @blk.call('http://example.co.uk').should be_true
  end
  
  it "should return true for http://www.example.com" do
    @blk.call('http://www.example.com').should be_true
  end
  
end
