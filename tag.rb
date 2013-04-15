class Tag
  attr_accessor :str
  def initialize str
    @str = str
  end

  def == (tag)
    return (tag.str == @str)
  end
end