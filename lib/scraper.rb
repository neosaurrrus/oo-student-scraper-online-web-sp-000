require 'open-uri'
require 'pry'

class Scraper

  def self.get_url(index_url)
    Nokogiri::HTML(open(index_url))
  end

  def self.scrape_index_page(index_url)
    scraped_index = []
    scraped_cards = get_url(index_url).css('.student-card')
    card_array = scraped_cards.css('.student-card').map do |card|
      card.content
    end

    binding.pry
    #name = something from scraped cards
    #location - something from scraped cards
    #get name, location, profile_url

  end

  def self.scrape_profile_page(profile_url)

  end

end
