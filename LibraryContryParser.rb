# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'csv'

def valid_library_name?(name)
  excluded_keywords = ["archives", "libraries", "librarians", "librarytechnology.org", "sylviamilne.co.uk", "theeuropeanlibrary.org", "LIBweb", "unesco.org", "Encyclopedia Americana"]

  !name.empty? && !name.start_with?('"') && !excluded_keywords.any? { |keyword| name.include?(keyword) }
end

doc = Nokogiri::HTML(URI.open('https://en.wikipedia.org/wiki/List_of_libraries'))

CSV.open("librariesCountry.csv", "wb") do |csv|
  csv << ["Index", "Library Name"]

  doc.css('div.mw-parser-output > ul > li').each_with_index do |node, index|
    library_name = node.text.strip

    next if !valid_library_name?(library_name)

    csv << [index+1, library_name]
  end
end