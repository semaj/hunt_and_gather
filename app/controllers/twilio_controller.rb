class TwilioController < ApplicationController

  def process_sms
    @body = params[:Body]
    render 'process_sms.xml.erb', :content_type => 'text/xml'
  end

end
