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
