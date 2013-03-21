class Tweet

  attr_reader :screen_name, :text

  def initialize(attributes)
    @screen_name = attributes[:screen_name]
    @text = attributes[:text]
  end

  def ==(other)
    if self.class != other.class
      false
    else
      self.screen_name == other.screen_name && self.text == other.text
    end
  end
end