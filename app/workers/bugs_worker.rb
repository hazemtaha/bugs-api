class BugsWorker
  include Sneakers::Worker
  from_queue "bugs.db_create", env: nil

  def work(message)
    parsed_message = JSON.parse(message)
    logger.info("Recieved the following message: #{parsed_message}")
    state_params = parsed_message.delete('state')
    bug_params = parsed_message
    @bug = Bug.new(bug_params)
    @bug.state = State.new(state_params)
    @bug.save
    ack!
    logger.info('Bug has been created sucessfully!')
  end
end
