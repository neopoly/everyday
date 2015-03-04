class Channels
  def initialize
    @subscriptions = Hash.new { |h,k| h[k] = [] }
  end

  def publish(name, event)
    subscriptions[name].each { |handler| handler.call(event) }
  end

  def subscribe(name, &handler)
    subscriptions[name] << handler
  end

  private

  attr_reader :subscriptions
end
