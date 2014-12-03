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

That's all.

## Contributing

1. Fork it ( https://github.com/muratayusuke/mtracker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
