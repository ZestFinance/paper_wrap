
##
#  Ruby wrapper around the papertrail API
#
module PaperWrap

  class Base

    class << self

      def papertrail_api_url
        PaperWrap.settings.api_url || "https://papertrailapp.com/api/v1/"
      end

      ##
      #  Use Net::HTTP b/c of compatibility problems in our system w/ httparty
      def make_request(uri, method = 'get', options = nil)

        uri = URI.parse("#{papertrail_api_url}#{uri}")
        uri.port = Net::HTTP.https_default_port()

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = case method
          when 'get'  then Net::HTTP::Get.new(uri.request_uri)
          when 'put'  then Net::HTTP::Put.new(uri.request_uri)
          when 'post' then Net::HTTP::Post.new(uri.request_uri)
        end
        request.basic_auth(PaperWrap.settings.username, PaperWrap.settings.password) if PaperWrap.settings
        request.set_form_data(options) if options
        response = http.request(request)

        if response.header.code != '200'
          raise Exception.new("Request failed (error code = #{response.code}): #{response.message}")
        end

        JSON.parse(response.body)
      end
    end

  end

end

