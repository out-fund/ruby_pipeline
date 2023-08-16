# frozen_string_literal: true

require 'spec_helper'
require './spec/pipelines/test_pipeline'

module RubyPipeline
  RSpec.describe BasePipeline do
    describe '#process' do
      subject(:process_pipeline) { described_class.new(steps).process(input) }

      let(:input) { 2 }
      let(:steps) { [double_class] }

      let(:double_class) do
        Class.new do
          def self.process(number)
            number * 2
          end
        end
      end

      context 'when a step returns nil' do
        let(:double_class) do
          Class.new do
            def self.process(_input)
              nil
            end
          end
        end

        it { expect(process_pipeline).to be(false) }
      end

      context 'when a step returns a value' do
        let(:double_class) do
          Class.new do
            def self.process(input)
              input
            end
          end
        end

        let(:steps) { [double_class] }

        it 'returns that value' do
          expect(process_pipeline).to be(input)
        end
      end

      context 'when steps are given' do
        let(:steps) { [double_class, double_class] }

        it 'uses given steps' do
          expect(process_pipeline).to eq(input * 2 * 2)
        end
      end

      context 'when steps are not given' do
        subject(:process_pipeline) { described_class.new.process(input) }

        it 'uses default_steps' do
          expect(process_pipeline).to eq(input)
        end
      end

      context 'when a step in the middle returns nil' do
        let(:steps) { [double_class, double_class] }

        before { allow(double_class).to receive(:process).and_return(nil) }

        it { is_expected.to be(false) }

        it 'breaks pipeline execution' do
          process_pipeline

          expect(double_class).to have_received(:process).once
        end
      end

      context 'when success_callback is set' do
        let(:double_class) { TestSuccessStep }

        it 'calls the success_callback' do
          RubyPipeline.configure do |config|
            config.success_callback = ->(step) { expect(step).to eq TestSuccessStep }
          end

          expect(process_pipeline).to eq(4)
        end
      end

      context 'when failure_callback is set' do
        let(:double_class) { TestFailureStep }

        it 'calls the failure_callback' do
          RubyPipeline.configure do |config|
            config.failure_callback = ->(step) { expect(step).to eq TestFailureStep }
          end

          expect(process_pipeline).to be_falsey
        end
      end

      context 'when time_callback is set' do
        let(:double_class) { TestSuccessStep }

        it 'calls the time_callback' do
          RubyPipeline.configure do |config|
            config.time_callback = lambda do |step, &block|
              expect(step).to eq TestSuccessStep
              block.call
            end
          end

          expect(process_pipeline).to eq(4)
        end
      end
    end
  end
end
