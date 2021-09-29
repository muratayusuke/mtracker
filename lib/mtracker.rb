require 'mtracker/version'

# module for tracking time
module Mtracker
  attr_accessor :mtracker_log_pid_and_tid, :mtracker_slack_url

  def track(label, options = {})
    slack = options[:slack]

    start_time = Time.now
    increment_nest_level

    start_msg = "#{indent}[start#{pid_and_tid}] #{label}"
    put_track_info start_msg, slack

    result = yield

    finish_msg = "#{indent}[end  #{pid_and_tid}] #{label} (#{sprintf('%.3f', Time.now - start_time)} sec)"
    put_track_info finish_msg, slack

    decrement_nest_level
    result
  end

  private

  def indent
    '|   ' * nest_level
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

  def put_track_info(msg, slack = false)
    if respond_to?(:logger)
      logger.info(msg)
    elsif Rails
      Rails.logger.info(msg)
    else
      puts msg
    end

    send_to_slack(msg) if slack
  end

  def send_to_slack(msg)
    return unless mtracker_slack_url

    uri = URI.parse(mtracker_slack_url)
    data = { text: msg }
    Net::HTTP.post_form(uri, payload: data.to_json)
  end
end
