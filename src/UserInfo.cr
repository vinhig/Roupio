# Simple structure to store the pseudo and the level of the user.
struct UserInfo
  property pseudo : String
  property level : String

  # Create user identity from given parameters
  def initialize(@pseudo, @level)
  end
end
