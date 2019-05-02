require "../src/Content"
require "../src/UserInfo"

# Site page.
class Page
  @user : UserInfo
  @content : HTML::Content
  @template : String

  # Init an empty page.
  def initialize(@user, @template, url : String)
    @content = HTML::Content.new(@template)
    load(url)
  end

  # Procedurally load the HTML document.
  def load(url : String)
  end

  # Ask the corresponding page content to render itself and return its value.
  def render
    text = @content.render
    return text
  end
end
