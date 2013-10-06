class WelcomeController < ApplicationController
  def index
    @northeastern = School.find(1)
  end
end
