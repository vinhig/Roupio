require "kemal"
require "kemal-session"
require "../src/member/Member"
require "../src/cloud/Cloud"
require "../src/Data"

# Kemal config
Kemal::Session.config do |config|
  config.secret = "super_secret_config_4a2d6f4"
end

# Database initialization
db = Data.new

# Basic authentification system
# Not using framework tools
get "/" do |env|
  send_file env, "src/index.html"
end
post "/connect" do |env|
  pseudo = env.params.body["pseudo"].as(String)
  mdp = env.params.body["mdp"].as(String)
  can_connect = db.connect?(pseudo, mdp)
  if can_connect != ""
    env.session.string("id", can_connect)
    env.redirect "/cloud"
  else
    env.redirect "/"
  end
end

# Define page and their corresponding page
pages = {
  "/member" => Member,
  "/cloud"  => Cloud,
}

# Bind all route to their corresponding page
pages.each do |page|
  get page[0] do |env|
    # First check if the user is connected
    if env.session.string?("id") == nil
      env.redirect "/"
    else
      mod = page[1].new env
      mod.render
    end
  end
end

Kemal.run
