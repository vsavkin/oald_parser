require 'net/http'
require 'uri'

module OaldParser
  class PageDownloader
    def initialize(url)
      @url = url  
    end

    def download(word)
      url = URI.parse(@url)
      Net::HTTP.post_form(url, search_word: word)
    rescue
      nil
    end
  end
end