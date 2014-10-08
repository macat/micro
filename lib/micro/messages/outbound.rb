module Micro 
  module Messages
    class Outbound
      def self.for(inbound_message, geocoder_data)
        new(inbound_message, geocoder_data)
      end

      attr_reader :page, :ip, :time, :lat, :long
      def initialize(inbound_message, geocoder_data)
        @page = inbound_message.page 
        @ip = inbound_message.ip
        @time = inbound_message.time
        @lat = default_attributes.merge(geocoder_data).fetch('latitude')
        @long = default_attributes.merge(geocoder_data).fetch('longitude')
      end

      private 

      def default_attributes
        { 
          "latitude" =>  0, 
          "longitude"=>  0
        }
      end
    end
  end
end
