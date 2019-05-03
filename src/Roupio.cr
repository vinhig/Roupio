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
# Not using kemal framework tools
get "/" do |env|
  send_file env, "src/index.html"
end
post "/connect" do |env|
  pseudo = env.params.body["pseudo"].as(String)
  mdp = env.params.body["mdp"].as(String)
  can_connect = db.connect?(pseudo, mdp)
  if can_connect != ""
    env.session.string("id", can_connect[0])
    env.session.string("level", can_connect[1])
    env.redirect "/cloud/main"
  else
    env.redirect "/"
  end
end

# Define pages and their corresponding Page classes
pages = {
  ["/member", "Membre"] => Member,
  ["/cloud", "Cloud"]   => Cloud,
}

# Precache and precompute 'template.html' to speed up rendering by avoiding reading on the disk multiple time
template = File.read("src/template.html")
# Compute header
header = ""

# A NavLink for each page
pages.each do |page|
  header += "<a href='#{page[0][0]}/main'>#{page[0][1]}</a>"
end

# Finally fill the header with our computed header
template = template.sub("{{ header }}", header)

# Just check if the user is connected

# Bind all routes to their corresponding pages
pages.each do |page|
  get "#{page[0][0]}/:url" do |env|
    if env.session.string?("id") == nil
      env.redirect "/"
    else
      # Build the user identity
      user = UserInfo.new(env.session.string("id"), env.session.string("level"))
      mod = page[1].new user, template, env
      # A get route means load and render the DOM
      mod.get env, db
      mod.render
    end
  end

  post "#{page[0][0]}/:url" do |env|
    if env.session.string?("id") == nil
      env.redirect "/"
    end
    # Build the user identity
    user = UserInfo.new(env.session.string("id"), "admin")
    mod = page[1].new user, template, env
    # A post route means just enter the page
    # A redirect must be operate afterward
    mod.post env, db
  end
end

Kemal.run
