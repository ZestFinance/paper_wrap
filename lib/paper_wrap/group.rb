
##
#  Group operations on papertrail
#
module PaperWrap

  class Group < Base

    class << self

      def find_by_group_name(group_name)
        group_list = all  # Get all and filter, since there's no searching in this API
        matches = group_list.select { |group| group.name == group_name }
        matches.first
      end

      def all
        response = make_request('groups.json', 'get')
        raw_list = JSON.parse(response)
        raw_list.map { |payload| Group.new(payload) }
      end

      ## Creates a new group in papertrail
      def create(params = {})
        raise Exception.new("Missing required parameters: name, system_wildcard") if params[:name].nil? || params[:system_wildcard].nil?
        make_request('groups.json', 'post', {"group[name]" => params[:name], "group[system_wildcard]" => params[:system_wildcard]})
      end

    end


    def initialize(payload)
      @payload = payload
    end

    def payload
      @payload
    end

    def name
      @payload['name']
    end

    def id
      @payload['id']
    end

    def system_wildcard
      @payload['system_wildcard']
    end

  end

end



