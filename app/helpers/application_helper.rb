module ApplicationHelper
  def image?(url)
    !(url =~ /\.(?:jpe?g|png|gif)$/i).nil?
  end
end
