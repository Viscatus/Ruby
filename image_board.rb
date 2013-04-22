require_relative 'ui'
require_relative 'user'
require_relative 'image'
require 'digest/sha2'
class ImageBoard
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

  def upload_full_image_file path

  end

  def create_thumbnail path

  end

  def upload_image (user, path, tags)

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

  def load_data
    @admin_code = (Digest::SHA2.new << 'abcd').to_s
  end

  def save_data

  end

  private :load_data, :save_data, :upload_full_image_file, :create_thumbnail
end