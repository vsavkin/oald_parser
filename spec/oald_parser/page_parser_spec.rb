require "spec"
require_relative '../../lib/oald_parser/page_parser'

describe OaldParser::PageParser do

  VALID_INPUT = "
    <html><body>
    <form></form>
    <form><select> </selECT>  </FORM>
    <div>content<p>content</p></div>
    <DIV   class='oald'>footer</div>                        
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

  it "should extract the part of html with word description" do
    @parser.parse(VALID_INPUT).should == "<div>content<p>content</p></div>"
  end

  it "should return nil if can't parse the page" do
    @parser.parse(INVALID_INPUT).should be_nil
  end
end