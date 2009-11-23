require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'HonStats Account' do
    
  it "should respond to hero_usage" do
    a = HonStats::Account.new('foo')
    a.should respond_to(:hero_usage)
  end
  
  it "should respond to character_stats" do
    a = HonStats::Account.new('bar')
    a.should respond_to(:character_stats)
  end

  describe "should find_nickname_by_id" do
    before :all do
      @id2nick_xml    = XML::Parser.string(HONXML[:id2nick][:xml]).parse
      @id2nick_params = HONXML[:id2nick][:params]      
    end
    
    it "and form a correct query" do
      HonStats::Account.should_receive(:get_xml_data).and_return(@id2nick_xml)
      HonStats::Account.should_receive(:construct_url).with('id2nick', @id2nick_params)
      a = HonStats::Account.find_nickname_by_id(12345)      
    end
    
    it "and set the user_id and nickname correctly" do
      HonStats::Account.should_receive(:get_xml_data).and_return(@id2nick_xml)
      a = HonStats::Account.find_nickname_by_id(12345)
      a.should be_kind_of(HonStats::Account)
      a.user_id.should == '12345'
      a.nickname.should == 'honstats_test'
    end
  end

  describe "should find_id_by_nickname" do
    before :all do
      @nick2id_xml    = XML::Parser.string(HONXML[:nick2id][:xml]).parse
      @nick2id_params = HONXML[:nick2id][:params]
    end
    
    it "and form a correct query" do
      HonStats::Account.should_receive(:get_xml_data).and_return(@nick2id_xml)
      HonStats::Account.should_receive(:construct_url).with('nick2id', @nick2id_params)
      a = HonStats::Account.find_id_by_nickname('honstats_test')      
    end
    
    it "and set the user_id and nickname correctly" do
      HonStats::Account.should_receive(:get_xml_data).and_return(@nick2id_xml)
      a = HonStats::Account.find_id_by_nickname('honstats_test')
      a.should be_kind_of(HonStats::Account)
      a.user_id.should == '12345'
      a.nickname.should == 'honstats_test'
    end
  end
  
end