class Tag
  attr_accessor :str, :parent_tag
  def initialize str, parent_tag=nil
    @str = str
    @parent_tag = parent_tag
  end

  def == (tag)
    rez = false
    if (tag.instance_of? (Tag))
      rez = (tag.str == @str)
    else
      rez = (tag == @str)
    end
    if (@parent_tag != nil) && (!rez)
      @parent_tag == tag
    else
      rez
    end
  end
end