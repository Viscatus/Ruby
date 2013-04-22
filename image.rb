require 'pathname'
require 'uri'

class Image
  attr_accessor :img_name, :thumb_name, :tags

  @@id = 0

  @creation_date

  def initialize img_name, tags, owner=nil
    @img_name = img_name
    @thumb_name = thumb_name
    @tags = tags
    @owner = owner
    @inited = false
    @@id = @@id + 1
    @id = @@id
  end

  def upload_images
    return false if @inited
    new_path = upload_full_image_file(@img_name, @id)
    return false if new_path == nil
    thum_path = create_thumbnail new_path
    return false if thum_path == nil
    @img_name = new_path
    @thumb_name = thum_path
    @inited = true
    true
  end

  def upload_full_image_file path, id
    if (path =~ URI::regexp)
      uri = URI(path)
      if uri.query != nil
        req_path = "#{uri.path}?#{uri.query}"
      else
        req_path = "#{uri.path}"
      end
      fl = File.open("img\\#{@id}.#{path.split('.')[-1]}", "wb")
      Net::HTTP.start(uri.host) do |http|
        resp = http.get(req_path)
        fl.write(resp.body)
      end
      fl.close
    else
      pn = Pathname.new path
      FileUtils.cp(pn, "img\\#{@id}.#{path.split('.')[-1]}")
      return "img\\#{@id}.#{path.split('.')[-1]}"
    end
    nil
  end

  def create_thumbnail path

  end

  def get_owner
    @owner
  end

  def get_id
    @id
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
  private :upload_full_image_file, :create_thumbnail
end