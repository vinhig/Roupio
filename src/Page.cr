require "../src/Content"
require "../src/UserInfo"

# Site page.
class Page
  @user : UserInfo
  @content : HTML::Content
  @template : String

  # Init an empty page.
  def initialize(@user, @template)
    @content = HTML::Content.new(@template)
    load()
  end

  # Procedurally load the HTML document.
  def load
  end

  # Ask the corresponding page content to render itself and return its value.
  def render
    text = @content.render
    return text
  end
end
