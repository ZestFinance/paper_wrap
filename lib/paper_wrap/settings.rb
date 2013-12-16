
module PaperWrap
  class Settings

    attr_accessor :username, :password, :api_url

    def initialize(params = {})
      self.username = params[:username]
      self.password = params[:password]
      self.api_url  = params[:api_url]
    end

  end
end


