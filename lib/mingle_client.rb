if RUBY_VERSION < '1.9'
  require 'rubygems'
end

require 'rest_client'
require 'rexml/document'


class MingleClient

  def initialize(base_url, username, password)
    @base_url = base_url
    @username = username
    @password = password
  end

  def request_execute(url)
    RestClient::Request.new(:method => :get, :url => URI.encode(@base_url + url),
                            :user => @username, :password => @password,
                            :headers => {:accept => :xml, :content_type => :xml}).execute
  end

  def get_cards(filter = "")
    data = request_execute("cards.xml#{filter}")
    doc = REXML::Document.new(data)

    cards = []
    doc.elements.each('cards/card') do |ele|
      card = Card.new
      ele.elements.each('name') do |el|
        card.name = el.text
      end
      ele.elements.each('number') do |el|
        card.number = el.text
      end
      ele.elements.each('card_type/name') do |el|
        card.type = el.text
      end

      ele.elements.each('properties/property') do |el|
        property_type = ""

        el.elements.each('name') do |name|
          property_type = name.text
        end
        el.elements.each('value') do |value|
          case property_type
            when "Status"
              card.status = value.text
            when "Task Status"
              card.status = value.text
            when "Defect Status"
              card.status = value.text
            when "Task Points"
              card.task_points = value.text
            when "Hours Remaining"
              card.hours_remaining = value.text
            when "Sprint"
              value.elements.each('number') do |number|
                card.sprint = number.text
              end
            when "Story"
              value.elements.each('number') do |number|
                card.story = number.text
              end
            when "Owner"
              value.elements.each('name') do |owner|
                card.owner = owner.text
              end
          end
        end
      end
      cards << card
    end
    cards
  end
end