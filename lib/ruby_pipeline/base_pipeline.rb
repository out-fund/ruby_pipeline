# frozen_string_literal: true

module RubyPipeline
  class BasePipeline
    def initialize(steps = default_steps)
      @steps = steps
    end

    def process(input = nil)
      steps.inject(input) do |memo, step|
        step_result = step.process(memo)

        break false if step_result.nil?

        step_result
      end
    end

    private

    attr_reader :steps

    def default_steps = []
  end
end
