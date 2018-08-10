require 'spec_helper'

describe RubyvisCharts::GroupedBarTimelineChart do
  include_examples :abstract_timeline_chart

  let(:bars_padding) { RubyvisCharts::Padding.new(right: 2) }
  let(:bars_colors) { ['#e81de0'] }

  let(:args) { { bars_padding: bars_padding, bars_colors: bars_colors } }
end
