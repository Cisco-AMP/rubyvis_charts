module SvgCharts
  class LineTimelineChart < AbstractTimelineChart
    module DefaultArguments
      LINES_COLORS = %w[#4d79da #31d49e].freeze
    end

    LONG_MONTH_PADDING = 20
    LONG_MONTH_DAYS = 31

    attr_reader :lines_colors

    def initialize(
      lines_colors: DefaultArguments::LINES_COLORS,
      **other
    )
      super(other)
      @lines_colors = lines_colors
      initialize_lines!
    end

    private

    def initialize_lines!
      chart = self

      area_left_offset = -> { chart.send(:graph_width).scale(self.index) + chart.send(:graph_width).scale(1)/2 }
      height = ->(d) { chart.send(:bars_heights).scale(d) }

      values.each_with_index do |line_data, index|
        @layer_timeline.add(Rubyvis::Line)
          .data(line_data)
          .left(area_left_offset)
          .bottom(height)
          .lineWidth(1)
          .strokeStyle(lines_colors[index])
      end
    end
  end
end
