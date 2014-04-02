require 'crawler/worker'

module Crawler
  class Core
    MAX_THREADS = 4
    MAX_DEPTH = 3
    MAX_PAGES = 50

    attr_reader :base_url

    def initialize(base_url)
      @base_url = base_url
    end

    def crawl
      page_results = []
      workers = []

      url_queue = Queue.new
      page_queue = Queue.new

      crawled_pages = 0

      url_queue.push({ :url => base_url, :depth => 1 })

      MAX_THREADS.times do
        worker = Thread.new { Worker.new(url_queue, page_queue).perform }
        worker.abort_on_exception = true
        workers << worker
      end

      loop do
        page = page_queue.pop
        crawled_pages += 1

        if crawled_pages > MAX_PAGES
          workers.each(&:terminate)
          break
        end

        page_results << page.info
        if should_go_deeper?(page.depth)
          page.child_urls.each { |child| url_queue.push({ :url => child, :depth => (page.depth + 1) }) }
        end

        if page_queue.empty? && url_queue.empty?
          until url_queue.num_waiting == workers.size
            Thread.pass
          end
          if page_queue.empty?
            workers.size.times { url_queue.push(:end) }
            break
          end
        end
      end

      workers.each(&:join)

      page_results
    end

    private

    def should_go_deeper?(depth)
      depth < MAX_DEPTH
    end
  end
end
