module Micro 
  module OutboundMessageSender 
    extend self 

    def call(queue_name, message)
      json_message = message.to_json
      LogReporter.logger.info "Sending #{json_message} to #{queue_name}"
      Shoryuken::Client.queues(queue_name).send_message(json_message)
    end
  end
end
