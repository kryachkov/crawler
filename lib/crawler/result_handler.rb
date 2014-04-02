module Crawler
  class ResultHandler
    attr_reader :raw_results

    def initialize(raw_results)
      @raw_results = raw_results
    end

    def converted_result_hash
      raw_results.inject({}) do |a, page|
        a[page[:url]] = count_inputs_for(page)
        a
      end
    end

    def print
      converted_result_hash.each { |url, count| puts "#{ url } - #{ count } input(s)"}
    end

    private

    def count_inputs_for(page)
      raw_results
        .select { |e| page[:child_urls].include?(e[:url])}
        .inject(page[:input_count]) { |a, child_page| a += child_page[:input_count] }
    end
  end
end
