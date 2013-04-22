require_relative 'ui'
class ImageBoard
  def initialize
    @images = Array.new
    @tags = Array.new
    @authors = Array.new
    @users = Array.new
    @comments = Array.new
  end

  def check_nic_exists nic
    @users.each {|i| return true if i.nic == nic}
    false
  end

  def load_data

  end

  def save_data

  end

  private :load_data, :save_data
end