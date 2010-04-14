require 'nokogiri'

module OaldParser
  class Formatter
    def initialize(options)
      @options = options
    end

    def format(content)
      lined_content = content.gsub(/<\s*br\s*\/*>/, "\n")
      text = Nokogiri::HTML(lined_content).text
      first_lines = first_lines(text, @options[:lines])
      first_lines.strip
    rescue
      nil  
    end

    private
    def first_lines(text, lines)
      text.split("\n").first(lines).join("\n")
    end
  end
end