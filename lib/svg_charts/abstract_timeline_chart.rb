module SvgCharts
  class AbstractTimelineChart < AbstractChart
    module DefaultArguments
      Y_SCALE_MAX = nil
      NUMBERS_FORMATTER = ->(number) { number.to_s }
      NUMBERS_COLOR = '#000000'.freeze
      NUMBERS_FONT = '10px sans-serif'.freeze
      TITLE_TEXT = nil
      TITLE_COLOR = '#000000'.freeze
      TITLE_FONT = '10px sans-serif'.freeze
      DATES_FORMATTER = ->(timestamp) { Time.at(timestamp).day.to_s }
      DATES_COLOR = '#000000'.freeze
      DATES_FONT = '10px sans-serif'.freeze
      MARKS = [].freeze
      MARKS_FORMATTER = ->(string) { string }
      MARKS_FONT = '10px sans-serif'.freeze
      MARKS_COLOR = '#000000'.freeze
      RULES_COLOR = '#dfdfdf'.freeze
      RULES_COUNT = 5
      WEEKEND_BAR_COLOR = '#f2f2f2'.freeze
      TIMELINE_WIDTH_RATIO = 0.9
      DATES_HEIGHT_RATIO = 1.0 / 9.0
      MARKS_HEIGHT_RATIO = 0
      LEGEND_TITLES = [].freeze
      LEGEND_COLORS = [].freeze
      LEGEND_TEXT_COLOR = '#000000'.freeze
      LEGEND_FONT = '10px sans-serif'.freeze
      LEGEND_SHAPE = 'square'
      LEGEND_CHARS = []
      THRESHOLD_NUMBER = nil
      THRESHOLD_COLOR = '#0e74eb'
      THRESHOLD_WIDTH = 2
      THRESHOLD_CAPTION = nil
    end

    EXTRA_WEEKEND_BARS_WIDTH = 0.2
    TITLE_TOP_INDENT = -15

    attr_reader :dates, :marks,
                :y_scale_max, :numbers_formatter, :numbers_color, :numbers_font,
                :title_text, :title_color, :title_font,
                :dates_formatter, :dates_color, :dates_font,
                :marks_color, :marks_formatter, :marks_font,
                :rules_color, :rules_count,
                :weekend_bar_color,
                :timeline_width_ratio, :dates_height_ratio, :marks_height_ratio,
                :legend_titles, :legend_colors, :legend_text_color, :legend_font, :legend_shape, :legend_chars,
                :custom_legend_offset,
                :threshold_number, :threshold_color, :threshold_width, :threshold_caption,
                :layer_numbers, :layer_title, :layer_dates, :layer_marks, :layer_timeline, :layer_legend

    def initialize(
      dates:,
      marks: DefaultArguments::MARKS,
      y_scale_max: DefaultArguments::Y_SCALE_MAX,
      numbers_formatter: DefaultArguments::NUMBERS_FORMATTER,
      numbers_color: DefaultArguments::NUMBERS_COLOR,
      numbers_font: DefaultArguments::NUMBERS_FONT,
      title_text: DefaultArguments::TITLE_TEXT,
      title_color: DefaultArguments::TITLE_COLOR,
      title_font: DefaultArguments::TITLE_FONT,
      dates_formatter: DefaultArguments::DATES_FORMATTER,
      dates_color: DefaultArguments::DATES_COLOR,
      dates_font: DefaultArguments::DATES_FONT,
      marks_color: DefaultArguments::MARKS_COLOR,
      marks_font: DefaultArguments::MARKS_FONT,
      marks_formatter: DefaultArguments::MARKS_FORMATTER,
      rules_color: DefaultArguments::RULES_COLOR,
      rules_count: DefaultArguments::RULES_COUNT,
      weekend_bar_color: DefaultArguments::WEEKEND_BAR_COLOR,
      timeline_width_ratio: DefaultArguments::TIMELINE_WIDTH_RATIO,
      dates_height_ratio: DefaultArguments::DATES_HEIGHT_RATIO,
      marks_height_ratio: DefaultArguments::MARKS_HEIGHT_RATIO,
      legend_titles: DefaultArguments::LEGEND_TITLES,
      legend_colors: DefaultArguments::LEGEND_COLORS,
      legend_text_color: DefaultArguments::LEGEND_TEXT_COLOR,
      legend_font: DefaultArguments::LEGEND_FONT,
      legend_shape: DefaultArguments::LEGEND_SHAPE,
      legend_chars: DefaultArguments::LEGEND_CHARS,
      custom_legend_offset: nil,
      threshold_number: DefaultArguments::THRESHOLD_NUMBER,
      threshold_color: DefaultArguments::THRESHOLD_COLOR,
      threshold_width: DefaultArguments::THRESHOLD_WIDTH,
      threshold_caption: DefaultArguments::THRESHOLD_CAPTION,
      **other
    )
      super(other)

      @dates = dates
      @marks = marks
      @y_scale_max = y_scale_max
      @numbers_formatter = numbers_formatter
      @numbers_color = numbers_color
      @numbers_font = numbers_font
      @title_text = title_text
      @title_color = title_color
      @title_font = title_font
      @dates_formatter = dates_formatter
      @dates_color = dates_color
      @marks_color = marks_color
      @marks_formatter = marks_formatter
      @marks_font = marks_font
      @rules_color = rules_color
      @rules_count = rules_count
      @weekend_bar_color = weekend_bar_color
      @timeline_width_ratio = timeline_width_ratio
      @dates_height_ratio = dates_height_ratio
      @marks_height_ratio = marks_height_ratio
      @legend_titles = legend_titles
      @legend_colors = legend_colors
      @legend_text_color = legend_text_color
      @legend_font = legend_font
      @legend_shape = legend_shape
      @legend_chars = legend_chars
      @dates_font = dates_font
      @custom_legend_offset = custom_legend_offset
      @threshold_number = threshold_number
      @threshold_color = threshold_color
      @threshold_width = threshold_width
      @threshold_caption = threshold_caption

      initialize_layers!

      initialize_weekend_bars!
      initialize_numbers!
      initialize_rules!
      initialize_title!
      initialize_dates!
      initialize_marks!
      initialize_threshold!
      initialize_legend!
    end

    def numbers_width
      inner_box_width - timeline_width
    end

    def numbers_height
      timeline_height
    end

    def title_width
      numbers_width
    end

    def title_height
      dates_height
    end

    def dates_width
      timeline_width
    end

    def dates_height
      inner_box_height * dates_height_ratio
    end

    def marks_height
      inner_box_height * marks_height_ratio
    end

    def marks_width
      timeline_width
    end

    def timeline_width
      inner_box_width * timeline_width_ratio
    end

    def timeline_height
      inner_box_height - dates_height - legend_height - marks_height
    end

    def legend_width
      timeline_width
    end

    def legend_height
      legend_titles.any? ? dates_height : 0
    end

    protected

    def values_max
      @values_max ||= values.flatten.max
    end

    def values_max_count
      @values_max_count ||= values.map(&:length).max
    end

    def numbers_max
      y_scale_max || values_max
    end

    def numbers_range
      @numbers_range ||= if need_extra_tick?
                           Rubyvis::Scale.linear(0, numbers_range_ticks.last + numbers_range_ticks[1])
                             .range(0, timeline_height)
                         else
                           numbers_scaled_heights
                         end
    end

    def numbers_scaled_heights
      @numbers_scaled_heights ||= Rubyvis::Scale.linear(0, numbers_max).range(0, timeline_height)
    end

    def numbers_range_ticks
      @numbers_range_ticks ||= numbers_scaled_heights.ticks(rules_count)
    end

    private

    def initialize_layers!
      @layer_title    = create_layer(width: title_width, height: title_height, left: 0, top: 0)

      @layer_marks    = create_layer(width: marks_width,    height: marks_height,    top: 0,                              right: 0)
      @layer_numbers  = create_layer(width: numbers_width,  height: numbers_height,  top: marks_height,                   left:  0)
      @layer_timeline = create_layer(width: timeline_width, height: timeline_height, top: marks_height,                   right: 0)
      @layer_dates    = create_layer(width: dates_width,    height: dates_height,    top: marks_height + timeline_height, right: 0)
      @layer_legend   = create_layer(width: legend_width,   height: legend_height,   bottom: 0,                           right: 0)
    end

    def create_layer(width:, height:, top: nil, right: nil, bottom: nil, left: nil)
      parent_layer.panel
        .width(width)
        .height(height)
        .top(top)
        .right(right)
        .bottom(bottom)
        .left(left)
    end

    def initialize_weekend_bars!
      chart = self

      bar_left_indent = -> { index * chart.send(:weekend_bars_range).range_band }
      fill_style_colors = ->(timestamp) { chart.send(:weekend_bars_colors, timestamp) }

      layer_timeline.add(Rubyvis::Bar)
        .data(dates)
        .width(weekend_bars_range.range_band + EXTRA_WEEKEND_BARS_WIDTH)
        .height(timeline_height + dates_height)
        .left(bar_left_indent)
        .bottom(-dates_height)
        .fillStyle(fill_style_colors)
    end

    def initialize_numbers!
      numbers_rules = layer_numbers.rule
        .data(numbers_ticks)
        .right(0)
        .width(0)
        .bottom(numbers_range)

      numbers_rules.add(Rubyvis::Label)
        .text(numbers_formatter)
        .textAlign('right')
        .textBaseline('middle')
        .font(numbers_font)
        .textStyle(numbers_color)
    end

    def initialize_rules!
      layer_timeline.rule
        .data(rules_ticks)
        .left(0)
        .right(0)
        .bottom(rules_range)
        .strokeStyle(rules_color)
    end

    def initialize_title!
      return if title_text.nil?

      layer_title.add(Rubyvis::Label)
        .text(title_text)
        .top(TITLE_TOP_INDENT)
        .left(0)
        .textBaseline('middle')
        .font(title_font)
        .textStyle(title_color)
    end

    def initialize_dates!
      chart = self

      label_left_indent = -> { index * chart.send(:dates_range).range_band }

      dates_panels = layer_dates.panel
        .data(dates)
        .width(dates_range.range_band)
        .left(label_left_indent)

      dates_panels.add(Rubyvis::Label)
        .text(dates_formatter)
        .textAlign('center')
        .textBaseline('middle')
        .font(dates_font)
        .textStyle(dates_color)
    end

    def initialize_marks!
      return if marks.empty?

      chart = self

      label_left_indent = -> { index * chart.send(:marks_range).range_band }

      marks_panels = layer_marks.panel
        .data(marks)
        .width(marks_range.range_band)
        .left(label_left_indent)

      marks_panels.add(Rubyvis::Label)
        .text(marks_formatter)
        .textAlign('center')
        .textBaseline('middle')
        .font(marks_font)
        .textStyle(marks_color)
    end

    def initialize_threshold!
      return if threshold_number.nil?

      scaled_threshold = threshold_number * timeline_height / numbers_ticks.last

      threshold_rule = layer_timeline.rule
        .left(0)
        .right(0)
        .bottom(scaled_threshold)
        .strokeStyle(threshold_color)
        .lineWidth(threshold_width)

      threshold_rule.add(Rubyvis::Label)
        .left(timeline_width)
        .text(threshold_caption)
        .textAlign('left')
        .textBaseline('middle')
        .font(numbers_font)
        .textStyle(numbers_color)
    end

    def initialize_legend!
      return if legend_titles.empty?

      chart = self

      legend_left_indent = -> { index * chart.send(:legend_range).range_band }
      legend_text = -> { chart.send(:legend_titles)[self.parent.index] }
      legend_color = -> { chart.send(:legend_colors)[self.parent.index] }

      legend_panels = layer_legend.panel
        .data(legend_titles)
        .top(10)
        .width(legend_range.range_band)
        .left(legend_left_indent)

      if legend_chars.blank?
        legend_panels.add(Rubyvis::Dot)
          .shape(legend_shape)
          .left(5)
          .fillStyle(legend_color)
          .strokeStyle(legend_color)
      else
        legend_char = -> { chart.send(:legend_chars)[self.parent.index] }

        legend_panels.add(Rubyvis::Label)
          .text(legend_char)
          .left(-3)
          .textAlign('left')
          .textStyle(legend_color)
          .textBaseline('middle')
          .font(legend_font)
      end

      legend_panels.add(Rubyvis::Label)
        .text(legend_text)
        .left(10)
        .textStyle(legend_text_color)
        .textBaseline('middle')
        .font(legend_font)
    end

    def numbers_ticks
      ticks = numbers_range_ticks.length
      ticks += 1 if need_extra_tick?
      numbers_range.ticks(ticks)
    end

    def rules_range
      numbers_range
    end

    def rules_ticks
      numbers_ticks
    end

    def weekend_bars_range
      dates_range
    end

    def graph_width
      @graph_width ||= Rubyvis::Scale.linear(0, dates.length).range(0, timeline_width)
    end

    def dates_range
      @dates_range ||= Rubyvis::Scale.ordinal(Rubyvis.range(dates.length)).split_banded(0, dates_width)
    end

    def marks_range
      dates_range
    end

    def legend_range
      @legend_range ||= Rubyvis::Scale.ordinal(Rubyvis.range(legend_titles.length)).split_banded(0, custom_legend_width)
    end

    def custom_legend_width
      custom_legend_offset ? legend_width - custom_legend_offset : legend_width
    end

    def bars_heights
      @bars_heights ||= numbers_range
    end

    def need_extra_tick?
      numbers_max > numbers_range_ticks.last
    end

    def weekend_bars_colors(timestamp)
      time = Time.at(timestamp)
      weekend_bar_color if time.sunday? || time.saturday?
    end

    def bars_colors_iterator(index, height, colors)
      colors[index % colors.length] if height.nonzero?
    end
  end
end
