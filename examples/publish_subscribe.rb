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

class EmailService
  def deliver_welcome_email(user)
    $stdout.print "Welcome #{user.nickname}"
  end
end

class UserGateway
  def initialize(channels)
    @channels = channels
  end

  def create(data)
    add_user_to_backend(data)
    publish_user_registered_event(data)
  end

  private

  attr_reader :channels

  def add_user_to_backend(data)
    user = build_user(data)
    # add user to backend ...
  end

  def publish_user_registered_event(data)
    user = build_user(data)
    event = build_event(user)

    channels.publish :user_registered, event
  end

  def build_user(data)
    User.new(data)
  end

  class User
    attr_reader :nickname
    def initialize(user_data)
      @nickname = user_data[:nickname]
    end
  end

  def build_event(user)
    UserRegisteredEvent.new(user)
  end

  UserRegisteredEvent = Class.new(Struct.new(:user))
end

channels = Channels.new
email_service = EmailService.new

channels.subscribe :user_registered do |event|
  email_service.deliver_welcome_email event.user # => 'Welcome Bob'
end

user_gateway = UserGateway.new(channels)
user_gateway.create({:nickname => 'Bob'})