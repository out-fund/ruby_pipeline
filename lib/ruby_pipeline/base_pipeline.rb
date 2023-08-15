# frozen_string_literal: true

module RubyPipeline
  class BasePipeline
    def initialize(steps = default_steps)
      @steps = steps
    end

    def process(input = nil)
      steps.inject(input) do |memo, step|
        step_result = step.process(memo)

        break failure(step) if step_result.nil?

        success(step)
        step_result
      end
    end

    private

    attr_reader :steps

    def default_steps = []

    def success(step) = RubyPipeline.configuration.success_callback.call(step)

    def failure(step)
      RubyPipeline.configuration.failure_callback.call(step)
      false
    end
  end
end
