require 'mtracker/version'

# module for tracking time
module Mtracker
  def track(label)
    start_time = Time.now
    puts "[start] #{label}"
    yield
    puts "[end] #{label} (#{Time.now - start_time} sec)"
  end

  def put_track_info(msg)
    if respond_to?(:logger)
      logger.info(msg)
    else
      puts msg
    end
  end
end
