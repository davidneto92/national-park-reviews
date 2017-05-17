# require 'rest-client'

class ParkDescriptionJob
  attr_reader :park

  def initialize(park)
    @park = park
  end

  def perform
    page = RestClient.get(park.nps_page)
    parse_page = Nokogiri::HTML(page)

    park.nps_description = parse_page.css("#cs_control_481832").css('div').css('p').children.text
    park.nps_description.gsub!(/Read More/, "") # takes off at end of paragraph on some parks

    park.save
  end

end

# use to pull the text
# css("#cs_control_481832").css('div').css('p').children.text
