# Everyday

Everyday is a example based repository for solutions to common oss problems ruby developers have to struggle with almost everyday 

# Observer

`Observer` defines a tightly coupled one-to-many dependency between objects.

Use it if a change to one object effects one or more other objects.

The `subject` maintains a list of `observers` and notifies them of any state changes, by calling one of their methods.

## Example

Execute the example with:

```bash
ruby -Ilib:examples examples/observer.rb
```

### examples/observer.rb

```ruby
class Observer
  def initialize(uid)
    @uid = uid
    @subject = nil
  end

  def uid
    @uid
  end

  def subject=(subject)
    @subject = subject
  end

  def update
    print "#{uid} observer notified\n"
  end
end

class Subject
  def initialize
    @observers = []
  end

  def attach(observer)
    observer.subject = self
    observers << observer
  end

  def detach(observer)
    observers.delete_if {|o| o.uid == observer.uid }
  end

  def do_something_that_is_interesting_for_the_observers
    notify
  end

  private

  def observers
    @observers
  end

  def notify
    observers.each do |observer|
      observer.update
    end
  end
end

s = Subject.new
o1 = Observer.new('first')
o2 = Observer.new('second')

s.do_something_that_is_interesting_for_the_observers # => nil

s.attach(o1)

s.do_something_that_is_interesting_for_the_observers # => first observer notified

s.attach(o2)

s.do_something_that_is_interesting_for_the_observers # => first observer notified 
                                                     # => second observer notified

s.detach(o1)

s.do_something_that_is_interesting_for_the_observers # => second observer notified

s.detach(o2)

s.do_something_that_is_interesting_for_the_observers # => nil

```

# Publish-subscribe

`Publish-subscribe` defines a loosely coupled many-to-many dependency between objects.

It is a messaging pattern to decouple the senders (publishers) of a message from the receivers (subscribers) of a message.

A publisher is not sending a message directly to a specific subscriber, like the in observer pattern, instead published messages are pushed into a named channel, without knowledge of what or even if any, subscribers are available.

Subscribers express interest in one or more of these channels, and only receive messages that are of interest, without knowledge of what or even if any, publishers there are.

## Gems

### [wisper](https://github.com/krisleech/wisper)

A micro library providing Ruby objects with Publish-Subscribe capabilities

## Example

Execute the example with:

```bash
ruby -Ilib:examples examples/publish-subscribe.rb
```

### examples/publish-subscribe.rb

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

### examples/publish-subscribe/channels.rb

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

### examples/publish-subscribe/email_service.rb

```ruby
class EmailService
  def deliver_welcome_email(user)
    $stdout.print "Welcome #{user.nickname}"
  end
end

```

### examples/publish-subscribe/user_gateway.rb

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
