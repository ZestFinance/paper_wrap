require 'spec_helper'

describe PaperWrap::Group do

  #  File in ./spec/fixtures/groups.json
  let(:group_json_raw) do
    File.read('spec/fixtures/groups.json')
  end

  before do
    described_class.stub(:make_request).and_return(group_json_raw)
  end

  describe '.all' do
    it 'should receive the entire request and parse json' do
      described_class.should_receive(:make_request).with('groups.json', 'get').and_return(group_json_raw)
      groups = described_class.all
      groups.length.should == 2
      groups[0].name.should == 'Group-A'
      groups[1].name.should == 'Group-B'
    end
  end

  describe '.find_by_group_name' do
    it 'should parse and return only the group that matches the name requested' do
      group = described_class.find_by_group_name('Group-B')
      group.should_not be_nil
      group.name.should == 'Group-B'
    end
  end

  describe '.create' do
    let(:group_name) { 'test' }
    let(:environment) { 'prod' }
    it 'should dispatch a group creation request to papertrail' do
      described_class.should_receive(:make_request).with('groups.json', 'post', anything())
      described_class.create(name: 'mygroup', system_wildcard: 'my*')
    end
    it 'should throw an exception if required params are not passed' do
      expect { described_class.create(name: 'mygroup') }.to raise_error
    end
  end

  describe 'object accessors' do
    it 'should parse all of the fields from the json as expected' do
      groups = described_class.all
      groups[0].name.should == 'Group-A'
      groups[0].system_wildcard.should == 'A*'
      groups[0].id.should == 31
      groups[1].name.should == 'Group-B'
      groups[1].system_wildcard.should == 'B*'
      groups[1].id.should == 32
    end
  end

end
