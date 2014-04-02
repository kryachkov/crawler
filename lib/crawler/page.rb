require 'nokogiri'

module Crawler
  class Page
    attr_reader :url, :source_code, :depth

    def initialize(url, depth)
      @url = url
      @depth = depth
    end

    def fetch
      @source_code = Nokogiri::HTML(RestClient.get(url))
      self
    end

    def child_urls
      @child_urls ||= get_child_urls
    end

    def info
      {
        :url => url,
        :depth => depth,
        :child_urls => child_urls,
        :input_count => input_count
      }
    end

    private

    def input_count
      source_code.css('input').size
    end

    def get_child_urls
      all_urls = source_code.css('a').map { |link| link.attr('href') }.uniq
      all_urls.delete(url)
      all_urls
    end
  end
end
