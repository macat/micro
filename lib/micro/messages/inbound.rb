module Micro
  module Messages
    class Inbound
      def self.for(msg)
        new(msg)
      end

      attr_reader :page, :ip, :time, :message
      def initialize(msg)
        @valid   = true
        @message = parse(msg)
        @page    = @message['page']
        @ip      = @message['ip']
        @time    = @message['time']
      end

      def valid?
        @valid
      end

      private 

      def parse(msg)
        JSON.parse(msg)
      rescue JSON::ParserError
        @valid = false
        {}
      end
    end
  end
end
