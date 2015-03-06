require 'publish-subscribe/channels'
require 'publish-subscribe/email_service'
require 'publish-subscribe/report_service'
require 'publish-subscribe/user_gateway'

channels = Channels.new
email_service = EmailService.new
report_service = ReportService.new

channels.subscribe :user_registered do |event|
  email_service.deliver_welcome_email event.user # => 'Send out welcome email to Bob'
  report_service.rebuild_user_statistics # => 'Generate user statistics PDF document'
end

user_gateway = UserGateway.new(channels)
user_gateway.create({:nickname => 'Bob'})
