require File.expand_path(File.dirname(__FILE__)+'/spec_helper.rb')

class TestClass
end

describe Roboto, "#open_r" do
  
  before do
    @tc = TestClass.new
  end
  
  it 'should return a blank string if not given a valid uri' do
    @tc.open_r("junk").should be_nil
  end
  
  it 'should return a blank string if not given a valid uri' do
    @tc.open_r('junktrash').should be_nil
  end  

  describe Roboto, "open_r in general" do
    before do
      @dest = 'http://example.com/best/page/evar.html'
      @faux_txt = mock('i am a robot') 
      @faux_txt.stub!(:errors).and_return('')
      Roboto::RobotsTxt.stub!(:new).with(@dest, {}).and_return(@faux_txt) 
      @faux_txt.stub!(:allows?).and_return(false)
    end

    it 'should grab the robots txt when given a valid uri' do
      Roboto::RobotsTxt.should_receive(:new).with(@dest, {}).and_return(@faux_txt)
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