require_relative 'oald_parser/facade'
require_relative 'oald_parser/formatter'
require_relative 'oald_parser/oald_parser_exception'
require_relative 'oald_parser/page_downloader'
require_relative 'oald_parser/page_parser'


include OaldParser

downloader = PageDownloader.new("http://www.oxfordadvancedlearnersdictionary.com/dictionary")
page = downloader.download("dog")
parser = PageParser.new
parsed = parser.parse(page)
puts parsed
formatter = Formatter.new(lines: 15)
puts formatter.format(parsed)    