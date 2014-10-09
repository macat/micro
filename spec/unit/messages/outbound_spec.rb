require 'spec_helper'

describe Micro::Messages::Outbound do 
  let(:geodata) do
    Micro::GeoLocator::GeocoderData.for({'latitude' => 0, 'longitude' => 0})
  end
  let(:inbound) do
    Micro::Messages::Inbound.for('{"page": "/users", "time": 1411615161, "ip": "12.130.117.132"}')
  end
  let(:value) { Micro::Messages::Outbound.for(inbound, geodata) }

  it 'returns page' do 
    expect(value.page).to eql '/users'
  end

  it 'returns ip' do 
    expect(value.ip).to eql '12.130.117.132'
  end

  it 'returns time' do 
    expect(value.time).to eql 1411615161
  end

  it 'returns latitude' do 
    expect(value.lat).to eql 0
  end

  it 'returns longitude' do 
    expect(value.long).to eql 0
  end

  it 'proper json coercion' do 
    expect(value.to_json).to eql '{"page":"/users","time":1411615161,"ip":"12.130.117.132","lat":0,"long":0}'
  end
end
