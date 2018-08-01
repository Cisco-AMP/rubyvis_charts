require 'spec_helper'

describe SvgCharts::LineTimelineChart do
  include_examples :abstract_timeline_chart
  let(:values) { [[1, 2, 3, 4, 5, 6, 7, 8], [2, 3, 4, 5, 6, 7, 8, 9]] }
  let(:lines_colors) { %w[#087faa #d9ae41] }
  let(:args) { { lines_colors: lines_colors } }
end
