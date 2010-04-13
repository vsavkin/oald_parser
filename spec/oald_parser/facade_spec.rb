require "spec"
require_relative '../../lib/oald_parser/facade'

include OaldParser

describe Facade do

  before(:each) do
    @downloader = mock('downloader')
    @parser = mock('parser')
    @formatter = mock('formatter')
    @extractor = mock('extractor')
    @facade = OaldParser::Facade.new(@downloader, @parser, @formatter, @extractor)
  end

  it "should download page, parse and format it" do
    @downloader.should_receive(:download).with('dog').and_return('page_content')
    @parser.should_receive(:parse).with('page_content').and_return('parsed_page')
    @formatter.should_receive(:format).with('parsed_page').and_return('description')

    @facade.describe(word: 'dog').should == 'description'
  end

  it "should return nil if we can't download page" do
    @downloader.should_receive(:download).with('dog').and_return(nil)
    lambda {@facade.describe(word: 'dog')}.should raise_error(OaldParserException)
  end

  it "should return nil if we can't parse page" do
    @downloader.should_receive(:download).with('dog').and_return('page_content')
    @parser.should_receive(:parse).with('page_content').and_return(nil)
    lambda {@facade.describe(word: 'dog')}.should raise_error(OaldParserException)
  end

  it "should return nil if we can't format page" do
    @downloader.should_receive(:download).with('dog').and_return('page_content')
    @parser.should_receive(:parse).with('page_content').and_return('parsed_page')
    @formatter.should_receive(:format).with('parsed_page').and_return(nil)
    lambda {@facade.describe(word: 'dog')}.should raise_error(OaldParserException)
  end

  it "should preprocess string if word is not specified" do
    @extractor.should_receive(:extract).with('a dog').and_return('dog')
    @downloader.should_receive(:download).with('dog').and_return('page_content')
    @parser.should_receive(:parse).with('page_content').and_return('parsed_page')
    @formatter.should_receive(:format).with('parsed_page').and_return('description')
    @facade.describe(str: 'a dog').should == 'description'
  end
end