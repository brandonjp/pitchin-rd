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

end

