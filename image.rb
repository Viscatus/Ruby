class Image
  attr_accessor :img_name, :thumb_name, :tags

  @creation_date

  def initialize img_name, thumb_name, tags
    @img_name = img_name
    @thumb_name = thumb_name
    @tags = tags
  end

  def add_tag(tag)
    if @tags.rindex(tag) != nil
      return false
    else
      @tags.push tag
      return true
    end
  end

  def has_tag(tag)
    return (@tags.rindex(tag) != nil)
  end
  def has_all_tags(tags)
    tags.each do |tag|
      if !(has_tag tag)
        return false
      end
    end
    return true
  end

  def revelance(tags)
    if (tags.length == 0)
      return 0;
    end
    @result = 0.0
    tags.each do |tag|
      if (has_tag tag)
        @result += 1
      end
    end
    return @result / tags.length;
  end
end