require 'json'
require 'shoryuken'
require 'dotenv'
require_relative 'micro/messages/inbound'
require_relative 'micro/messages/outbound'
require_relative 'micro/geo_locator'
require_relative 'micro/outbound_message_sender'
require_relative 'micro/geolocated_ip_cache'

Dotenv.load

module Micro 
  module LogReporter
    extend self

    def logger 
      Shoryuken.logger
    end
  end
end
