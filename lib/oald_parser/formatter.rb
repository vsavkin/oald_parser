require 'nokogiri'

module OaldParser
  class Formatter
    def initialize(options)
      @options = options
    end

    def format(page)
      if !page.blocks.empty?
        format_blocks(page.blocks)
      else
        format_items(page.items)  
      end
    end

    private
    def format_blocks(blocks, limit = 1000)
      blocks.collect do |block|
        res = ''
        res += block.text.upcase
        res += "\n"
        res += '-' * 20
        res += "\n"
        res += format_items(block.items)
        res
      end.join("\n\n")
    end

    def format_items(items, limit = 1000)
      items.collect do |item|
        res = ''
        res += item.text
        if !item.examples.empty?
          res += "\n"
          res += format_examples(item.examples)
        end
        res
      end.join("\n\n")
    end

    def format_examples(examples)
      examples.collect {|e| "+ #{e}"}.join("\n")
    end
  end
end