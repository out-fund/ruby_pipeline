# frozen_string_literal: true

require File.expand_path('lib/ruby_pipeline/version', __dir__)

Gem::Specification.new do |s|
  s.name        = 'ruby_pipeline'
  s.version     = RubyPipeline::VERSION
  s.summary     = 'Pipelines for your ruby apps'
  s.description = ''
  s.authors     = ['Ian Vaughan']
  s.email       = 'ian@out.fund'
  s.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.homepage    = 'https://rubygems.org/gems/hola'
  s.license     = 'MIT'
end
