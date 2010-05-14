require "spec"
require_relative '../../lib/oald_parser/page_parser'

describe OaldParser::PageParser do

  VALID_INPUT_WITH_BLOCKS = "
    <html><body>
    <dIv class='sd-g'>
      <h3 class='sd'>block1</h3>
      <span class='n-g'>title1
        <span class='x-g'>example1</span>
        <span class='x-g'>example2</span>
      </span>

      <span class='n-g'>title2
        <span class='x-g'>example1</span>
      </span>
    </div>

    <div class='sd-g'>
      <h3 class='sd'>block2</h3>
      <span class='n-g'>title<span class='number'>1</span>
        <span class='x-g'>example<span class='number'>11</span></span>
        <span class='x-g'>example<span class='number'>22</span></span>
      </span>
    </div>
    </body></html>
  "

  VALID_INPUT_WITHOUT_BLOCKS = "
    <html><body>
      <span class='n-g'>title1
        <span class='x-g'>example1</span>
        <span class='x-g'>example2</span>
      </span>
    </body></html>
  "

  DEFINITION_WITHOUT_BLOCKS = "
    <html><body>
      <div class='h-g'>
        <div class='def_block'>title</div>
        <span class='x-g'>example1</span>
        <span class='x-g'>example2</span>
      </div>
    </body></html>
  "

  SECOND_SYNTAX_OF_BLOCKS = "
    <html><body>
      <div class='h-g'>
        block
        <span class='n-g'>title<span class='number'></span>
          <span class='x-g'>example<span class='number'>11</span></span>
          <span class='x-g'>example<span class='number'>22</span></span>
        </span>
      </div>
    </body></html>
  "

  INVALID_INPUT = "
    <html><body>
    <form></form>
    <div>content<p>content</p></div>
    </body></html>
  "

  before(:each) do
    @parser = OaldParser::PageParser.new 
  end

  it "should process the page with blocks" do
    res = @parser.parse(VALID_INPUT_WITH_BLOCKS)
    res.blocks.size.should == 2
    res.blocks[1].text.should == 'block2'
    res.blocks[1].items.size.should == 1
    res.blocks[1].items[0].text.should == 'title1'
    res.blocks[1].items[0].examples[0].should == 'example11'
    res.blocks[1].items[0].examples[1].should == 'example22'
  end

  it "should process the page with blocks with the second format" do
    res = @parser.parse(SECOND_SYNTAX_OF_BLOCKS)
    res.blocks.size.should == 1
    res.blocks[0].text.should == ''
    res.blocks[0].items.size.should == 1
    res.blocks[0].items[0].text.should == 'title'
    res.blocks[0].items[0].examples[0].should == 'example11'
    res.blocks[0].items[0].examples[1].should == 'example22'
  end

  it "should process the page with items" do
    res = @parser.parse(VALID_INPUT_WITHOUT_BLOCKS)
    res.blocks.size.should == 1
    res.blocks[0].items.size.should == 1
    res.blocks[0].items[0].text.should == 'title1'
    res.blocks[0].items[0].examples[0].should == 'example1'
    res.blocks[0].items[0].examples[1].should == 'example2'
  end

  it "should process the page with definition" do
    res = @parser.parse(DEFINITION_WITHOUT_BLOCKS)
    res.blocks.size.should == 1
    res.blocks[0].items.size.should == 1
    res.blocks[0].items[0].text.should == 'title'
    res.blocks[0].items[0].examples[0].should == 'example1'
    res.blocks[0].items[0].examples[1].should == 'example2'
  end

  it "should return nil if can't parse the page" do
    res = @parser.parse(INVALID_INPUT)
    res.blocks.should be_empty
  end
end