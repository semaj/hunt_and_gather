class TwilioController < ApplicationController

  def process_sms
    body = params[:Body].downcase
    keywords = body.keywords
    hunting = %w(hungry hunger want where find hunting hunt)
    gathering = %w(found there there's here look gathering gather gathered)
    schools = School.all.map {|s| s.name.downcase }
    keywords.rank.each do |word|
      raw = word.text.downcase
      if hunting.any? {|s| s.eql? raw }
        @response = "I see you're looking for food."
        break
      elsif gathering.any? {|s| s.eql? raw }
        @response = "I see you've found some food."
        break
      end
    end
    @response = "I didn't quite get that." unless not @response.nil?
    render 'process_sms.xml.erb', :content_type => 'text/xml'
  end

end
