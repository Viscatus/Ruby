require_relative 'ui'
require_relative 'user'
require_relative 'image'
require_relative 'tag'
require 'yaml'
require 'digest/sha2'
require 'net/http'
class ImageBoard
  attr_accessor :images, :tags, :users

  def initialize
    @images = Array.new
    @tags = Array.new
    @authors = Array.new
    @users = Array.new
    @comments = Array.new
    load_data
  end

  def check_nic_exists nic
    @users.each {|i| return true if i.nic == nic}
    false
  end

  def check_email_exists email
    @users.each {|i| return true if i.get_data(:email) == email}
    false
  end

  def register_user (name, surname, nic, pass, email, admin_code=nil)
    if (check_nic_exists nic) || (check_email_exists email) ||
        !(email =~ /^[\w\.=-]+@[\w\.-]+\.[\w]{2,3}$/)
      return false
    end
    if (admin_code != nil)&&(@admin_code != (Digest::SHA2.new << admin_code).to_s)
      return false
    end

    user = User.new name, surname, nic, email, admin_code != nil
    user.set_password pass
    @users.push user
    return true
  end

  def find_image id
    @images.each {|i| return i if i.get_id == id}
    nil
  end

  def find_images tags
    rez = Array.new
    @images.each {|i| rez.push [i.revelance(tags), i] if i.revelance(tags) != 0}
    return rez.sort{ |x, y| x[0] <=> y[0] }
  end

  def upload_image (user, path, tags)
    if (@users.rindex(user) == nil)
      return false
    end
    img = Image.new path, tags, user
    img.upload_images
    @images.push img
    return true
  end

  def try_login (nic, pass)
    @users.each {|i|
      if i.nic == nic
        return i if i.test_password pass
      end
    }
    nil
  end

  def get_user (id)
    @users.each {|i|
      if i.get_id == id
        return i
      end
    }
    nil
  end

  def find_user (nic)
    @users.each {|i|
      if i.nic == nic
        return i
      end
    }
    nil
  end
  def add_tag (str)
   if find_tag str
     return false
   end
   a = Tag.new(str)
   @tags.push a
   true
  end

  def find_tag (tag)
    @tags.each {|i|
      if i == tag
        return i
      end
    }
    nil
  end

  def close
    save_data
  end

  def load_data
    @admin_code = (Digest::SHA2.new << 'abcd').to_s
    parsed = begin
      @images = YAML.load File.open("data\\images.yaml")
      @tags = YAML.load File.open("data\\tags.yaml")
      @users = YAML.load File.open("data\\users.yaml")
    rescue Exception => e
    end
  end

  def save_data
    File.open("data\\images.yaml", "w") {
        |f| f.write (@images.to_yaml)
      f.close
    }
    File.open("data\\tags.yaml", "w") {
        |f| f.write (@tags.to_yaml)
      f.close
    }
    File.open("data\\users.yaml", "w") {
        |f| f.write (@users.to_yaml)
      f.close
    }
  end
end