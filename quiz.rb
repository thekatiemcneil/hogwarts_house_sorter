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

create_houses_table <<-SQL
    CREATE TABLE IF NOT EXISTS houses(
      id INTEGER PRIMARY KEY,
      name VARCHAR(225),
      number_of_students INT
    )
SQL

db.execute(create_student_table)
db.execute(create_houses_table)

# Populate houses table if not already done
def create_house(db, name, number_of_students)
  db.execute("INSERT INTO IF NOT EXISTS houses (name, number_of_students) VALUES (?, ?)", [name, number_of_students])
end

create_house('houses', 'Gryffindor', 0)
create_house('houses', 'Hufflepuff', 0)
create_house('houses', 'Ravenclaw', 0)
create_house('houses', 'Slytherin', 0)

# Write methods for the actual quiz...ie how the question answers sort the user
#

# Write method to create a user
def create_student(db, name, gender, house_id, year, quidditch, second_house_id, third_house_id, fourth_house_id)
    db.execute("INSERT INTO students (name, gender, house_id, year, quidditch, second_house_id, third_house_id, fourth_house_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", [name, gender, house_id, year, quidditch, second_house_id, third_house_id, fourth_house_id])
end

# Write method that edits user's house after taking quiz
  # Problem: how to identify primary key for the user?

# Add user interface that asks basic user info and quiz questions

# Run user info through the already-created methods

# end