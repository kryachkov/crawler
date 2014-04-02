require 'spec_helper'
require 'crawler'

describe Crawler do
  describe ".crawl" do
    let(:core) { double(:crawl => [{ :foo => 'bar' }]) }

    before { allow(Crawler::Core).to receive(:new) { core } }

    it "should initialize new Crawler::Core" do
      expect(Crawler::Core).to receive(:new).with('http://google.com') { core }
      Crawler.crawl('http://google.com')
    end

    it "should call crawl on Core instance" do
      expect(core).to receive(:crawl)
      Crawler.crawl('http://google.com')
    end

    it "should return crawling result" do
      expect(Crawler.crawl('http://google.com')).to eq([{ :foo => 'bar' }])
    end
  end
end
