# frozen_string_literal: true

module RubyPipeline
  class Configuration
    attr_accessor :success_callback, :failure_callback

    def initialize
      @success_callback = ->(step) { puts "Success in step #{step}" }
      @failure_callback = ->(step) { puts "Failure in step #{step}" }
    end
  end
end
