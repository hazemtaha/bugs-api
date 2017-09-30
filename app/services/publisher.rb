class Publisher
  def self.publish(exchange_name, message = {})
    exchange = channel.fanout("instabug.#{exchange_name}")
    exchange.publish(message.to_json)
  end

  def self.channel
    @channel ||= connection.create_channel
  end

  def self.connection
    @connection ||= Bunny.new({ host: 'rabbitmq' }).tap do |con|
      con.start
    end
  end
end
