

You are going to make a table for tracking bounties for Space Cowboys.

An entry in the bounty table must have a selection of 4 of these properties:

name
species
bounty value
danger level (low, medium, high, ermagerdyerderd)
last known location
homeworld
favourite weapon
cashed_in
collected_by
Getting Started Checklist

Set up your directory structure
Create a Ruby file for your Bounty class
Write your class definition in the file - initialize, attr_readers, instance variables
Make the database - createdb in command line
Make a .sql file and write some SQL to create your database table
Run the .sql file to set up the table (psql -d data_base_name -f file_name.sql)
Create console.rb to create some new objects and practice your methods (can do this as you are writing the methods to test them)
Implement save, update and delete methods on your class
Extension

Implement a find method given an id that returns one instance of your class that matches that id (do you have to use a map method? Hmm.) E.G
   bounty_hunter_1 = BountyHunter.find(1)
   puts bounty_hunter_1
Should print out the object for the bounty hunter.
