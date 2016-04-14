require "test_helper"
require "html/pipeline/typogruby_filter"
require "typogruby"

class HTML::Pipeline::TypogrubyFilterTest < Minitest::Test
	TypogrubyFilter = HTML::Pipeline::TypogrubyFilter

  def setup
  end
  
  def test_that_it_has_a_version_number
    refute_nil ::HTML_Pipeline::TypogrubyFilter::VERSION
  end

  # &nbsp; occurs between second-to-last word and last word in all test outcomes due to the "widont" functionality that prevents widows.

  def test_regular_ampersand
    filter = TypogrubyFilter.new \
    	"one & two"

    assert_equal %(one <span class="amp">&amp;</span>&nbsp;two),
    filter.call
  end
 
  def test_entity_name_ampersand
    filter = TypogrubyFilter.new \
    	"one &amp; two"

    assert_equal %(one <span class="amp">&amp;</span>&nbsp;two),
    filter.call
  end

  def test_entity_number_ampersand
    filter = TypogrubyFilter.new \
    	"one &#38; two"

    assert_equal %(one <span class="amp">&amp;</span>&nbsp;two),
    filter.call
  end

  def test_entity_name_ampersand_with_nbsp
    filter = TypogrubyFilter.new \
    	"one&nbsp;&amp;&nbsp;two"

    assert_equal %(one&nbsp;<span class="amp">&amp;</span>&nbsp;two),
    filter.call
  end

  def test_replace_caps
    filter = TypogrubyFilter.new \
    	"HTML and you"

    assert_equal %(<span class="caps">HTML</span> and&nbsp;you),
    filter.call
  end

  def test_replace_caps_in_tags
    filter = TypogrubyFilter.new \
    	%(<a href=".">HTML</a> and you)

    assert_equal %(<a href="."><span class="caps">HTML</span></a> and&nbsp;you),
    filter.call
  end

  def test_replace_primes
    filter = TypogrubyFilter.new \
    	%("with primes")

    assert_equal %(<span class="dquo">&#8220;</span>with&nbsp;primes&#8221;),
    filter.call
  end

  def test_replace_single_primes
    filter = TypogrubyFilter.new \
    	%('with single primes')

    assert_equal %(<span class="quo">&#8216;</span>with single&nbsp;primes&#8217;),
    filter.call
  end

  def test_convert_entities
    filter = TypogrubyFilter.new \
	   	%(Olé! Glögg søster)

    assert_equal %(Ol&eacute;! Gl&ouml;gg&nbsp;s&oslash;ster),
    filter.call
  end

  def test_should_not_replace_in_scripts
    filter = TypogrubyFilter.new \
      %(<script>"And then she asked Öllegård, 'What do you think of ODS?'"</script>)

    assert_equal %(<script>"And then she asked Öllegård, 'What do you think of ODS?'"</script>),
    filter.call
  end

  def test_should_not_replace_in_codes
    filter = TypogrubyFilter.new \
      %(<code>"And then she asked Öllegård, 'What do you think of ODS?'"</code>)

    assert_equal %(<code>"And then she asked Öllegård, 'What do you think of ODS?'"</code>),
    filter.call
  end

  def test_should_not_replace_in_kbds
    filter = TypogrubyFilter.new \
      %(<kbd>"And then she asked Öllegård, 'What do you think of ODS?'"</kbd>)

    assert_equal %(<kbd>"And then she asked Öllegård, 'What do you think of ODS?'"</kbd>),
    filter.call
  end

  def test_should_not_replace_in_titles
    filter = TypogrubyFilter.new \
      %(<math>"And then she asked Öllegård, 'What do you think of ODS?'"</math>)

    assert_equal %(<math>"And then she asked Öllegård, 'What do you think of ODS?'"</math>),
    filter.call
  end

  def test_demo_example
    filter = TypogrubyFilter.new \
      %(Food for Thought & HTML Test:

    "Someone asked, 'Do we need so many typefaces?' I replied,
        Do we need so many books? Do we need another painting? Do we need so many songs? Do we need another movie?" -- Bill Dawson)

    assert_equal %(Food for Thought <span class="amp">&amp;</span> <span class="caps">HTML</span>&nbsp;Test:

    <span class="dquo">&#8220;</span>Someone asked, &#8216;Do we need so many typefaces?&#8217; I&nbsp;replied,
        Do we need so many books? Do we need another painting? Do we need so many songs? Do we need another movie?&#8221; &#8211; Bill&nbsp;Dawson),
    filter.call
  end

end
