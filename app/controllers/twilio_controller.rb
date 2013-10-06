class TwilioController < ApplicationController

  def process_sms
    bl_array = %w(university college student center library quad quadrangle institute room building hall dorm dormitory house theater arena dining the of a in food i)
    blacklist = Highscore::Blacklist.load bl_array
    text = Highscore::Content.new params[:Body].downcase
    text.configure do
      set :word_pattern, /([^\s]+)/
    end
    hunting = %w(hungry hunger want where find hunting hunt)
    gathering = %w(found there there's here look gathering gather gathered)
    @response = ""
    text.keywords.top(20).each do |word|
      raw = word.text
      if hunting.any? {|s| s.eql? raw }
        @response = hunting(text)
        break
      elsif gathering.any? {|s| s.eql? raw }
        @response = gathering_school(text)
        break
      end
    end
    @response = "I didn't quite get that." unless not @response.nil?
    render 'process_sms.xml.erb', :content_type => 'text/xml'
  end

  private
  def hunting(text)
    text.keywords.top(10).each do |word|
      School.all.each do |school|
        down_school_name = school.name.downcase
        if down_school_name.match(word.text)
          return school.find_food
        end
      end
    end
    return "You didn't send a valid school."
  end

  def gathering_school(text)
    text.keywords.top(10).each do |word|
      School.all.each do |school|
        down_school_name = school.name.downcase
        if down_school_name.match(word.text)
          school.food = true
          school.save
          return "You found food at " + school.name.to_s + gathering_building(school, text)
        end
      end
    end
    return "You didn't send a valid school."
  end

  def gathering_building(school, text)
    text.keywords.top(10).each do |word|
      school.buildings.each do |building|
        down_building_name = building.name.downcase
        if down_building_name.match(word.text)
          building.food = true
          building.save
          return  ": " + building.name + gathering_room(building, text)
        end
      end
    end
  end

  def gathering_room(building, text)
    text.keywords.top(10).each do |word|
      building.rooms.each do |room|
        down_room_name = room.name.downcase
        if down_room_name.match(word.text)
          room.food = true
          room.save
          return ": " + room.name + ". Thanks!"
        end
      end
    end
  end

end
