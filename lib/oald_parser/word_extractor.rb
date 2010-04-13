module OaldParser
  class WordExtractor
    def extract(str)
      res = remove_unused_words(str)
      find_first_big_word(res)
    end

    private
    def remove_unused_words(str)
       str.gsub(' ', '  ').
       gsub(/\Aa | a |\Aan | an |\Athe | the |\[.*\]|\(.*\)| adj | adj\z| adv | adv\z/i, '')
    end

    def find_first_big_word(str)
      parts = str.split(' ')
      parts.size > 1 ? parts.find{|w| w.size > 2}  : str.strip
    end
  end
end