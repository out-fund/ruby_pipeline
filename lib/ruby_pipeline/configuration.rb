# frozen_string_literal: true

module RubyPipeline
  class Configuration
    attr_accessor :success_callback, :failure_callback, :time_callback

    def initialize
      @success_callback = ->(step) {}
      @failure_callback = ->(step) {}
      @time_callback = ->(_step, &block) { block.call }
    end
  end
end
