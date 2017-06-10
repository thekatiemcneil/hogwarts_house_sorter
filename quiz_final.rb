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
    FOREIGN KEY (house_id) REFERENCES houses(id)
    )
SQL

db.execute(create_student_table)

def begin_sorting
  puts "Welcome to Hogwarts School of Witchcraft and Wizardry! We hope you enjoyed your journey to the castle. \nBefore we can enjoy the start-of-term feast, we need to sort you into your house. \nWhat's your full name?"
    name = gets.chomp
  puts "Thanks! What is your gender?"
    gender = gets.chomp
  puts "Are you interested in joining your house's quidditch team? y/n"
    quidditch = gets.chomp
    if quidditch.downcase == "y"
      quidditch = "true"
    elsif quidditch.downcase == "n"
      quidditch = "false"
    else
      quidditch = "false"
    end
end

house_tally = {
  "Slytherin" => 0,
  "Gryffindor" => 0,
  "Hufflepuff" => 0,
  "Ravenclaw" => 0
}

def ask_questions
  puts "Please pick a word: sneak, fight, create, think."
    word = gets.chomp
      if word.downcase == "sneak"
        house_tally["Slytherin"] += 1
      elsif word.downcase == "fight"
        house_tally["Gryffindor"] += 1
      elsif word.downcase == "create"
        house_tally["Hufflepuff"] += 1
      elsif word.downcase == "think"
        house_tally["Ravenclaw"] += 1
      else house_tally = house_tally
      end

  puts "Please pick a color: pink, slate, purple, orange."
    color = gets.chomp
      if color.downcase == "pink"
        house_tally["Hufflepuff"] += 1
      elsif color.downcase == "slate"
        house_tally["Slytherin"] += 1
      elsif color.downcase == "purple"
        house_tally["Ravenclaw"] += 1
      elsif color.downcase == "orange"
        house_tally["Gryffindor"] += 1
      else house_tally = house_tally
      end

  puts "Where would you like to go on holiday: Oxford, Auckland, Vancouver, or Las Vegas?"
    city = gets.chomp
      if city.downcase == "oxford"
        house_tally["Ravenclaw"] += 1
      elsif city.downcase == "auckland"
        house_tally["Gryffindor"] += 1
      elsif city.downcase == "vancouver"
        house_tally["Hufflepuff"] += 1
      elsif city.downcase == "las vegas"
        house_tally["Slytherin"] += 1
      else house_tally = house_tally
      end

  puts "What is your favorite season: Summer, Spring, Autumn, or Winter?"
    season = gets.chomp
      if season.downcase == "summer"
        house_tally["Hufflepuff"] += 1
      elsif season.downcase == "spring"
        house_tally["Ravenclaw"] += 1
      elsif season.downcase == "autumn"
        house_tally["Gryffindor"] += 1
      elsif season.downcase == "winter"
        house_tally["Slytherin"] += 1
      else house_tally = house_tally
      end

  puts "Pick a variety of beer: stout, IPA, sour, or saison."
    beer = gets.chomp
      if beer.downcase == "stout"
        house_tally["Gryffindor"] += 1
      elsif beer.downcase == "ipa"
        house_tally["Hufflepuff"] += 1
      elsif beer.downcase == "sour"
        house_tally["Slytherin"] += 1
      elsif beer.downcase == "saison"
        house_tally["Ravenclaw"] += 1
      else house_tally = house_tally
      end

  puts "What muggle board game do you enjoy most: Chess, Life, Monopoly, or Risk?"
    game = gets.chomp
      if game.downcase == "chess"
        house_tally["Ravenclaw"] += 1
      elsif game.downcase == "life"
        house_tally["Hufflepuff"] += 1
      elsif game.downcase == "monopoly"
        house_tally["Slytherin"] += 1
      elsif game.downcase == "risk"
        house_tally["Gryffindor"] += 1
      else house_tally = house_tally
      end

  puts "Choose a method of transportation: bike, walk, skateboard, roller blade."
    transport = gets.chomp
      if transport.downcase == "bike"
        house_tally["Gryffindor"] += 1
      elsif transport.downcase == "walk"
        house_tally["Ravenclaw"] += 1
      elsif transport.downcase == "skateboard"
        house_tally["Slytherin"] += 1
      elsif transport.downcase == "roller blade"
        house_tally["Hufflepuff"] += 1
      else house_tally = house_tally
      end

  puts "Pick a Leslie Knope quote (a, b, c, or d):
    (a) I am big enough to admit that I am often inspired by myself.
    (b) We have to remember what's important in life: friends, waffles, and work. Or waffles, friends, work. But work has to come third.
    (c) I took your idea and I made it better.
    (d) Oh my god, I wonder who else was born in Eagleton. Voldemort probably."
    quote = gets.chomp
      if quote.downcase == "a"
        house_tally["Slytherin"] += 1
      elsif quote.downcase == "b"
        house_tally["Hufflepuff"] += 1
      elsif quote.downcase == "c"
        house_tally["Ravenclaw"] += 1
      elsif qutoe.downcase == "d"
        house_tally["Gryffindor"] += 1
      else house_tally = house_tally
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
end

def largest_hash_key(hash)
  hash.max_by{|k,v| v}
end

winning_house = largest_hash_key(house_tally)[0]
puts "Let me think. \nMust be...\n#{winning_house}!"

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

house_id = convert_house(winning_house)

def create_student(db, name, gender, house_id, year, quidditch)
    db.execute("INSERT INTO students (name, gender, house_id, year, quidditch) VALUES (?, ?, ?, ?, ?)", [name, gender, house_id, year, quidditch])
end

def retrieve_tally(db, house_id)
  db.execute("SELECT number_of_students FROM houses WHERE id=#{house_id}")
end

tally = retrieve_tally(db, house_id)[0]

def update_tally(db, house_id, tally)
  new_tally = tally[0] += 1
  db.execute("UPDATE houses SET number_of_students=#{new_tally} WHERE id=#{house_id}")
end