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
