require_relative 'oald_parser_exception'
require_relative 'page_parser'
require_relative 'formatter'
require_relative 'page_downloader'

module OaldParser
  class Facade
    def initialize(downloader, parser, formatter)
      @downloader = downloader
      @parser = parser
      @formatter = formatter
    end

    def self.create_facade
      downloader = PageDownloader.new('http://www.oup.com/oald-bin/web_getald7index1a.pl')
      parser = PageParser.new
      formatter = Formatter.new(lines: 15)
      Facade.new(downloader, parser, formatter)
    end

    def describe(args)
      word = args[:word]
      raise OaldParserException.new(OaldParserException::INTERNAL) unless word 

      page = @downloader.download(word)
      raise OaldParserException.new(OaldParserException::NET) unless page

      parsed = @parser.parse(page)
      raise OaldParserException.new(OaldParserException::PARSER)  unless parsed

      formatted = @formatter.format(parsed)
      raise OaldParserException.new(OaldParserException::FORMATTER) unless formatted

      formatted
    end
  end
end