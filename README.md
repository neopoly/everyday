# Everyday

Everyday is a example based repository for solutions to common oss problems ruby developers have to struggle with almost everyday 

# Publish-subscribe

Publish–subscribe is a messaging pattern to decouple the senders (publishers) of a message from the receivers (subscribers) of a message.
A publisher is not sending a message directly to a specific subscriber, instead published messages are pushed into a named channel, without knowledge of what or even if any, subscribers are available.
Subscribers express interest in one or more of these channels, and only receive messages that are of interest, without knowledge of what or even if any, publishers there are.

```bash
ruby -Ilib:examples examples/publish-subscribe.rb
```

_examples/publish-subscribe.rb_

```ruby
require 'publish-subscribe/channels'
require 'publish-subscribe/email_service'
require 'publish-subscribe/user_gateway'

channels = Channels.new
email_service = EmailService.new

channels.subscribe :user_registered do |event|
  email_service.deliver_welcome_email event.user # => 'Welcome Bob'
end

user_gateway = UserGateway.new(channels)
user_gateway.create({:nickname => 'Bob'})

```

_examples/publish-subscribe/channels.rb_

```ruby
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

```

_examples/publish-subscribe/email_service.rb_

```ruby
class EmailService
  def deliver_welcome_email(user)
    $stdout.print "Welcome #{user.nickname}"
  end
end

```

_examples/publish-subscribe/user_gateway.rb_

```ruby
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

```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'everyday'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install everyday

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/everyday/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
