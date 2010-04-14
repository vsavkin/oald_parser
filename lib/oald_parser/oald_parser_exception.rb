module OaldParser
  class OaldParserException < Exception
    NET = 'net'
    PARSER = 'parser'
    FORMATTER = 'formatter'
    INTERNAL = 'internal'

    attr_reader :code

    def initialize(code, message = nil)
      @code = code
      if message
        super message
      else
        super "#{@code} problems"
      end
    end
  end
end