class TwilioController < ApplicationController

  def process_sms
    bl_array = %w(university college student center library quad quadrangle institute room building hall dorm dormitory house theater arena dining the of a in)
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
        @response = "Hunting!"
        break
      elsif gathering.any? {|s| s.eql? raw }
        @response = gathering_school(text)
        break
      end
    end
    @response = "I didn't quite get that." unless not @response.nil?
    render 'process_sms.xml.erb', :content_type => 'text/xml'
  end

  # private

end
