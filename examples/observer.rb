require 'observer/subject'
require 'observer/observer'

# Subject
user_gateway = UserGateway.new

# Observer
dashboard_service = DashboardService.new
report_service = ReportService.new

# Application
user_gateway.create({:nickname => 'Bob'}) # => nil

user_gateway.attach(dashboard_service)
user_gateway.create({:nickname => 'Bob'}) # => Update dashboard

user_gateway.attach(report_service)
user_gateway.create({:nickname => 'Bob'}) # => Update dashboard
                               # => Generate user statistics PDF document

user_gateway.detach(dashboard_service)
user_gateway.create({:nickname => 'Bob'}) # => Generate user statistics PDF document

user_gateway.detach(report_service)
user_gateway.create({:nickname => 'Bob'}) # => nil
