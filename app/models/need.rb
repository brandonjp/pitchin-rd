class Need
  include Mongoid::Document

  field :name
  field :qty, :type => Integer
  field :units
  field :notes

  field :person
  field :comments
  
  embedded_in :event

  def qty_remaining(event)
    event.needs.each do |need|
      @collected = 0
      @signups = event.signups.where(:name=>need.name)
      @signups.each do |signupqty|
        @collected = @collected + signupqty.qty.to_i
      end
      @remaining = need.qty.to_i - @collected
    end
  end

end

