require 'crawler/core'

module Crawler
  def Crawler.crawl(url, threads = nil, depth = nil, pages = nil)
    Core.new(url, threads, depth, pages).crawl
  end
end
