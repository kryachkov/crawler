require 'spec_helper'
require 'crawler/page'
require 'rest_client'

describe Crawler::Page do
  let(:googlecom_source) { File.open(File.expand_path('../../../support/google.com.html', __FILE__)).read }

  describe "#initialize" do
    it "should assign url" do
      expect(Crawler::Page.new('http://google.com', 0).url).to eq('http://google.com')
    end

    it "should assign depth" do
      expect(Crawler::Page.new('http://google.com', 0).depth).to eq(0)
    end
  end

  describe "#fetch" do
    let(:page) { Crawler::Page.new('http://google.com', 0) }

    before { allow(RestClient).to receive(:get) { googlecom_source } }

    it "should fetch url with RestClient" do
      expect(RestClient).to receive(:get).with('http://google.com') { googlecom_source }
      page.fetch
    end

    it "should parse fetched sourse with Nokogiri" do
      expect(Nokogiri).to receive(:HTML).with(googlecom_source)
      page.fetch
    end

    it "should assign source_code" do
      parsed_html = double
      allow(Nokogiri).to receive(:HTML) { parsed_html }
      page.fetch
      expect(page.source_code).to eq(parsed_html)
    end

    it "should return self" do
      expect(page.fetch).to eq(page)
    end
  end

  describe "#child_urls" do
    let(:page) { Crawler::Page.new('http://google.com', 0) }

    before do
      allow(RestClient).to receive(:get) { googlecom_source }
      page.fetch
    end

    it "should return array of urls page refers to w/o self" do
      expect(page.child_urls).to eq(%w(http://google.com/maps /drive))
    end
  end

  describe "#info" do
    let(:page) { Crawler::Page.new('http://google.com', 0) }

    before do
      allow(RestClient).to receive(:get) { googlecom_source }
      page.fetch
    end

    it "should return hash of info" do
      expect(page.info).to eq(
        :url => 'http://google.com',
        :depth => 0,
        :child_urls => %w(http://google.com/maps /drive),
        :input_count => 2
      )
    end
  end
end
