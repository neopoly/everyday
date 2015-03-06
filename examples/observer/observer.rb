class Observer
  attr_reader :uid
  attr_writer :subject

  def update
    raise "Implement update in subclass"
  end
end

class DashboardService < Observer
  def uid
    self.class.to_s
  end

  def update
    $stdout.print 'Update dashboard'
  end
end

class ReportService < Observer
  def uid
    self.class.to_s
  end

  def update
    $stdout.print 'Generate user statistics PDF document'
  end
end
