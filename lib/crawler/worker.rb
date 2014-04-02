require 'crawler/page'

module Crawler
  class Worker
    attr_reader :page_queue, :url_queue

    def initialize(url_queue, page_queue)
      @url_queue = url_queue
      @page_queue = page_queue
    end

    def perform
      loop do
        url = url_queue.pop
        break if url == :end

        puts "Fetching #{ url[:url] }"
        page_queue.push(Crawler::Page.new(url[:url], url[:depth]).fetch)
      end
    end
  end
end
