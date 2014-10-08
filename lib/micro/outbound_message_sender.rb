module Micro 
  module OutboundMessageSender 
    extend self 

    def call(queue_name, message)
      Shoryuken::Client.queues(queue_name).send_message(message.to_json)
    end
  end
end
