class Friend
  attr_reader :screen_name

  def initialize(attributes)
    @screen_name = attributes[:screen_name]
  end

  def ==(other)
    if self.class != other.class
      false
    else
      self.screen_name == other.screen_name
    end
  end
end