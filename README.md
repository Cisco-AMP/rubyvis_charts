# RubyvisCharts

RubyvisCharts gem is a wrapper around rubyvis gem which allows you to create charts

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubyvis_charts'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubyvis_charts

## Usage

### BarTimelineChart
```
data = {
  :legend_titles => ["Files Scanned", "IPs Scanned"], 
  :values => [81000, 67000, 287000, 174000, 217000, 185000, 280000, 230000, 219000, 138000, 93000, 74000, 89000, 67000], 
  :bars_padding => RubyvisCharts::Padding.new(right: 6, left: 6), 
  :bars_colors => ["#83c9e9", "#5096b6"], 
  :weekend_bar_color => "#ffffff", 
  :dates_height_ratio => 0.1, 
  :legend_colors => ["#83c9e9", "#5096b6"], 
  :dates => [1541980800, 1542067200, 1542153600, 1542240000, 1542326400, 1542412800, 1542499200], 
  :y_scale_max => 287000, 
  :width => 355, 
  :height => 160, 
  :padding => RubyvisCharts::Padding.new(top: 6, bottom: 6)
}

RubyvisCharts::BarTimelineChart.new(data).render
```

<p align="center">
  <img src ="/images/BarTimelineChart.png" width="450"/>
</p>


### GroupedBarTimelineChart
```
data = {
  :legend_titles => ["Files Scanned", "IPs Scanned"], 
  :values => [81000, 67000, 287000, 174000, 217000, 185000, 280000, 230000, 219000, 138000, 93000, 74000, 89000, 67000], 
  :bars_padding => RubyvisCharts::Padding.new(right: 6, left: 6), 
  :bars_colors => ["#83c9e9", "#5096b6"], 
  :weekend_bar_color => "#ffffff", 
  :dates_height_ratio => 0.1, 
  :legend_colors => ["#83c9e9", "#5096b6"], 
  :dates => [1541980800, 1542067200, 1542153600, 1542240000, 1542326400, 1542412800, 1542499200], 
  :y_scale_max => 287000, 
  :width => 355, 
  :height => 160, 
  :padding => RubyvisCharts::Padding.new(top: 6, bottom: 6)
}

RubyvisCharts::GroupedBarTimelineChart.new(data).render
```
<p align="center">
  <img src ="/images/GroupedBarTimelineChart.png" width="450"/>
</p>

### StackedBarTimelineChart
```
data = {
  :legend_titles=>["Active Connectors", "Unseen Connectors"], 
  :values=>[[5310, 2000, 9760, 2100, 7700, 6140, 9070], [106, 700, 41, 249, 800, 700, 44]], 
  :bars_padding=>RubyvisCharts::Padding.new(right: 6, left: 6), 
  :bars_colors=>["#14a792", "#8CB2D4"], 
  :weekend_bar_color=>"#ffffff", 
  :dates_height_ratio=>0.1, 
  :legend_colors=>["#14a792", "#8CB2D4"], 
  :dates=>[1541980800, 1542067200, 1542153600, 1542240000, 1542326400, 1542412800, 1542499200], 
  :y_scale_max=>9801, 
  :width=>355, 
  :height=>160, 
  :padding=>RubyvisCharts::Padding.new(top: 6, bottom: 6)
}

RubyvisCharts::StackedBarTimelineChart.new(data).render
```
<p align="center">
  <img src ="/images/StackedBarTimelineChart.png" width="450"/>
</p>

### LineTimelineChart
```
data = {
  :legend_titles=>["Files Scanned"], 
  :legend_colors=>["#83c9e9"], 
  :lines_colors=>["#83c9e9"], 
  :values=>[[67058, 60843, 48407, 71359, 34323, 57690, 81868, 40042, 65890, 33722, 44754, 73729, 77828, 79634, 43539, 130, 23139, 12948, 21869, 46683, 21286, 50869, 53065, 34532, 29532, 1610, 32371, 5087, 75394, 9621, 7263]], 
  :dates=>[1514764800, 1514851200, 1514937600, 1515024000, 1515110400, 1515196800, 1515283200, 1515369600, 1515456000, 1515542400, 1515628800, 1515715200, 1515801600, 1515888000, 1515974400, 1516060800, 1516147200, 1516233600, 1516320000, 1516406400, 1516492800, 1516579200, 1516665600, 1516752000, 1516838400, 1516924800, 1517011200, 1517097600, 1517184000, 1517270400, 1517356800], 
  :y_scale_max=>81868, 
  :width=>550, 
  :height=>160, 
  :padding=>RubyvisCharts::Padding.new(top: 6, bottom: 20)
}

RubyvisCharts::LineTimelineChart.new(data).render
```
<p align="center">
  <img src ="/images/LineTimelineChart.png" width="450"/>
</p>

### AreaTimelineChart
```
data = {
  :areas_colors=>["#8CB2D4", "#14a792"], 
  :dates_height_ratio=>0.1, 
  :legend_titles=>["Unseen Connectors", "Active Connectors"], 
  :legend_colors=>["#8CB2D4", "#14a792"], 
  :values=>[[1353, 1353, 1326, 1401, 1324, 1327, 1660, 1508, 1519, 1504, 1503, 1513, 1518, 1518, 1580, 1600, 1507, 1500, 1519, 1500, 1640, 1656, 1642, 1632, 1634, 1680, 1694, 1685, 1707, 1697, 1288], [1300, 1300, 1300, 1300, 1300, 1300, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1630, 1630, 1630, 1630, 1630, 1680, 1680, 1680, 1680, 1680, 1253]], 
  :dates=>[1514764800, 1514851200, 1514937600, 1515024000, 1515110400, 1515196800, 1515283200, 1515369600, 1515456000, 1515542400, 1515628800, 1515715200, 1515801600, 1515888000, 1515974400, 1516060800, 1516147200, 1516233600, 1516320000, 1516406400, 1516492800, 1516579200, 1516665600, 1516752000, 1516838400, 1516924800, 1517011200, 1517097600, 1517184000, 1517270400, 1517356800], 
  :y_scale_max=>1707, 
  :width=>550, :height=>160, 
  :padding=>RubyvisCharts::Padding.new(top: 6, bottom: 6)
}

RubyvisCharts::AreaTimelineChart.new(data).render
```
<p align="center">
  <img src ="/images/AreaTimelineChart.png" width="450"/>
</p>

You can use keys dates, marks, y_scale_max, numbers_formatter, numbers_color, numbers_font, title_text, title_color, title_font, dates_formatter, dates_color, dates_font, marks_color, rules_color, rules_count, weekend_bar_color, timeline_width_ratio, dates_height_ratio, marks_height_ratio, legend_titles, legend_colors, legend_text_color, legend_font, legend_shape, legend_chars, custom_legend_offset, threshold_number, threshold_color, threshold_width, threshold_caption
for all timeline charts

### DonatChart
```
data = {
  :values=>[{percentage: 0.18906606}, 
            {percentage: 0.05694761}, 
            {percentage: 0.0501139}, 
            {percentage: 0.04783599}, 
            {percentage: 0.04555809}, 
            {percentage: 0.61047836}], 
  :width=>240, 
  :height=>240, 
  :cones_colors=>["#cf2030", "#F73000", "#ffcc00", "#64bbe3", "#6cc04a", "#f2f2f2"], 
  :outer_radius=>120, 
  :inner_radius=>75
}

RubyvisCharts::DonatChart.new(data).render
```
<p align="center">
  <img src ="/images/DonatChart.png" width="450"/>
</p>


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rubyvis_charts. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RubyvisCharts project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rubyvis_charts/blob/master/CODE_OF_CONDUCT.md).
