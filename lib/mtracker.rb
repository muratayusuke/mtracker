require 'mtracker/version'

# module for tracking time
module Mtracker
  def track(label)
    @mtracker_nest_level = @mtracker_nest_level ? @mtracker_nest_level + 1 : 0
    start_time = Time.now
    indent = '' * @mtracker_nest_level
    put_track_info "#{indent}[start] #{label}"
    result = yield
    put_track_info "#{indent}[end] #{label} (#{sprintf('%.3f', Time.now - start_time)} sec)"
    result
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
