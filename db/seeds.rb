# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
categories = [{name:"musica"},
              {name:"arte"},
              {name:"moda"}]

Category.create(categories)

careers = [{name:"Ingenieria Civil"},
              {name:"Enfermeria"},
              {name:"Odontologia"}]

Career.create(careers)

users = [{email:"sbaixas@miuandes.cl", password:"123456", password_confirmation:"123456", first_name:"Sebastian", last_name:"Baixas", age: 27, gender: true, active: true, accumulated_score: 0, career_id: 1}]

User.create(users)