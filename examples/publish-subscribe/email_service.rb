class EmailService
  def deliver_welcome_email(user)
    $stdout.print "Welcome #{user.nickname}"
  end
end
