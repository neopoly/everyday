require 'observer/subject'
require 'observer/observer'

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
