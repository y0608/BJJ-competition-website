Хостнат сайт: https://award-bjj-a08d09ff6f9c.herokuapp.com/

# BJJ-competition-website
A website for Brazilian Jiu Jitsu competitions

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.


### Installing
#### Ruby
You can find instruction on how to install ruby with rvm on [the official website](https://rvm.io/rvm/install).
Current ruby version: 3.2.0

#### PosgreSQL
From [Digital Ocean tutorial](https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-20-04)
```
sudo apt update
sudo apt install postgresql postgresql-contrib libpq-dev
sudo -u postgres createuser -s $USER -P
```

### Run the project
1. Clone the repository:
```
git clone https://github.com/y0608/BJJ-competition-website.git
```
2. Change into the project directory
```
cd BJJ-competition-website/
```
3. Change into the rails directory
```
cd awardbjj/
```
4. Install project gems
```
bundle install
```
5. Create database
```
rails db:create db:migrate
```
6. Run the rails server
```
bin/dev
```
7. Access the website from the browser. Go to: `http://localhost:3000/`

