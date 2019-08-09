require 'open-uri'
require 'pry'

class Scraper

  def self.get_url(index_url)
    Nokogiri::HTML(open(index_url))
  end

  def self.scrape_index_page(index_url)
    scraped_index = []
    scraped_cards = get_url(index_url).css('.student-card')
    name_array = scraped_cards.css('.student-name').map do |card|
      card.content
    end

    location_array = scraped_cards.css('.student-location').map do |card|
      card.content
    end

    link_array = scraped_cards.css('div.student-card > a').map do |card|
      card.attributes["href"].value
    end

    total_students = name_array.length
    count=0
    total_students.times do
      scraped_index << {name: name_array[count], location:location_array[count], profile_url:link_array[count]}
      count+=1
    end
  scraped_index

  end

  def self.scrape_profile_page(profile_url)
    scraped_profile = Nokogiri::HTML(open(profile_url)).css(".main-wrapper")
    scraped_socials = scraped_profile.css(".social-icon-container > a").map { |link| link.attributes["href"].value}
    scraped_quote = scraped_profile.css(".profile-quote").children.text
    scraped_bio = scraped_profile.css(".description-holder > p").text


    profile_hash = {}

    scraped_socials.each { |social|
      if  social.include?("twitter")
        profile_hash[:twitter] = social
      elsif social.include?("linkedin")
        profile_hash[:linkedin] = social
      elsif social.include?("github")
        profile_hash[:github] = social
      elsif social.include?("http")
        profile_hash[:blog] = social
      end
    }
      profile_hash[:profile_quote] = scraped_quote,
      profile_hash[:bio] = scraped_bio
    profile_hash
  end

end
