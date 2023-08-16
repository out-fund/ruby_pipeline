# frozen_string_literal: true

require 'ruby_pipeline/version'
require 'ruby_pipeline/configuration'
require 'ruby_pipeline/base_pipeline'

module RubyPipeline
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
