require 'spec_helper'

describe RubyvisCharts::DonutChart do
  include_examples :abstract_chart
  let(:bars_padding) { RubyvisCharts::Padding.new(left: 22) }

  let(:args) { { values: [{ percentage: 0.2 }, { percentage: 0.8 }], cones_colors: ['#e81de0'] } }
  let(:constructor_args) { { **abstract_chart_args.merge(args) } }
end
