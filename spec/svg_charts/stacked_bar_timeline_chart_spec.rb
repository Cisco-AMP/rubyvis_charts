require 'spec_helper'

describe SvgCharts::StackedBarTimelineChart do
  include_examples :abstract_timeline_chart

  let(:values) { [[1, 2, 3, 4, 5, 6, 7, 8], [2, 3, 4, 5, 6, 7, 8, 9]] }

  let(:bars_padding) { SvgCharts::Padding.new(right: 2) }
  let(:bars_colors) { %w[#087faa #d9ae41] }

  let(:args) { { bars_padding: bars_padding, bars_colors: bars_colors } }
end
