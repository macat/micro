require 'spec_helper' 

describe Micro::Messages::Inbound do 
  let(:value) { Micro::Messages::Inbound.for(message) } 

  context 'when valid json is sent' do 
    let(:message) { '{"page" : "/users", "ip": "12.12.12.12", "time":123456}' }
    it 'returns ip' do 
      expect(value.ip).to eql '12.12.12.12'
    end

    it 'returns time' do 
      expect(value.time).to eql 123456
    end

    it 'returns page' do 
      expect(value.page).to eql '/users'
    end
    
    it 'true for valid message' do 
      expect(value.valid?).to eql true
    end
  end

  context 'when invalid json is sent' do 
    let(:message) { '{page: "/users"}' }

    it 'false for valid message' do 
      expect(value.valid?).to eql false
    end
  end
end
