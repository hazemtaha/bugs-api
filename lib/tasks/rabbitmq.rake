namespace :rabbitmq do
  desc "Create rabbitmq 'bugs.db_create' queue and binds it to the 'instabug.bugs' exchange"
  task setup_queue: :environment do
    require 'bunny'
    connection = Bunny.new({ host: 'rabbitmq' })
    connection.start
    channel = connection.create_channel
    exchange = channel.fanout("instabug.bugs")
    queue = channel.queue('bugs.db_create', durable: true)
    queue.bind(exchange.name)
    connection.close
  end

end
