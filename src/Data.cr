require "db"
require "sqlite3"
require "crypto/bcrypt/password"

# Top level class to deal with the database
class Data
  @db : DB::Database

  # Init, connect and feed the database.
  def initialize
    @db = DB.open("sqlite3://db.db")
    # @db.exec "create table users (pseudo text not null, mdp text not null, primary key (pseudo))"
    # @db.exec "insert into users (pseudo, mdp) values ('salut', 'salut')"
    # @db.exec "insert into users (pseudo, mdp) values ('bjr', 'bjr')"
  end

  # Check if the credentials of a user exists.
  def connect?(pseudo : String, mdp : String) : String
    id = ""
    @db.query "select * from users where pseudo = ? and mdp = ?", pseudo, mdp do |rs|
      rs.each do
        puts "Found a people like you"
        id = rs.read(String)
      end
    end
    id
  end
end
