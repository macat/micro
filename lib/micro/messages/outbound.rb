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
        @lat = geocoder_data.lat
        @long = geocoder_data.long
      end
    end
  end
end
