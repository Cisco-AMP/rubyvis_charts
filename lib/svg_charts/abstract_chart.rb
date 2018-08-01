require_relative 'padding'

module SvgCharts
  class AbstractChart
    module DefaultArguments
      WIDTH = 400
      HEIGHT = 225
      PADDING = Padding.new
    end

    attr_reader :values, :width, :height, :padding,
                :inner_box_width, :inner_box_height,
                :parent_layer

    def initialize(
      values:,
      width: DefaultArguments::WIDTH,
      height: DefaultArguments::HEIGHT,
      padding: DefaultArguments::PADDING
    )
      @values = values
      @width = width
      @height = height
      @padding = padding

      @inner_box_width = width - padding.left - padding.right
      @inner_box_height = height - padding.top - padding.bottom

      initialize_parent_layer!
    end

    def render
      @parent_layer.render
      @parent_layer.to_svg
    end

    private

    def initialize_parent_layer!
      @parent_layer = Rubyvis::Panel.new
        .width(inner_box_width)
        .height(inner_box_height)
        .top(padding.top)
        .right(padding.right)
        .left(padding.left)
        .bottom(padding.bottom)
    end
  end
end
