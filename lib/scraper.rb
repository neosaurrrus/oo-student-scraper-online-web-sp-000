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

    profile_hash = {
      twitter: scraped_socials[0],
      linkedin: scraped_socials[1],
      github: scraped_socials[2],
      blog: scraped_socials[3],
      profile_quote: scraped_quote,
      bio: scraped_bio
    }
    puts profile_hash
    #binding.pry
  end

  #
  # let!(:student_joe_hash) {{:twitter=>"https://twitter.com/jmburges",
  #                           :linkedin=>"https://www.linkedin.com/in/jmburges",
  #                           :github=>"https://github.com/jmburges",
  #                           :blog=>"http://joemburgess.com/",
  #                           :profile_quote=>"\"Reduce to a previously solved problem\"",
  #                           :bio=>


end
