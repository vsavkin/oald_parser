require_relative '../../lib/oald_parser/formatter'
require 'ostruct'

describe OaldParser::Formatter do

  before(:each) do
    @item1 = OpenStruct.new(text: 'item1', examples: ['one', 'two'])
    @item2 = OpenStruct.new(text: 'item2', examples: ['one'])
    @block1 = OpenStruct.new(text: 'block1', items: [@item1, @item2])
    @block2 = OpenStruct.new(text: '', items: [@item1, @item2])
  end

  it "should format page with blocks and do stripping" do
    page = OpenStruct.new(blocks: [@block1])
    subject.format(page).should == "BLOCK1\n--------------------\nitem1\n+ one\n+ two\n\nitem2\n+ one"
  end

  it "should not add a separate line if block text is empty" do
    page = OpenStruct.new(blocks: [@block2])
    subject.format(page).should == "item1\n+ one\n+ two\n\nitem2\n+ one"
  end

  it "should format empty page" do
    page = OpenStruct.new(blocks: [])
    subject.format(page).should == ''
  end
end
