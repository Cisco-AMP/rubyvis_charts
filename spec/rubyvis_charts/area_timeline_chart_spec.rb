require 'spec_helper'


describe RubyvisCharts::AreaTimelineChart do
  include_examples :abstract_timeline_chart

  let(:values) { [[1, 2, 3, 4, 5, 6, 7, 8], [2, 3, 4, 5, 6, 7, 8, 9]] }

  let(:areas_colors) { %w[#087faa #d9ae41] }

  let(:args) { { areas_colors: areas_colors } }
end
