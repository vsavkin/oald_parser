require 'net/http'
require 'uri'

module OaldParser
  class PageDownloader
    def initialize(url)
      @url = url  
    end

    def download(word)
      url = URI.parse("#{@url}/#{word}")
      Net::HTTP.get(url)
    rescue Exception => e
      nil
    end
  end
end
