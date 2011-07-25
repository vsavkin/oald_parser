require 'nokogiri'

module OaldParser
  class Formatter
    def format(page)
      format_blocks(page.blocks)
    end

    private
    def format_blocks(blocks)
      blocks.collect do |block|
        res = ''
        unless block.text.empty?
          res += block.text
          res += "\n"
        end
        res += format_items(block.items)
        res
      end.join("\n")
    end

    def format_items(items)
      items.collect do |item|
        res = item.text
        unless item.examples.empty?
          res += "\n"
          res += format_examples(item.examples)
        end
        res
      end.join("\n")
    end

    def format_examples(examples)
      examples.collect{|e| " * #{e}"}.join("\n")
    end
  end
end
