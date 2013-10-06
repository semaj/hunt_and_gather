module ApplicationHelper
  def gathering_school(text)
    @response = "test"
    lets_break = false
    text.keywords.top(10).each do |word|
      @response = @response + word.text
      School.all.each do |school|
        down_school_name = school.name.downcase
        @response = "test2"
        if down_school_name.match(word.text)

          gathering_building(school, text)
          lets_break = true
        end
        break if lets_break
      end
      break if lets_break
    end
  end

  def gathering_building(school, text)
    lets_break = false
    text.keywords.top(10).each do |word|
      school.buildings.each do |building|
        down_building_name = building.name.downcase
        if down_building_name.match(word.text)
          gathering_room(building, text)
          lets_break = true
        end
        break if lets_break
      end
      break if lets_break
    end
    @response = "No building found"
  end

  def gathering_room(building, text)
    lets_break = false
    text.keywords.top(10).each do |word|
      building.rooms.each do |room|
        down_room_name = room.name.downcase
        if down_room_name.match(word.text)
          @response = "There's food in " + room.name + " in " + building.name
          lets_break = true
        end
        break if lets_break
      end
      break if lets_break
    end
    @response = "No room found"
  end
end
