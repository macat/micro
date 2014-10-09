require_relative 'lib/micro'

class RetrievalWorker
  include Shoryuken::Worker

  shoryuken_options queue: 'default'

  def perform(sqs_msg)
    outbound_message = Micro::GeoLocator.(sqs_msg.body)
    Micro::OutboundMessageSaver.(outbound_message)
    Micro::OutboundMessageSender.('default', outbound_message)
  rescue Micro::GeoLocator::InvalidInboundMessage => e
    puts "#{Time.now} - ERROR: Processing message - #{e.message}"
  end
end

