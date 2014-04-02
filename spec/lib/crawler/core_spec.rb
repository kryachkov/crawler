require 'spec_helper'
require 'crawler/core'

describe Crawler::Core do
  describe "constants" do
    it "should have MAX_THREADS set to 4" do
      expect(Crawler::Core::MAX_THREADS).to eq(4)
    end

    it "should have MAX_DEPTH set to 3" do
      expect(Crawler::Core::MAX_DEPTH).to eq(3)
    end

    it "should have MAX_PAGES set to 50" do
      expect(Crawler::Core::MAX_PAGES).to eq(50)
    end
  end

  describe "#initialize" do
    it "should assign base_url" do
      expect(Crawler::Core.new('http://google.com').base_url).to eq('http://google.com')
    end

    context "options values" do
      it "should assign default values if no options given" do
        expect(Crawler::Core.new('http://goo.gl').opts).to eq(
          :max_threads => Crawler::Core::MAX_THREADS,
          :max_depth => Crawler::Core::MAX_DEPTH,
          :max_pages => Crawler::Core::MAX_PAGES
        )
      end

      it "should assign given options values" do
        expect(Crawler::Core.new('http://goo.gl', 1, 2, 3).opts).to eq(
          :max_threads => 1,
          :max_depth => 2,
          :max_pages => 3
        )
      end
    end
  end

  describe "#crawl" do
    pending "should return crawling result"
  end
end
