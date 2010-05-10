require 'net/http'
require 'uri'

module OaldParser
  class PageDownloader
    def initialize(url)
      @url = url  
    end

    def download(word)
      url = URI.parse(@url)
      Net::HTTP.post(url, "search_word=#{word}")
    rescue Exception => e
      puts e.inspect
      nil
    end
  end
end