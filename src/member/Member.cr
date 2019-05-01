require "../Page"

# Member page
class Member < Page
  def load
    p2 = HTML::Paragraph.new("p1", "")
    p2.add_element(HTML::NavLink.new("test1", "cloud", "Go to cloud page..."))
    p1 = HTML::Paragraph.new("p2", "")
    p1.add_element(HTML::NavLink.new("test1", "cloud", "Go to cloud page (2)..."))
    @content.add_element(p2)
    @content.add_element(p1)
  end
end
