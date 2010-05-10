module OaldParser
  class PageParser
    def parse(page)
      page = extract_part_without_header(page)
      return nil unless page
      page = extract_part_without_footer(page)
      return nil unless page
      page.strip
    end

    private
    def extract_part_without_header(page)
      parts = page.split('<!-- End of DIV top-container-->')
      parts.size == 2 ? parts[1] : nil
    end

    def extract_part_without_footer(page)
      parts = page.split('<!-- End of DIV entry-->')
      parts.size == 2 ? parts[0] : nil
    end
  end
end