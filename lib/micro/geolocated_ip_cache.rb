require 'redis'

module Micro 
  module GeolocatedIpCache
    extend self

    class NoCachedIp < StandardError; end

    def save_latitude_longitude(key_name, latitude, longitude)
      redis.set(key_name, {latitude: latitude, longitude: longitude}.to_json)
      redis.expire(key_name, ENV['CACHE_EXPIRATION_TIME'])
    end

    def retrieve_latitude_longitude(ip)
      returned_value = redis.get(ip)
      if returned_value
        JSON.parse(returned_value)
      else 
        raise NoCachedIp
      end
    end

    private 

    def redis
      @redis ||= Redis.new(host: ENV['REDIS_HOSTNAME'], port: ENV['REDIS_PORT'])
    end
  end
end
