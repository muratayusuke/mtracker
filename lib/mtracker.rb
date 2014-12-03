require 'mtracker/version'

module Mtracker
  def track(label)
    start_time = Time.now
    puts "[start] #{label}"
    yield
    puts "[end] #{label} (#{Time.now - start_time} sec)"
  end
end
