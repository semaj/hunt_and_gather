class TwilioController < ApplicationController

  def process_sms
    body = params[:Body]
    keywords = body.keywords
    hunting = %w(hungry hunger want where find hunting hunt)
    gathering = %w(found there here look gathering gather)
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
