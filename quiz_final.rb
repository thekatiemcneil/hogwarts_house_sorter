require 'sqlite3'

db = SQLite3::Database.new("sorting_hat.db")

create_student_table = <<-SQL
  CREATE TABLE IF NOT EXISTS students(
    id INTEGER PRIMARY KEY,
    name VARCHAR(225),
    gender VARCHAR(225),
    house_id INT,
    year INT,
    quidditch BOOLEAN,
    FOREIGN KEY (house_id) REFERENCES houses(id),
  )
SQL

db.execute(create_student_table)

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

def largest_hash_key(hash)
  hash.max_by{|k,v| v}
end
winning_house = largest_hash_key(house_tally)[0]
puts "Must be #{winning_house}!"

def convert_house(string)
  if string == "Gryffindor"
    house_id = 1
  elsif string == "Hufflepuff"
    house_id = 2
  elsif string == "Ravenclaw"
    house_id = 3
  else string == "Slytherin"
    house_id = 4
  end
end

house_id = convert_house(#{winning_house})

def create_student(db, name, gender, house_id, year, quidditch)
    db.execute("INSERT INTO students (name, gender, house_id, year, quidditch) VALUES (?, ?, ?, ?, ?)", [name, gender, house_id, year, quidditch])
end

create_student(db, #{name}, #{gender}, #{house_id}, #{year}, #{quidditch})