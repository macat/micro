require_relative 'lib/micro'

class RetrievalWorker
  include Shoryuken::Worker

  shoryuken_options queue: ENV['MESSAGES_QUEUE']

  def perform(sqs_msg)
    outbound_message = Micro::GeoLocator.(sqs_msg.body)
    Micro::OutboundMessageSender.(ENV['GEOLOCATED_QUEUE'], 
                                  outbound_message)
  rescue Micro::GeoLocator::InvalidInboundMessage => e
    Micro::LogReport.error e.message
  end
end

