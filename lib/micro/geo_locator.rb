require 'geocoder' 

module Micro
  module GeoLocator
    extend self

    class InvalidInboundMessage < StandardError; end

    def call(msg)
      inbound_message = Messages::Inbound.for(msg)
      if inbound_message.valid?
        Messages::Outbound.for(inbound_message, 
                               build_geocoder_data(inbound_message))
      else
        raise InvalidInboundMessage.new("The inbound message is invalid")
      end
    end

    private 

    def build_geocoder_data(inbound_message)
      lat_long = GeolocatedIpCache.retrieve_latitude_longitude(inbound_message.ip)
      geocoder_data = GeocoderData.for(lat_long)
    rescue GeolocatedIpCache::NoCachedIp
      LogReporter.logger.info "Retrieving geo location data for #{inbound_message.ip}"
      geocoder_data = GeocoderData.for(
        Geocoder.search(inbound_message.ip).first.data
      )
      GeolocatedIpCache.save_latitude_longitude(inbound_message.ip, 
                                                geocoder_data.lat, 
                                                geocoder_data.long)
      geocoder_data
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
