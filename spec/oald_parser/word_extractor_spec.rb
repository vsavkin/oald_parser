require_relative '../../lib/oald_parser/word_extractor'
include OaldParser

describe WordExtractor do

  subject { WordExtractor.new }

  specify do
    subject.extract('a a cat').should == 'cat'
    subject.extract(' a the the cat').should == 'cat'
    subject.extract('kill [VN]').should == 'kill'
    subject.extract(' do adj').should == 'do'
    subject.extract(' do adj ').should == 'do'
    subject.extract(' do adv').should == 'do'
    subject.extract(' do adv ').should == 'do'
    subject.extract('adjective').should == 'adjective'
  end

end
