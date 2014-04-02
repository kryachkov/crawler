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
  end

  describe "#crawl" do
    pending "should return crawling result"
  end
end
