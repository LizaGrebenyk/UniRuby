# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'csv'

def valid_library_name?(name)
  excluded_keywords = ["archives", "libraries", "librarians", "librarytechnology.org", "sylviamilne.co.uk", "theeuropeanlibrary.org", "LIBweb", "unesco.org", "Encyclopedia Americana"]
  excluded_phrases = ['Libraries of the world and their catalogues, compiled by a retired librarian']

  !name.empty? && !name.start_with?('"') &&
    !excluded_keywords.any? { |keyword| name.include?(keyword) } && !excluded_phrases.include?(name)
end

doc = Nokogiri::HTML(URI.open('https://en.wikipedia.org/wiki/List_of_libraries'))

CSV.open("libraries.csv", "wb") do |csv|
  csv << ["Index", "Library Name"]

  doc.css('div.mw-parser-output > ul > li').each_with_index do |node, index|
    first_a = node.at_css('a')

    if first_a
      library_name = first_a.text.strip

      if valid_library_name?(library_name)
        csv << [index + 1, library_name]
      end
    end
  end
end
