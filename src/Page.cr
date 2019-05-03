require "../src/Content"
require "../src/UserInfo"

# Site page.
class Page
  @user : UserInfo
  @content : HTML::Content
  @template : String
  @url : String

  # Init an empty page.
  def initialize(@user, @template, env)
    @content = HTML::Content.new(@template)
    @url = env.params.url["url"]
  end

  # Procedurally load the HTML document.
  # Accessible via GET routes.
  def load(db)
  end

  # Before load the HTML document, work on backend.
  # Accessible via POST routes.
  def enter(env, db)
  end


  # Ask the corresponding page content to render itself and return its value.
  def render
    text = @content.render
    return text
  end
end
