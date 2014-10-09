require 'geocoder' 

module Micro
  module GeoLocator
    extend self

    class InvalidInboundMessage < StandardError; end

    def call(msg)
      inbound_message = Messages::Inbound.for(msg)
      if inbound_message.valid?
        geocoder_data = GeocoderData.for(Geocoder.search(inbound_message.ip).first.data)
        outbound_message = Messages::Outbound.for(inbound_message, geocoder_data)
      else
        raise InvalidInboundMessage.new("The inbound message is invalid")
      end
    end

    class GeocoderData 
      def self.for(data) 
        new(data) 
      end

      attr_reader :lat, :long
      def initialize(data) 
        @lat = default_attributes.merge(data).fetch('latitude')
        @long = default_attributes.merge(data).fetch('longitude')
      end

      private 

      def default_attributes 
        {
          'latitude' => 0,
          'longitude' => 0
        }
      end
    end
  end
end
