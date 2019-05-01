# Simple structure to store the pseudo and the level of the user.
struct UserInfo
  @pseudo : String
  @level : String

  # Create user identity from given parameters
  def initialize(@pseudo, @level)
  end
end
