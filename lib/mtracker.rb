require 'mtracker/version'

# module for tracking time
module Mtracker
  def track(label)
    start_time = Time.now
    put_track_info "[start] #{label}"
    yield
    put_track_info "[end] #{label} (#{sprintf('%.3f', Time.now - start_time)} sec)"
  end

  def put_track_info(msg)
    if respond_to?(:logger)
      logger.info(msg)
    elsif Rails
      Rails.logger.info(msg)
    else
      puts msg
    end
  end
end
