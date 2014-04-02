require 'crawler/worker'

describe Crawler::Worker do
  let(:urls) { [:end, { :url => 'http://google.com', :depth => 0 }] }
  let(:pages) { [] }

  describe "#initialize" do
    it "should assign url_queue" do
      expect(Crawler::Worker.new(urls, pages).url_queue).to eq(urls)
    end

    it "should assign page_queue" do
      expect(Crawler::Worker.new(urls, pages).page_queue).to eq(pages)
    end
  end

  describe "#perform" do
    let(:page) { double }
    let(:worker) { Crawler::Worker.new(urls, pages) }

    before do
      allow(Crawler::Page).to receive(:new) { page }
      allow(page).to receive(:fetch) { page }
    end

    it "should initialize new page with url in url queue" do
      expect(Crawler::Page).to receive(:new).with('http://google.com', 0) { page }
      worker.perform
    end

    it "should fetch Page" do
      expect(page).to receive(:fetch) { page }
      worker.perform
    end

    it "should push Page to page_queue" do
      worker.perform
      expect(pages).to include(page)
    end
  end
end
