class Item
  include Mongoid::Document

  field :name
  field :qty, :type => Integer
  field :unit
  field :notes

  field :person
  field :comments

end

