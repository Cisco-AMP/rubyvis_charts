module RubyvisCharts
  class DonutChart < AbstractChart
    module DefaultArguments
      CONES_COLORS = ["#cf2030", "#F73000", "#ffcc00", "#64bbe3", "#6cc04a", "#f2f2f2"].freeze

      OUTER_RADIUS = 120
    end

    attr_reader :cones_colors, :outer_radius, :inner_radius, :percentage_key

    def initialize(
      cones_colors: DefaultArguments::CONES_COLORS,
      outer_radius: DefaultArguments::OUTER_RADIUS,
      inner_radius: DefaultArguments::OUTER_RADIUS * 0.7,
      percentage_key: :percentage,
      **other
    )
      super(**other)
      @outer_radius = outer_radius
      @inner_radius = inner_radius
      @cones_colors = cones_colors
      @percentage_key = percentage_key

      initialize_cones!
    end

    private

    def initialize_cones!
      chart = self
      angle = ->(segment_hash) { segment_hash[chart.percentage_key].to_f * 2 * Math::PI }
      fill_style = -> { chart.cones_colors[self.index] || "##{SecureRandom.hex(3)}"}

      parent_layer.add(Rubyvis::Wedge)
        .data(values)
        .left(width / 2)
        .top(height / 2)
        .innerRadius(inner_radius)
        .outerRadius(outer_radius)
        .angle(angle)
        .fillStyle(fill_style)
    end
  end
end
