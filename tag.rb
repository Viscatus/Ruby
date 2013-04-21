class Tag
  @@id = 0

  attr_accessor :str, :parent_tag, :synonymous_tag, :lang
  def initialize str, synonymous_tag = nil, parent_tag=nil, lang='en'
    @str = str
    @parent_tag = parent_tag
    @synonymous_tag = synonymous_tag
    @lang = lang
    if (synonymous_tag == nil)
      @@id = @@id +1
      @id = @@id
    else
      @id = synonymous_tag.get_id
    end
    if (parent_tag == nil) && (synonymous_tag != nil)
      @parent_tag = synonymous_tag.parent_tag
    end
  end

  def get_id
    @id
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