require "spec"
require_relative '../../lib/oald_parser/formatter'

describe OaldParser::Formatter do

  before(:each) do
    @item1 = OpenStruct.new(text: 'item1', examples: ['one', 'two'])
    @item2 = OpenStruct.new(text: 'item2', examples: ['one'])
    @item3 = OpenStruct.new(text: 'item', examples: [])
    @block = OpenStruct.new(text: 'block1', items: [@item1, @item2])
    @formatter = OaldParser::Formatter.new(items:3)
  end

  it "should format page without blocks and do stripping" do
    page = OpenStruct.new(items: [@item1, @item2], blocks: [])
    @formatter.format(page).should == "item1\n+ one\n+ two\n\nitem2\n+ one"
  end

  it "should format page with blocks and do stripping" do
    page = OpenStruct.new(items: [], blocks: [@block])
    @formatter.format(page).should == "BLOCK1\n--------------------\nitem1\n+ one\n+ two\n\nitem2\n+ one"
  end

  it "should not add too many new lines if there are no examples" do
    page = OpenStruct.new(items: [@item3, @item3], blocks: [])
    @formatter.format(page).should == "item\n\nitem"
  end

  it "should format empty page" do
    page = OpenStruct.new(items: [], blocks: [])
    @formatter.format(page).should == ''
  end
end