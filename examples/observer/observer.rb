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
