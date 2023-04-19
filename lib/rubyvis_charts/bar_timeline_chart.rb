module RubyvisCharts
  class BarTimelineChart < AbstractTimelineChart
    module DefaultArguments
      BARS_PADDING = Padding.new(right: 0.5, left: 0.5)
      BARS_COLORS = ['#4d79da'].freeze
    end

    attr_reader :bars_padding, :bars_colors

    def initialize(
      bars_padding: DefaultArguments::BARS_PADDING,
      bars_colors: DefaultArguments::BARS_COLORS,
      **other
    )
      super(**other)

      @bars_padding = bars_padding
      @bars_colors = bars_colors

      initialize_bars!
    end

    private

    def initialize_bars!
      chart = self

      bar_left_indent = -> { self.index * chart.send(:bars_widths).range_band + chart.bars_padding.left }
      fill_style_colors = -> { chart.send(:bars_colors_iterator, self.index, self.height, chart.bars_colors) }

      @layer_timeline.add(Rubyvis::Bar)
        .data(values)
        .width(bars_widths.range_band - bars_padding.right - bars_padding.left)
        .height(bars_heights)
        .left(bar_left_indent)
        .bottom(0)
        .fillStyle(fill_style_colors)
    end

    def bars_widths
      @bars_widths ||= Rubyvis::Scale.ordinal(Rubyvis.range(values.length)).split_banded(0, timeline_width)
    end
  end
end
