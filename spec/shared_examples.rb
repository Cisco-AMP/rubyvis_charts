RSpec.shared_examples :abstract_chart do
  let(:values) { [1, 2, 3, 4, 5, 6, 7, 8] }
  let(:width) { 200 }
  let(:height) { 150 }
  let(:padding) { RubyvisCharts::Padding.new(top: 5, right: 10, bottom: 15, left: 20 ) }

  let(:abstract_chart_args) { { values: values, width: width, height: height, padding: padding } }

  let(:constructor_args) { { **abstract_chart_args, **abstract_timeline_chart_args, **args } }

  subject { described_class.new(constructor_args) }

  describe '#initialize' do
    it 'sets @inner_box_width to the difference between @width and @padding.right and @padding.left' do
      expect(subject.inner_box_width).to eq 170
    end

    it 'sets @inner_box_height to the difference between @height and @padding.top and @padding.bottom' do
      expect(subject.inner_box_height).to eq 130
    end

    it 'sets the @parent_layer' do
      expect(subject.parent_layer).to be
    end
  end

  describe '#render' do
    let(:output)            { subject.render }
    let(:output_parsed)     { Nokogiri::XML(output) }
    let(:output_children)   { output_parsed.children }
    let(:output_child_name) { output_children.first.name }

    it 'returns correct svg' do
      expect(output_children.length).to eq(1)
      expect(output_child_name).to eq('svg')
    end
  end
end

RSpec.shared_examples :abstract_timeline_chart do
  include_examples :abstract_chart

  let(:dates) { (('2018.01.01'.to_date)..('2018.01.07'.to_date)).map { |date| date.to_time.to_i } }
  let(:numbers_formatter) { -> (number) { number.to_s } }
  let(:numbers_color) { '#2e1616' }
  let(:numbers_font) { '10px sans-serif' }
  let(:title_text) { 'Timeline Chart' }
  let(:title_color) { '#1d8dcd' }
  let(:title_font) { '10px sans-serif' }
  let(:dates_formatter) { -> (timestamp) { timestamp.to_s } }
  let(:dates_height_ratio) { 0.1 }
  let(:dates_color) { '#d2b214' }
  let(:dates_font) { '10px sans-serif' }
  let(:rules_color) { '#bababa' }
  let(:rules_count) { 6 }
  let(:weekend_bar_color) { '#e9e9e9' }
  let(:timeline_width_ratio) { 0.7 }
  let(:marks_height_ratio) { 0.1 }

  let(:abstract_timeline_chart_args) do
    {
      dates: dates,
      numbers_formatter: numbers_formatter,
      numbers_color: numbers_color,
      numbers_font: numbers_font,
      title_text: title_text,
      title_color: title_color,
      title_font: title_font,
      dates_formatter: dates_formatter,
      dates_color: dates_color,
      dates_font: dates_font,
      rules_color: rules_color,
      rules_count: rules_count,
      weekend_bar_color: weekend_bar_color,
      timeline_width_ratio: timeline_width_ratio,
      dates_height_ratio: dates_height_ratio,
      marks_height_ratio: marks_height_ratio
    }
  end

  describe '#initialize' do
    it 'initializes the @layer_numbers' do
      expect(subject.layer_numbers).to be
    end

    it 'initializes the @layer_title' do
      expect(subject.layer_title).to be
    end

    it 'initializes the @layer_dates' do
      expect(subject.layer_dates).to be
    end

    it 'initializes the @layer_timeline' do
      expect(subject.layer_timeline).to be
    end

    it 'initializes the @layer_marks' do
      expect(subject.layer_marks).to be
    end
  end

  describe '#timeline_width' do
    it 'returns @inner_box_width scaled by @timeline_width_ratio' do
      expect(subject.timeline_width).to be_within(0.1).of(119)
    end
  end

  describe '#timeline_height' do
    it 'returns the difference between @inner_box_height and #dates_height and #marks_height' do
      expect(subject.timeline_height.to_i).to eq 104
    end
  end

  describe '#marks_height' do
    it 'returns @inner_box_width scaled by @marks_height_ratio' do
      expect(subject.marks_height.to_i).to eq 13
    end
  end

  describe '#marks_width' do
    it 'returns the same as timeline_width' do
      expect(subject.marks_width).to eq(subject.timeline_width)
    end
  end

  describe '#dates_width' do
    it 'returns the same as #timeline_width' do
      expect(subject.dates_width).to eq(subject.timeline_width)
    end
  end

  describe '#dates_height' do
    it 'returns @inner_box_height scaled by @dates_height_ratio' do
      expect(subject.dates_height.to_i).to eq 13
    end
  end

  describe '#numbers_width' do
    it 'returns the difference between @inner_box_width and #timeline_width' do
      expect(subject.numbers_width).to be_within(0.1).of(51)
    end
  end

  describe '#numbers_height' do
    it 'returns the same as #timeline_height' do
      expect(subject.numbers_height).to eq(subject.timeline_height)
    end
  end

  describe '#title_width' do
    it 'returns the same as #numbers_width' do
      expect(subject.title_width).to eq(subject.numbers_width)
    end
  end

  describe '#title_height' do
    it 'returns the same as #dates_height' do
      expect(subject.title_height).to eq(subject.dates_height)
    end
  end

  describe '#legend_width' do
    it 'returns the same as #timeline_width' do
      expect(subject.legend_width).to eq(subject.timeline_width)
    end
  end

  describe '#legend_height' do
    it 'returns the same as #dates_height if any legend_titles present' do
      allow(subject).to receive(:legend_titles).and_return(['title'])
      expect(subject.legend_height).to eq(subject.dates_height)
    end

    it 'returns zero if none legend_titles present' do
      expect(subject.legend_height).to eq(0)
    end
  end

  describe '#need_extra_tick?' do
    before { allow(subject).to receive(:numbers_range_ticks).and_return([20, 40, 60]) }

    context 'when max number greater than max tick' do
      before { allow(subject).to receive(:numbers_max).and_return(66) }

      it 'returns true when max number bigger than max tick' do
        expect(subject.send(:need_extra_tick?)).to eql true
      end
    end

    context 'when max number less than max tick' do
      before { allow(subject).to receive(:numbers_max).and_return(55) }

      it 'returns false when max number less than max tick' do
        expect(subject.send(:need_extra_tick?)).to eql false
      end
    end
  end

  describe '#weekend_bars_colors' do
    it 'returns weekend bar color when it is sunday or saturday' do
      expect(subject.send(:weekend_bars_colors, '10.06.2018'.to_datetime.to_i)).to eq(weekend_bar_color)
    end

    it 'returns nil when it is not sunday or saturday' do
      expect(subject.send(:weekend_bars_colors, '11.06.2018'.to_datetime.to_i)).to eq(nil)
    end
  end

  describe '#bars_colors_iterator' do
    let(:colors) { %w(red blue) }

    it 'returns color by index when bar height bigger than zero' do
      expect(subject.send(:bars_colors_iterator, 0, 1, colors)).to eq(colors.first)
      expect(subject.send(:bars_colors_iterator, 1, 1, colors)).to eq(colors[1])
    end

    it 'returns nil when bar height equal zero' do
      expect(subject.send(:bars_colors_iterator, 1, 0, colors)).to eq(nil)
    end
  end
end
