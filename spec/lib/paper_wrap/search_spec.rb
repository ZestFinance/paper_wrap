require 'spec_helper'

describe PaperWrap::Search do

  let(:search_json_raw) { File.read('spec/fixtures/searches.json') }
  before { described_class.stub(:make_request).and_return(JSON.parse(search_json_raw)) }

  describe '.all' do
    it 'parses and returns all saved searches' do
      searches = described_class.all
      searches.length.should == 2
      searches[0].name.should == 'Saved-Search-1'
      searches[1].name.should == 'Saved-Search-2'
    end
  end

  describe '.find_by_name' do
    it 'returns only the matching saved search' do
      saved_search = described_class.find_by_name('Saved-Search-1')
      saved_search.should_not be_nil
      saved_search.name.should == 'Saved-Search-1'
    end
  end

  describe '.find_by_query' do
    it 'returns only the matching saved search' do
      saved_search = described_class.find_by_query('ssh*')
      saved_search.should_not be_nil
      saved_search.name.should == 'Saved-Search-2'
    end
  end

  describe '.find_all_by_group_id' do
    it 'returns only the searches for a given group' do
      searches = described_class.find_all_by_group_id(31)
      searches.should_not be_nil
      searches.length.should == 1
      searches[0].name.should == 'Saved-Search-1'
      searches[0].group_name.should == 'production'
    end
  end

  describe '.find_all_by_group_name' do
    it 'returns only the searches for a given group' do
      searches = described_class.find_all_by_group_name('staging')
      searches.should_not be_nil
      searches.length.should == 1
      searches[0].name.should == 'Saved-Search-2'
    end
  end

  describe '.create' do
    it 'dispatches to the api to create a saved search' do
      described_class.should_receive(:make_request).with('searches.json', 'post', anything())
      search = described_class.create(name: 'mytest', query: 'myquery')
      search.should be_kind_of(described_class)
    end
  end

  describe '#move_to_group' do
    let(:saved_search) { PaperWrap::Search.new(id: 1, name: 'mysearch', query: 'myq*') }
    let(:new_group) { PaperWrap::Group.new(id: 100) }
    it 'should move the saved search to the new group' do
      described_class.should_receive(:make_request).with("searches/#{saved_search.id}.json", 'put',
                                                         {'search[group_id]' => new_group.id})
      saved_search.move_to_group(new_group)
    end
  end

  describe 'object accessors' do
    it 'parses the json payload and returns the correct information' do
    end
  end

end
