require_relative 'oald_parser_exception'
require_relative 'page_parser'
require_relative 'formatter'
require_relative 'page_downloader'
require_relative 'word_extractor'

module OaldParser
  class Facade
    def initialize(downloader, parser, formatter, extractor)
      @downloader = downloader
      @parser = parser
      @formatter = formatter
      @extractor = extractor
    end

    def self.create_facade
      downloader = PageDownloader.new('http://www.oup.com/oald-bin/web_getald7index1a.pl')
      parser = PageParser.new
      formatter = Formatter.new(lines: 15)
      extractor = WordExtractor.new
      Facade.new(downloader, parser, formatter, extractor)
    end

    def describe(args)
      word = get_word(args)
      raise OaldParserException.new(OaldParserException::INTERNAL) unless word 

      page = @downloader.download(word)
      raise OaldParserException.new(OaldParserException::NET) unless page

      parsed = @parser.parse(page)
      raise OaldParserException.new(OaldParserException::PARSER)  unless parsed

      formatted = @formatter.format(parsed)
      raise OaldParserException.new(OaldParserException::FORMATTER) unless formatted

      formatted
    end

    private
    def get_word(args)
       if args[:word]
        args[:word]
      elsif args[:str]
        @extractor.extract(args[:str])
      end
    end
  end
end