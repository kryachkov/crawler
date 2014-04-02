require 'spec_helper'
require 'crawler/result_handler'

describe Crawler::ResultHandler do
  describe "#initialize" do
    let(:raw_results) { { :foo => 'bar' } }

    it "should assign raw_results" do
      expect(Crawler::ResultHandler.new(raw_results).raw_results).to eq(raw_results)
    end
  end

  describe "#converted_result_hash" do
    let(:raw_results) do
      [{:url=>"http://localhost:3000", :depth=>1, :child_urls=>["http://localhost:3000/home/products", "http://localhost:3000/home/contacts", "http://localhost:3000/home/faq"], :input_count=>3}, {:url=>"http://localhost:3000/home/products", :depth=>2, :child_urls=>["http://localhost:3000/home/good_products", "http://localhost:3000/home/bad_products"], :input_count=>6}, {:url=>"http://localhost:3000/home/contacts", :depth=>2, :child_urls=>["http://localhost:3000/home/map"], :input_count=>2}, {:url=>"http://localhost:3000/home/faq", :depth=>2, :child_urls=>["http://localhost:3000/home/questions"], :input_count=>2}, {:url=>"http://localhost:3000/home/good_products", :depth=>3, :child_urls=>[], :input_count=>2}, {:url=>"http://localhost:3000/home/bad_products", :depth=>3, :child_urls=>[], :input_count=>1}, {:url=>"http://localhost:3000/home/map", :depth=>3, :child_urls=>[], :input_count=>1}, {:url=>"http://localhost:3000/home/questions", :depth=>3, :child_urls=>["http://localhost:3000/home/answers"], :input_count=>5}]
    end

    let(:converted_result_hash) do
      {
        "http://localhost:3000" => 13,
        "http://localhost:3000/home/products" => 9,
        "http://localhost:3000/home/contacts" => 3,
        "http://localhost:3000/home/faq" => 7,
        "http://localhost:3000/home/good_products" => 2,
        "http://localhost:3000/home/bad_products" => 1,
        "http://localhost:3000/home/map" => 1,
        "http://localhost:3000/home/questions" => 5
      }
    end

    it "should convert raw results to url => input_count hash" do
      expect(Crawler::ResultHandler.new(raw_results).converted_result_hash).to eq(converted_result_hash)
    end
  end

  describe "#print" do
    let(:result_handler) { Crawler::ResultHandler.new({}) }

    before { allow(result_handler).to receive(:converted_result_hash) { { 'http://google.com' => 5 } } }

    it "should call puts for each converted_result_hash item" do
      expect(result_handler).to receive(:puts).with('http://google.com - 5 input(s)')
      result_handler.print
    end
  end
end
