require_relative '../../lib/oald_parser/formatter'
require 'ostruct'

describe OaldParser::Formatter do

  before(:each) do
    @item1 = OpenStruct.new(text: 'item1', examples: ['one', 'two'])
    @item2 = OpenStruct.new(text: 'item2', examples: ['one'])
    @block = OpenStruct.new(text: 'block1', items: [@item1, @item2])
  end

  it "should format page with blocks and do stripping" do
    page = OpenStruct.new(blocks: [@block])
    subject.format(page).should == "##block1\n###item1\n * one\n * two\n###item2\n * one"
  end

  it "should format empty page" do
    page = OpenStruct.new(blocks: [])
    subject.format(page).should == ''
  end
end
