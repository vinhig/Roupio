# Simple structure to store the pseudo and the level of the user.
struct UserInfo
  property pseudo : String
  property level : String

  # Create user identity from given parameters.
  #
  # pseudo => id of the member
  #
  # level => status of the member in the organization
  def initialize(@pseudo, @level)
  end
end
