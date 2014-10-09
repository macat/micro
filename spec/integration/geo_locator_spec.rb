require 'spec_helper' 

describe Micro::GeoLocator do 
  context 'when valid inbound message' do 
    let(:inbound_message) do 
      '{"page": "/users", "time": 1411615161, "ip": "12.130.117.132"}'
    end

    context 'when the gelocated ip is cached' do 
      it 'retrieves the longitued and latitude from the cache' do 
        allow(Micro::GeolocatedIpCache).to receive(:retrieve_latitude_longitude) { 
          JSON.parse('{"latitude": 0, "longitude": 0}') }

        expect(Micro::GeoLocator.(inbound_message).lat).to eql 0
      end
    end

    context 'when the gelocated ip is not cache' do 
      before do 
        allow(Micro::GeolocatedIpCache).to receive(:retrieve_latitude_longitude).
          and_raise(Micro::GeolocatedIpCache::NoCachedIp)
      end

      it 'recomputes the longitude and latitude for a given ip address' do 
        expect(Micro::GeoLocator.(inbound_message).lat).to eql 38
      end

      it 'saves the new gelocated ip into the cache' do 
        expect(Micro::GeolocatedIpCache).to receive(:save_latitude_longitude)
        .with('12.130.117.132', 38, -97)

        Micro::GeoLocator.(inbound_message)
      end
    end
  end

  context 'when invalid inbound message' do 
    let(:inbound_message) { '{page: "/users"}' }
    it 'raises an error' do 
      expect { 
        Micro::GeoLocator.(inbound_message)
      }.to raise_error(Micro::GeoLocator::InvalidInboundMessage, 
                       "The inbound message is invalid")
    end
  end
end
