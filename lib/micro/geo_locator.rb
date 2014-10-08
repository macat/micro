require 'geocoder' 

module Micro
  module GeoLocator
    extend self

    def call(msg)
      inbound_message = Messages::Inbound.for(msg)
      geocoder_data = Geocoder.search(inbound_message.ip).first.data
      outbound_message = Messages::Outbound.for(inbound_message, geocoder_data)
    end
  end
end
