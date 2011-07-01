module OaldParser
  class WordExtractor
    NOISE = /\Aa | a |\Aan | an |\Athe | the |\[.*\]|\(.*\)| adj | adj\z| adv | adv\z/i

    def extract(str)
      res = remove_noise(str)
      retrieve_first_long_word(res)
    end

    private
    def remove_noise(str)
       str.gsub(' ', '  ').gsub(NOISE, '')
    end

    def retrieve_first_long_word(str)
      words = str.split(' ')
      word = words.size > 1 ?  find_first_long_word(words) : str
      word.strip
    end

    def find_first_long_word(words)
      words.find{|w| w.size > 2}
    end
  end
end
