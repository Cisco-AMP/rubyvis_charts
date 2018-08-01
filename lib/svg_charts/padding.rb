module SvgCharts
  class Padding
    DEFAULT_PADDING = 0

    attr_reader :top, :right, :bottom, :left

    def initialize(
      top: DEFAULT_PADDING,
      right: DEFAULT_PADDING,
      bottom: DEFAULT_PADDING,
      left: DEFAULT_PADDING
    )
      @top = top
      @right = right
      @bottom = bottom
      @left = left
    end
  end
end
