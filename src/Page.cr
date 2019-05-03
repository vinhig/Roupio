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

  # Load page accessible via GET routes.
  def get(env, db)
  end

  # Load page accessible via POST routes.
  def post(env, db)
  end


  # Ask the corresponding page content to render itself and return its value.
  def render
    text = @content.render
    return text
  end
end
