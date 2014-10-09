require 'spec_helper'

describe Micro::OutboundMessageSaver do 
  let(:geodata) do
    Micro::GeoLocator::GeocoderData.for({'latitude' => 0, 'longitude' => 0})
  end
  let(:inbound) do
    Micro::Messages::Inbound.for('{"page": "/users", "time": 1411615161, "ip": "12.130.117.132"}')
  end
  let(:outbound) { Micro::Messages::Outbound.for(inbound, geodata) }

  it 'saves a new outbound message into the cache' do 
    expect(Micro::OutboundMessageSaver.(outbound)).to eql true
  end

  pending 'expires and delete an outbound message from the cache after 24 hours' do 
    Micro::OutboundMessageSaver.(outbound)
    redis = Redis.new
    Timecop.freeze(Date.today + 1) do 
      expect(redis.get("msg-12.130.117.132")).to eql ''
    end
  end
end
