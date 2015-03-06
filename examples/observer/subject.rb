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

class UserGateway < Subject
  def create(user_data)
    add_user_to_backend(user_data)
    notify
  end

  private

  def add_user_to_backend(data)
    # build user and add him to the backend ...
  end
end
