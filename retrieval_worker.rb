require_relative 'lib/micro'

class RetrievalWorker
  include Shoryuken::Worker

  def perform(sqs_msg)
    outbound_message = Micro::GeoLocator.(sqs_msg.body)
    Micro::OutboundMessageSender.('default', outbound_message)
  end
end

