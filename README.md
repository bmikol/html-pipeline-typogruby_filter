# HTML::Pipeline::TypogrubyFilter

[![Build Status](https://travis-ci.org/bmikol/html-pipeline-typogruby_filter.svg?branch=master)](https://travis-ci.org/bmikol/html-pipeline-typogruby_filter)

[Typogruby](https://github.com/avdgaag/typogruby) integration for [HTML::Pipeline](https://github.com/jch/html-pipeline). 

Currently, all Typogruby's filter options are enabled; future version to add options with a context hash.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'html-pipeline-typogruby_filter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install html-pipeline-typogruby_filter

## Usage

```ruby
require 'html/pipeline'
require 'html/pipeline/typogruby_filter'

pipeline = HTML::Pipeline.new [
  HTML::Pipeline::MarkdownFilter,
  HTML::Pipeline::TypogrubyFilter
]

input = %(Food for Thought & HTML Test:

"Someone asked, 'Do we need so many typefaces?' I replied,
Do we need so many books? Do we need another painting? Do we need so many songs? Do we need another movie?" -- Bill Dawson)

result = pipeline.call(input)

puts result[:output]
```

Prints:

```html
<p>Food for Thought <span class="amp">&amp;</span> <span class="caps">HTML</span>&nbsp;Test:</p>

<p><span class="dquo">&#8220;</span>Someone asked, &#8216;Do we need so many typefaces?&#8217; I replied,<br>
Do we need so many books? Do we need another painting? Do we need so many songs? Do we need another movie?&#8221; &#8211; Bill&nbsp;Dawson</p>
```

## Contributing

1. Fork it ( https://github.com/bmikol/html-pipeline-typogruby_filter/fork )
2. Create your featur e branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Bug reports welcome.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).