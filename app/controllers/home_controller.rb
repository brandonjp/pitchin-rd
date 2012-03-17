class HomeController < ApplicationController
  def index
    @event = Event.all(sort: [[ :date, :asc ]], :conditions => {:date => Date.today.to_datetime..(Date.today+24).to_datetime}).first
  end
end
