require 'json'

class RetrievalWorker
  include Shoryuken::Worker

  def perform(sqs_msg)
    outbound_message = GeoLocator.(sqs_msg)
    OutboundMessageSender.(outbound_message)
  end
end

