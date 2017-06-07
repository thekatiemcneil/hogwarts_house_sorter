# THE SORTING HAT

# require gems (squlite3)
# require 'sqlite3'

# create SQLite3 database
# db = SQLite3::Database.new("sorting_hat.db")

# make table using create table cmd
# create_student_table = <<-SQL
  # CREATE TABLE IF NOT EXISTS students(
    # id INTEGER PRIMARY KEY,
    # name VARCHAR(225),
    # gender VARCHAR(225),
    # house_id INT,
    # year INT,
    # quidditch_interest BOOLEAN,
    # 2nd_house_id INT,
    # 3rd_house_id INT,
    # 4th_house_id INT,
    # FOREIGN KEY (house_id) REFERENCES houses(id),
    # FOREIGN KEY (2nd_house_id) REFERENCES houses(id),
    # FOREIGN KEY (3rd_house_id) REFERENCES houses(id),
    # FOREIGN KEY (4th_house_id) REFERENCES houses(id)
  # )
# SQL

# Create students table (do I need to use the create_table_cmd that they used?)
# done above

# Create houses table

# create_houses_table <<-SQL
  #   CREATE TABLE IF NOT EXISTS houses(
    #   id INTEGER PRIMARY KEY,
    #   name VARCHAR(225),
    #   number_of_students INT
  #   )
# SQL

# db.execute(create_student_table)
# db.execute(create_houses_table)

# Write methods for the actual quiz...ie how the question answers sort the user
#

# Write method to create a user

# Write method that edits user's house after taking quiz
  # Problem: how to identify primary key for the user?

# Add user interface that asks basic user info and quiz questions

# Run user info through the already-created methods

# end