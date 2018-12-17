# README

This is a Gateway Microservice which is aimed to provide Requests filter layer and route the incoming requests to specific microservice from Front-end Application and serve the data requested.

Things you may want to cover:

* Ruby version: 2.5.1

* System dependencies: PostgresSQL, Rails, RVM

* Database creation: 

  1. Create a postgres user
  2. Create a database and ensure that new postgres user created owns the database. 
  3. Configre database.yml file
  4. rake db:migrate (to run migrations)

* How to run the test suite: rspec (from the project directory)

* Deployment instructions: cap deploy productio

* Running application (from the project directory): 

  1. Use RVM and create a gemset (ex: rvm use 2.5.1@tg_gateway --create)
  2. gem install bundle 
  3. bundle install
  4. rake db:migrate
  5. rails s 

* To view the API interface please visit: http://localhost:3000/docs/