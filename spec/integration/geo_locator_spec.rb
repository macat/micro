require 'spec_helper' 

describe Micro::GeoLocator do 
  let(:inbound_message) do 
    '{"page": "/users", "time": 1411615161, "ip": "12.130.117.132"}'
  end

  it 'retrieve the longitude and latitude for a given ip address' do 

    expect(Micro::GeoLocator.(inbound_message).lat).to eql 38
    expect(Micro::GeoLocator.(inbound_message).long).to eql -97
  end
end
