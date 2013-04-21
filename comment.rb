class Comment
  attr_accessor :text, :source, :destination

  def initialize text, source, destination
    @text = text
    @source = source
    @destination = destination
  end
end