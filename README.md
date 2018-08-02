# SvgCharts

SvgCharts gem is a wrapper around rubyvis gem which allows you to create charts

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'svg_charts'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install svg_charts

## Usage

```
# available keys: values, width, height, height, padding, bars_padding, bars_colors
SvgCharts::BarTimelineChart.new(data).render
```

```
# available keys: values, width, height, height, padding, bars_padding, bars_colors
SvgCharts::GroupedBarTimelineChart.new(data).render
```

```
# available keys: values, width, height, height, padding, bars_padding, bars_colors
SvgCharts::StackedBarTimelineChart.new(data).render
```

```
# available keys: values, width, height, height, padding, bars_padding, lines_colors
SvgCharts::LineTimelineChart.new(data).render
```

```
# available keys: values, width, height, height, padding, bars_padding, areas_colors
SvgCharts::AreaTimelineChart.new(data).render
```
You can use keys dates, marks, y_scale_max, numbers_formatter, numbers_color, numbers_font, title_text, title_color, title_font, dates_formatter, dates_color, dates_font, marks_color, rules_color, rules_count, weekend_bar_color, timeline_width_ratio, dates_height_ratio, marks_height_ratio, legend_titles, legend_colors, legend_text_color, legend_font, legend_shape, legend_chars, custom_legend_offset, threshold_number, threshold_color, threshold_width, threshold_caption
for all timeline charts

```
# available keys: cones_colors, outer_radius, inner_radius, percentage_key
SvgCharts::DonatChart.new(data).render
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/svg_charts. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SvgCharts project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/svg_charts/blob/master/CODE_OF_CONDUCT.md).
