## External Libraries
require 'net/http'
require 'uri'
require 'json'

## Project Files
require 'paper_wrap/base'
require 'paper_wrap/settings'
require 'paper_wrap/group'
require 'paper_wrap/search'


module PaperWrap

  #  Methods: settings takes PaperWrap::Settings
  #  to be set for the entire API
  def self.settings=(settings)
    @settings = settings
  end
  def self.settings
    @settings
  end


end

