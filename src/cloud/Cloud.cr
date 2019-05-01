require "../Content"
require "../Page"

# Cloud page
class Cloud < Page
  def load
    @content.add_element(HTML::Paragraph.new("test1", "Nope, you don't"))
    @content.add_element(HTML::NavLink.new("test1", "member", "Nope, you don't"))
  end
end
