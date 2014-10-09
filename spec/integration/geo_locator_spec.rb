require 'spec_helper' 

describe Micro::GeoLocator do 
  context 'when valid inbound message' do 
    let(:inbound_message) do 
      '{"page": "/users", "time": 1411615161, "ip": "12.130.117.132"}'
    end

    it 'retrieve the longitude and latitude for a given ip address' do 
      expect(Micro::GeoLocator.(inbound_message).lat).to eql 38
      expect(Micro::GeoLocator.(inbound_message).long).to eql -97
    end
  end

  context 'when invalid inbound message' do 
    let(:inbound_message) { '{page: "/users"}' }
    it 'raises an error' do 
      expect { 
        Micro::GeoLocator.(inbound_message)
      }.to raise_error(Micro::GeoLocator::InvalidInboundMessage, "The inbound message is invalid")
    end
  end
end
