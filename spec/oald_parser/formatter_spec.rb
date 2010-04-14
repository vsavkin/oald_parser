require "spec"
require_relative '../../lib/oald_parser/formatter'

describe OaldParser::Formatter do

  INPUT = '
    <p><a href="boo">link</a> some text<br>another text</p>
  '

  INPUT_WITH_IMAGE = '
    <p><img src="img">some text</p>
  '

  INPUT_WITH_MANY_LINES = '
    <p>one<br>two<br>three<br>four</p>
  '

  INPUT_WITH_DIFFERENT_BRS = '
    <p>one<br />two< br >three</p>
  '

  INPUT_WITHOUT_ROOT = '
    one<br>two
  '

  before(:each) do
    @formatter = OaldParser::Formatter.new(lines:3)
  end

  it "should format valid input and do stripping" do
    @formatter.format(INPUT).should == "link some text\nanother text"
  end

  it "should skip image tags" do
    @formatter.format(INPUT_WITH_IMAGE).should == 'some text'
  end

  it "should return the first x lines" do
    @formatter.format(INPUT_WITH_MANY_LINES).should == "one\ntwo\nthree"
  end

  it "should process input without root" do
    @formatter.format(INPUT_WITHOUT_ROOT).should == "one\ntwo"
  end
end