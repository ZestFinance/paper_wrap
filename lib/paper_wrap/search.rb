module PaperWrap

  class Search < Base

    class << self

      def all
        raw_list = make_request('searches.json', 'get')
        raw_list.map { |payload| Search.new(payload) }
      end

      def find_by_name(name)
        matches = all.select { |search| search.name == name }
        matches.first if !matches.empty?
      end

      def find_by_query(query)
        matches = all.select { |search| search.query == query }
        matches.first if !matches.empty?
      end

      def find_all_by_group_id(group_id)
        all.select { |search| search.group_id == group_id }
      end

      def find_all_by_group_name(group_name)
        all.select { |search| search.group_name == group_name }
      end

      def create(params = {})
        if params[:name].nil? || params[:query].nil?
          raise Exception.new("Missing required parameters: name, query")
        end
        result = make_request('searches.json',
                               'post',
                               {'search[name]' => params[:name],
                                'search[query]' => params[:query],
                                'search[group_id]' => params[:group_id]})
        Search.new(result)
      end
    end

    #  Change saved search to belong to the group specified
    def move_to_group(group)
      self.class.make_request("searches/#{self.id}.json", 'put', {'search[group_id]' => group.id})
    end

    def initialize(payload)
      @payload = payload
    end

    def id
      @payload['id']
    end

    def name
      @payload['name']
    end

    def query
      @payload['query']
    end

    def group_id
      @payload['group']['id']
    end

    def group_name
      @payload['group']['name']
    end

  end

end


