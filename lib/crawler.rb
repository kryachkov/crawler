require 'crawler/core'

module Crawler
  def Crawler.crawl(url)
    Core.new(url).crawl
  end
end
