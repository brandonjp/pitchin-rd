class Event
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  
  field :name
  field :date, :type => Date
  field :location
  field :theme
  field :notes
  
  embeds_many :needs
  embeds_many :signups

  def self.next_event
    Event.all(sort: [[ :date, :asc ]], :conditions => {:date => Date.today.to_datetime..(Date.today+24).to_datetime}).first
  end

end

