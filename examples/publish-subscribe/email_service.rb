class EmailService
  def deliver_welcome_email(user)
    $stdout.print "Send out welcome email to #{user.nickname}"
  end
end
