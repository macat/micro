require 'geocoder' 

module Micro
  module GeoLocator
    extend self

    def call(msg)
      inbound_message = Messages::Inbound.for(msg)
      geocoder_data = GeocoderData.for(Geocoder.search(inbound_message.ip).first.data)
      outbound_message = Messages::Outbound.for(inbound_message, geocoder_data)
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
