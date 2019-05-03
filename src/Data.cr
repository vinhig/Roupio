require "db"
require "sqlite3"
require "crypto/bcrypt/password"

# Top level class to deal with the database
class Data
  @db : DB::Database

  # Init, connect and feed the database.
  def initialize
    @db = DB.open("sqlite3://db.db")
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

  # Store the path, the author and the id of a new file.
  def store_new_file(original_name : String, author : String, hash : String, category : String)
    @db.exec "insert into files (hash, author, name, category) values (?, ?, ?, ?)", hash, author, original_name, category
  end

  # Get all files owned by the user.
  def get_all_file(author : String) : Array(Hash(String, String))
    files = [] of Hash(String, String)
    @db.query "select * from files where author = ? order by name asc", author do |rs|
      rs.each do
        files.push({
          rs.column_name(0) => rs.read(String),
          rs.column_name(1) => rs.read(String),
          rs.column_name(2) => rs.read(String),
          rs.column_name(3) => rs.read(String),
        })
      end
    end
    return files
  end

  # Get and check the file asked by the user.
  def get_and_chek(author : String, id : String) : String
    name_file = ""
    @db.query "select name from files where author = ? and hash = ?", author, id do |rs|
      rs.each do
        name_file = rs.read(String)
      end
    end
    return name_file
  end
end
