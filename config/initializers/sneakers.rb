require 'sneakers'
Sneakers.configure log: STDOUT, amqp: "amqp://guest:guest@rabbitmq"
Sneakers.logger.level = Logger::INFO
