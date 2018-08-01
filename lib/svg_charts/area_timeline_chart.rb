module SvgCharts
  class AreaTimelineChart < AbstractTimelineChart
    module DefaultArguments
      AREAS_COLORS = %w[#4d79da #31d49e].freeze
    end

    LONG_MONTH_PADDING = 20
    LONG_MONTH_DAYS = 31

    attr_reader :areas_colors

    def initialize(
      areas_colors: DefaultArguments::AREAS_COLORS,
      **other
    )
      super(other)

      @areas_colors = areas_colors

      initialize_areas!
    end

    private

    def initialize_areas!
      chart = self

      area_left_offset = -> { chart.send(:graph_width).scale(self.index) + chart.send(:graph_width).scale(1)/2 }
      height = ->(d) { chart.send(:bars_heights).scale(d) }

      values.each_with_index do |area, index|
        @layer_timeline.add(Rubyvis::Area)
          .data(area)
          .bottom(0)
          .left(area_left_offset)
          .height(height)
          .fillStyle(areas_colors[index])
      end
    end
  end
end
