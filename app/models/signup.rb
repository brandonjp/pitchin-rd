class Signup
  include Mongoid::Document

  field :name
  field :qty, :type => Integer
  field :units
  field :notes

  field :person
  field :comments
  
  embedded_in :event

end

