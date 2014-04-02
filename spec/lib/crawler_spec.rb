require 'spec_helper'
require 'crawler'

describe Crawler do
  describe ".crawl" do
    let(:core) { double(:crawl => [{ :foo => 'bar' }]) }

    before { allow(Crawler::Core).to receive(:new) { core } }

    context "when additional options given" do
      it "should initialize new Crawler::Core with given options" do
        expect(Crawler::Core).to receive(:new).with('http://google.com', 1, 2 ,3) { core }
        Crawler.crawl('http://google.com', 1, 2, 3)
      end
    end

    context "when no additional options given" do
      it "should initialize new Crawler::Core with nil values of options" do
        expect(Crawler::Core).to receive(:new).with('http://google.com', nil, nil, nil) { core }
        Crawler.crawl('http://google.com')
      end
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
