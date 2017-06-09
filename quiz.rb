# THE SORTING HAT

# require gems (squlite3)
require 'sqlite3'

# create SQLite3 database
db = SQLite3::Database.new("sorting_hat.db")

# make table using create table cmd
create_student_table = <<-SQL
  CREATE TABLE IF NOT EXISTS students(
    id INTEGER PRIMARY KEY,
    name VARCHAR(225),
    gender VARCHAR(225),
    house_id INT,
    year INT,
    quidditch BOOLEAN,
    second_house_id INT,
    third_house_id INT,
    fourth_house_id INT,
    FOREIGN KEY (house_id) REFERENCES houses(id),
    FOREIGN KEY (second_house_id) REFERENCES houses(id),
    FOREIGN KEY (third_house_id) REFERENCES houses(id),
    FOREIGN KEY (fourth_house_id) REFERENCES houses(id)
  )
SQL

# Create students table (do I need to use the create_table_cmd that they used?)
# done above

# Create houses table
# Commented out 'create house table' items, because it can be created from outside of this ruby program. The data in this table is limited to four houses, so no need to use ruby to make this.
# create_houses_table = <<-SQL
#     CREATE TABLE IF NOT EXISTS houses(
#       id INTEGER PRIMARY KEY,
#       name VARCHAR(225),
#       number_of_students INT
#     )
# SQL

db.execute(create_student_table)
# db.execute(create_houses_table)
# Commented out 'create house table' items, because it can be created from outside of this ruby program. The data in this table is limited to four houses, so no need to use ruby to make this.

# Populate houses table if not already done
# def create_house(db, name, number_of_students)
#   db.execute("INSERT INTO IF NOT EXISTS houses (name, number_of_students) VALUES (?, ?)", [name, number_of_students])
# end
# Commented out 'create house table' items, because it can be created from outside of this ruby program. The data in this table is limited to four houses, so no need to use ruby to make this.

# create_house(db, 'Gryffindor', 0)
# create_house(db, 'Hufflepuff', 0)
# create_house(db, 'Ravenclaw', 0)
# create_house(db, 'Slytherin', 0)
# Commented out 'create house table' items, because it can be created from outside of this ruby program. The data in this table is limited to four houses, so no need to use ruby to make this.

puts "Welcome to Hogwarts School of Witchcraft and Wizardry! We hope you enjoyed your journey to the castle. \nBefore we can enjoy the start-of-term feast, we need to sort you into your house. \nWhat's your full name?"
  name = gets.chomp
puts "Thanks! What is your gender?"
  gender = gets.chomp
puts "Are you interested in joining your house's quidditch team? y/n"
  quidditch = gets.chomp
  if quidditch.downcase == "y"
    quidditch = true
  elsif quidditch.downcase == "n"
    quidditch = false
  else
    quidditch = false
  end

# Write methods for the actual quiz...ie how the question answers sort the user
# Consider best options for asking questions
  # does quiz actually need methods, or just methods to record the data for the houses?
  # how do I store values for the houses that can be re-set with each additional student?
    # Perhaps

# set 0 values for all houses to begin
# USE A HASHHHHHHHHH
house_tally = {
"Slytherin" => 0,
"Gryffindor" => 0,
"Hufflepuff" => 0,
"Ravenclaw" => 0
}

puts "Please pick a word: sneak, fight, create, think."
  word = gets.chomp
    if word.downcase == "sneak"
      house_tally["Slytherin"] += 1
    elsif word.downcase == "fight"
      house_tally["Gryffindor"] += 1
    elsif word.downcase == "create"
      house_tally["Hufflepuff"] += 1
    else word.downcase == "think"
      house_tally["Ravenclaw"] += 1
    end

puts "Please pick a color: pink, slate, purple, orange."
  color = gets.chomp
    if color.downcase == "pink"
      house_tally["Hufflepuff"] += 1
    elsif color.downcase == "slate"
      house_tally["Slytherin"] += 1
    elsif color.downcase == "purple"
      house_tally["Ravenclaw"] += 1
    else color.downcase == "orange"
      house_tally["Gryffindor"] += 1
    end

puts "Where would you like to go on holiday: Oxford, Auckland, Vancouver, or Las Vegas?"
  city = gets.chomp
    if city.downcase == "oxford"
      house_tally["Ravenclaw"] += 1
    elsif city.downcase == "auckland"
      house_tally["Gryffindor"] += 1
    elsif city.downcase == "vancouver"
      house_tally["Hufflepuff"] += 1
    else city.downcase == "las vegas"
      house_tally["Slytherin"] += 1
    end

puts "What is your favorite season: Summer, Spring, Autumn, or Winter?"
  season = gets.chomp
    if season.downcase == "summer"
      house_tally["Hufflepuff"] += 1
    elsif season.downcase == "spring"
      house_tally["Ravenclaw"] += 1
    elsif season.downcase == "autumn"
      house_tally["Gryffindor"] += 1
    else season.downcase == "winter"
      house_tally["Slytherin"] += 1
    end

puts "Pick a variety of beer: stout, IPA, sour, or saison."
  beer = gets.chomp
    if beer.downcase == "stout"
      house_tally["Gryffindor"] += 1
    elsif beer.downcase == "ipa"
      house_tally["Hufflepuff"] += 1
    elsif beer.downcase == "sour"
      house_tally["Slytherin"] += 1
    else beer.downcase == "saison"
      house_tally["Ravenclaw"] += 1
    end

puts "What house do you want to be in?"
  house_preference = gets.chomp
    if house_preference.downcase == "gryffindor"
      house_tally["Gryffindor"] += 2
    elsif house_preference.downcase == "ravenclaw"
      house_tally["Ravenclaw"] += 2
    elsif house_preference.downcase == "hufflepuff"
      house_tally["Hufflepuff"] += 2
    elsif house_preference.downcase == "slytherin"
      house_tally["Slytherin"] += 2
    else house_tally = house_tally
    end


# define logic to determine which house has the most points
# Try to tweak this to work:
def largest_hash_key(hash)
  hash.max_by{|k,v| v}
end
winning_house = largest_hash_key(house_tally)[0]
puts "Must be #{winning_house}!"

# Write method to create a user
def create_student(db, name, gender, house_id, year, quidditch, second_house_id, third_house_id, fourth_house_id)
    db.execute("INSERT INTO students (name, gender, house_id, year, quidditch, second_house_id, third_house_id, fourth_house_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", [name, gender, house_id, year, quidditch, second_house_id, third_house_id, fourth_house_id])
end

# create_student(db, #{name}, #{gender}, #{house_id}, #{year}, #{quidditch}, #{second_house_id}, #{third_house_id}, #{fourth_house_id})

# Write method that edits user's house after taking quiz
  # Problem: how to identify primary key for the user?

# Add user interface that asks basic user info and quiz questions
# Needed earlier in the quiz, so adding above.

# Run user info through the already-created methods

# end