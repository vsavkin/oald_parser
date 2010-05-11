require 'nokogiri'

module OaldParser
  class Page
    attr_reader :blocks, :items
    def initialize(blocks, items)
      @blocks, @items = blocks, items
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
        Page.new(parse_block(parsed), [])
      elsif def_on_page? parsed
        Page.new([], parse_def(parsed))      
      else
        Page.new([], parse_items(parsed))
      end
    end

    private
    def blocks_on_page?(page)
      page.css('div.sd-g').first
    end

    def def_on_page?(page)
      page.css('div.h-g').first
    end

    def parse_block(page)
      block_nodes = page.css('div.sd-g')
      block_nodes.collect do |block|
        block_text  = all_except(block, 'n-g')
        items = parse_items(block)
        Block.new(block_text, items)
      end
    end

    def parse_items(block)
      item_nodes = block.css('span.n-g')
      item_nodes.collect do |item|
        item_text = all_except(item, 'x-g')
        Item.new(item_text, parse_examples(item))
      end      
    end

    def parse_def(page)
      item_nodes = page.css('div.h-g')
      item_nodes.collect do |item|
        item_text = item.css('div.def_block').first.text.strip
        Item.new(item_text, parse_examples(item))
      end        
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