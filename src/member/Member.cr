require "../Page"

# :nodoc:
class Member < Page
  def get(env, db)
    # Left navbar different possible links.
    links = [
      ["member/list", "Membres"],
      ["member/analyze", "Analyze"],
    ]
    side = HTML::SidePanel.new("member-id", "Membres", links)
    @content.add_element(side)
    box = HTML::ScrollBox.new("ScrollBox")
    case @url
    when "main"
      card = HTML::Card.new("Card")
      card.add_element(HTML::Header2.new("test", "Les membres!"))
      caption = HTML::Paragraph.new("caption-explain", "Gérez les membres et leurs statuts. Analysez ce qu'ils aiment afin de cibler les formations.")
      card.add_element(caption)
      box.add_element(card)
    when "list"

    end
    @content.add_element(box)
  end
end
