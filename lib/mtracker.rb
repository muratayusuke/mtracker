require 'mtracker/version'

# module for tracking time
module Mtracker
  attr_accessor :mtracker_log_pid_and_tid

  def track(label)
    start_time = Time.now
    increment_nest_level

    put_track_info "#{indent}[start#{pid_and_tid}] #{label}"
    result = yield
    put_track_info "#{indent}[end  #{pid_and_tid}] #{label} (#{sprintf('%.3f', Time.now - start_time)} sec)"

    decrement_nest_level
    result
  end

  private

  def indent
    '  ' * nest_level
  end

  def pid_and_tid
    mtracker_log_pid_and_tid ? " #{nest_level_key}" : ''
  end

  def nest_level
    @mtracker_nest_levels ||= {}
    @mtracker_nest_levels[nest_level_key] ||= 0
  end

  def nest_level_key
    process_id = Process.pid
    thread_id = syscall(186)
    "#{process_id}_#{thread_id}"
  end

  def increment_nest_level
    @mtracker_nest_levels ||= {}
    @mtracker_nest_levels[nest_level_key] = @mtracker_nest_levels[nest_level_key] ? @mtracker_nest_levels[nest_level_key] + 1 : 0
  end

  def decrement_nest_level
    @mtracker_nest_levels ||= {}
    @mtracker_nest_levels[nest_level_key] = @mtracker_nest_levels[nest_level_key] ? @mtracker_nest_levels[nest_level_key] - 1 : 0
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
