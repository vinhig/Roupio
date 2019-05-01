require "../src/Content"

# Site page.
class Page
  @user_name : String
  @content : HTML::Content

  # Init an empty page.
  def initialize(env)
    @content = HTML::Content.new
    @user_name = env.session.string("id")
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
