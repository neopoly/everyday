require 'publish-subscribe/events'
require 'publish-subscribe/email_service'
require 'publish-subscribe/report_service'
require 'publish-subscribe/user_gateway'

# Interface to publish or subscribe events
events = Events.new

# Publisher
user_gateway = UserGateway.new(events)

# Subscriber
email_service = EmailService.new
report_service = ReportService.new

# Subscriber listen to the user_registered event
events.subscribe :user_registered do |event|
  email_service.deliver_welcome_email event.user # => 'Send out welcome email to Bob'
  report_service.rebuild_user_statistics # => 'Generate user statistics PDF document'
end

# Application triggers a user_registered event through the publisher
user_gateway.create({:nickname => 'Bob'})
