require 'spec_helper'

describe Micro::GeolocatedIpCache do 
  let(:geodata) do
    Micro::GeoLocator::GeocoderData.for({'latitude' => 0, 'longitude' => 0})
  end
  let(:inbound) do
    Micro::Messages::Inbound.for('{"page": "/users", "time": 1411615161, "ip": "12.130.117.132"}')
  end
  let(:outbound) { Micro::Messages::Outbound.for(inbound, geodata) }

  it 'saves a new outbound message into the cache' do 
    expect(Micro::GeolocatedIpCache.save_latitude_longitude(outbound.ip, 
                                                     outbound.lat, 
                                                     outbound.long)).to eql true
  end

  it 'retrieves already saved latitude and longitude' do 
    expect(Micro::GeolocatedIpCache.retrieve_latitude_longitude('12.130.117.132')).
      to eql({"latitude" => 0, "longitude" => 0})
  end

end
