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
