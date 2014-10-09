require 'redis'

module Micro 
  module OutboundMessageSaver 
    extend self 
    EXPIRATION_TIME = 86400

    def call(message)
      key_name = "msg-#{message.ip}-#{Time.now}"
      redis.set(key_name, message.to_json)
      redis.expire(key_name, EXPIRATION_TIME)
    end

    private 

    def redis(options = {})
      Redis.new(options)
    end
  end
end
