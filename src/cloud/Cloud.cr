require "../Content"
require "../Page"

# Cloud page
class Cloud < Page
  def load
    scroll = HTML::ScrollBox.new("scroll")
    card1 = HTML::Card.new("card1")
    scroll.add_element(card1)
    card1.add_element(HTML::NavLink.new("test2", "member", "Ceci est un test"))
    @content.add_element(scroll)
  end
end
