# Ruby Pipeline

Add pipelines of small ruby classes to your ruby project.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_pipeline'
```

And then execute:

    bundle

Or install it yourself as:

    gem install ruby_pipeline

## Usage

### Create a pipeline

```ruby
class MyPipeline < RubyPipeline::BasePipeline
  private

  def default_steps
    [
      PipelineSteps::Step1,
      PipelineSteps::Step2
    ]
  end
end
```

### Create a step

```ruby
class PipelineSteps::Step1 < RubyPipeline::BaseStep
  def process(data)
    # do something with data, what you return will be passed to the next step
    data
  end
end

class PipelineSteps::Step1 < RubyPipeline::BaseStep
  def process(data)
    # returning nil will terminate the pipeline
    nil
  end
end
```

### Run a pipeline

```ruby
MyPipeline.new.process(data)
```

### Config

You can configure a success callback to be called after each step is processed:

```ruby
RubyPipeline.configure do |config|
  config.success_callback = ->(step) { my_monitoring_service.notify(step) }
  config.failure_callback = ->(step) { puts "Failure in step #{step}" }
  config.time_callback = lambda do |step, &block|
    my_timing_service.time(step) do
      block.call # Important to call the block, otherwise the pipeline will not continue
    end
  end
end
```

## Contributing

1. Fork it
1. Create your feature branch (git checkout -b my-new-feature).
1. Commit your changes (git commit -am 'Added some feature')
1. Push to the branch (git push origin my-new-feature)
1. Create new Pull Request

We're using RSpec for testing. Run the test suite with rake spec. Tests for pull requests are appreciated but not required. (If you don't include a test, we'll write one before merging.)

## License

`ruby-pipeine`` is free software released under the MIT License. See LICENSE for details.

## Publishing a gem version

This gem uses Github Packages Registry to store gems, and all builds get pushed to it.

1. Update `lib/ruby_pipeline/version.rb` with the new version
2. Create and push a tag:

  ```bash
    git tag 'v0.1.0' # replace with your version
    git push origin 'v0.1.0'
  ```

This will automatically trigger the release workflow of GHA, after which you will be able to install a fresh version of a gem into your system.
