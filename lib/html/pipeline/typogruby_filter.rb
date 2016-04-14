require "html/pipeline/typogruby_filter/version"
require "html/pipeline/filter"
require "typogruby"

module HTML
  class Pipeline
    class TypogrubyFilter < Filter
     	
     	# Run Typogruby text filters (all on by default)
    	def call
    		Typogruby.improve(html)
    	end

    end
  end
end
