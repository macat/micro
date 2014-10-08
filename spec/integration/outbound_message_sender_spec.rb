require 'spec_helper' 

describe Micro::OutboundMessageSender do 
  let(:queue_name) { 'default' } 
  let(:geodata) do 
    Micro::GeoLocator::GeocoderData.for({'latitude' => 0, 'longitude' => 0})
  end
  let(:inbound) do 
    Micro::Messages::Inbound.for('{"page": "/users", "time": 1411615161, "ip": "12.130.117.132"}')
  end
  let(:outbound) { Micro::Messages::Outbound.for(inbound, geodata) }
  let(:service) { double :service }

  it 'sends a message to a given queue' do 
    allow(Shoryuken::Client).to receive(:queues).with(queue_name) { service }
    expect(service).to receive(:send_message).with(outbound.to_json)
    Micro::OutboundMessageSender.(queue_name, outbound)
  end
end
