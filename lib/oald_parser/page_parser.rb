require 'nokogiri'

module OaldParser
  class Page
    attr_reader :blocks
    def initialize(blocks)
      @blocks = blocks
    end

    def self.empty
      Page.new []
    end
  end

  class Block
    attr_reader :text, :items
    def initialize(text, items)
      @text, @items = text, items
    end
  end

  class Item
    attr_reader :text, :examples
    def initialize(text, examples)
      @text, @examples = text, examples
    end
  end

  class PageParser
    def parse(page)
      parsed = Nokogiri::HTML(page)
      if blocks_on_page? parsed
        Page.new(parse_block(parsed))
      else
        parse_page_from_items(parsed)
      end
    end

    private
    def parse_page_from_items(parsed)
      items = parse_items(parsed)
      if items.empty?
        Page.empty
      else
        Page.new([Block.new("", items)])
      end      
    end

    def blocks_on_page?(page)
      page.css('div.sd-g').first
    end

    def parse_block(page)
      page.css('div.sd-g').collect do |block|
        block_text  = all_except(block, 'n-g')
        items = parse_items(block)
        Block.new(block_text, items)
      end
    end

    def parse_items(block)
      items = block.css('span.n-g').collect do |item|
        item_text = all_except(item, 'x-g')
        Item.new(item_text, parse_examples(item))
      end

      if block.css('div.def_block').first
        item_text = block.css('div.def_block').first.text.strip
        items << Item.new(item_text, parse_examples(block))
      end
      items
    end

    def parse_examples(item)
      example_nodes = item.css('span.x-g')
      example_nodes.collect{|e| e.text.strip}
    end

    def all_except(item, class_name)
      elements = item.children.find_all do |c|
        !(['span', 'div'].include?(c.name) && c[:class] == class_name)
      end
      elements.collect{|e|e.text}.join('').strip
    end
  end
end
