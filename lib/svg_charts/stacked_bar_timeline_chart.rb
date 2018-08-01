module SvgCharts
  class StackedBarTimelineChart < AbstractTimelineChart
    module DefaultArguments
      BARS_PADDING = Padding.new(right: 0.5, left: 0.5)
      BARS_COLORS = %w[#4d79da #31d49e].freeze
    end

    attr_reader :bars_padding, :bars_colors

    def initialize(
      bars_padding: DefaultArguments::BARS_PADDING,
      bars_colors: DefaultArguments::BARS_COLORS,
      **other
    )
      super(other)

      @bars_padding = bars_padding
      @bars_colors = bars_colors

      initialize_bars!
    end

    protected

    def values_max
      @max_value ||= values.transpose.map do |transposed_value|
        transposed_value.inject(0) {|sum, x| sum + x }
      end.max
    end

    private

    def initialize_bars!
      chart = self

      fill_style_colors = -> { chart.send(:bars_colors_iterator, self.parent.index, self.height, chart.bars_colors) }

      @layer_timeline.add(Rubyvis::Layout::Stack)
        .layers(values)
        .x(-> { chart.send(:bars_widths)[self.index] + chart.bars_padding.left })
        .y(->(d) { chart.send(:bars_heights)[d] })
        .layer.add(Rubyvis::Bar)
          .width(bars_widths.range_band - bars_padding.left - bars_padding.right)
          .fillStyle(fill_style_colors)
    end

    def bars_widths
      @bars_widths ||= Rubyvis::Scale.ordinal(Rubyvis.range(values_max_count)).split_banded(0, timeline_width)
    end
  end
end
