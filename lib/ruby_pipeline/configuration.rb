# frozen_string_literal: true

module RubyPipeline
  class Configuration
    attr_accessor :success_callback, :failure_callback

    def initialize
      @success_callback = ->(step) {}
      @failure_callback = ->(step) {}
    end
  end
end
