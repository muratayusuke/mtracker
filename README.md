# Mtracker

Simple time tracker.

## Installation

Add this line to your application's Gemfile:

    gem 'mtracker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mtracker

## Usage

Just include `Mtracker` module to your class and call `track` method with label and block.

```
class Myclass
  include Mtracker

  def foo
    track 'sample job' do
      'bar' * 1000000
    end
  end
end
```

Then you can see following output:

```
[start] sample job
[end] sample job (0.004353018 sec)
```

## Usage with logger
Just include `Mtracker` module to your class and make attribute reader named logger and
call `track` method with label and block.

```
class Myclass
  include Mtracker

  attr_accessor :logger

  def initialize
    # initialize logger
  end

  def foo
    track 'sample job' do
      'bar' * 1000000
    end
  end
end
```

Then you can see following output in your logger output as info level:

```
[start] sample job
[end] sample job (0.004353018 sec)
```

## Usage with Newrelic
You can create newrelic segment with option `newrelic: true` .
It calls `NewRelic::Agent::Tracer.start_segment`.
```
class Myclass
  include Mtracker

  def foo
    track('sample job', newrelic: true) do
      'bar' * 1000000
    end
  end
end
```

Child thread is supported.
```
class Myclass
  include Mtracker

  def foo
    transaction = NewRelic::Agent::Tracer.current_transaction
    Parallel.each(['foo', 'bar'], in_threads: 2) do |s|
      Thread.current[:nr_transaction] = transaction
      track('sample job', newrelic: true) do
        s * 1000000
      end
    end
  end
end
```

See: [official document](https://docs.newrelic.com/docs/apm/agents/ruby-agent/api-guides/ruby-custom-instrumentation/)

## Contributing

1. Fork it ( https://github.com/muratayusuke/mtracker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
