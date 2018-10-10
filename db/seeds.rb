# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'

categories_data = [{name:"musica"}, 
              {name:"arte"},
              {name:"moda"}]

categories = Category.create(categories_data)

groups_data = [{tag: "Grupo Generico 1"},
		  {tag: "Grupo Generico 2"},
		  {tag: "Grupo Generico 3"}]

groups = Group.create(groups_data)

careers = [{name:"Ingenieria Civil"},
              {name:"Enfermeria"},
              {name:"Odontologia"}]

Career.create(careers)

users_data = [{email:"sbaixas@miuandes.cl", password:"123456", password_confirmation:"123456", first_name:"Sebastian", last_name:"Baixas", birthdate: DateTime.new(1991,8,27), rut:"180182535", gender: "male", active: true, accumulated_score: 120, career_id: 1},
			  {email:"adaldunate@miuandes.cl", password:"123456", password_confirmation:"123456", first_name:"Angeles", last_name:"Aldunate", birthdate: DateTime.new(1993,11,29), rut:"186370430", gender: "female", active: false, accumulated_score: 0, career_id: 1}]

users = User.create(users_data)

UserGroup.create(user:users[0], group:groups[0])
UserGroup.create(user:users[0], group:groups[2])


UserCategory.create(user:users[0], category: categories[0])

surveys_data = {name:"Encuesta Generica", description:"Texto que describe de manera detallada la encuesta generica max 30 caracteres.", score: 120, start_date: DateTime.new(2018,10,8), end_date: DateTime.new(2018,10,20), max_answers: 100, min_answers: 15}

survey1 = Survey.create(surveys_data)

open_question1 = OpenQuestion.create(survey: survey1, statement: "Texto de pregunta abierta generica asociada a la encuesta max 30 caracteres.")

alternative_question1 = AlternativeQuestion.create(survey: survey1, statement: "Texto pregunta de alternativas generica asociada a la encuesta max 30 caracteres.")

alternative11 = Alternative.create(alternative_question: alternative_question1, content: "Contenido en texto de la alternativa 1.")
alternative12 = Alternative.create(alternative_question: alternative_question1, content: "Contenido en texto de la alternativa 2.")
alternative13 = Alternative.create(alternative_question: alternative_question1, content: "Contenido en texto de la alternativa 3.")
alternative14 = Alternative.create(alternative_question: alternative_question1, content: "Contenido en texto de la alternativa 4.")

multiple_question1 = MultipleQuestion.create(survey: survey1, statement: "Texto pregunta de seleccion multiple generica asociada a la encuesta max 30 caracteres.")

multiple11 = MultipleAlternative.create(multiple_question: multiple_question1, content: "Contenido en texto de la alternativa 1.")
multiple12 = MultipleAlternative.create(multiple_question: multiple_question1, content: "Contenido en texto de la alternativa 2.")
multiple13 = MultipleAlternative.create(multiple_question: multiple_question1, content: "Contenido en texto de la alternativa 3.")
multiple14 = MultipleAlternative.create(multiple_question: multiple_question1, content: "Contenido en texto de la alternativa 4.")

Prize.create(name:"Premio", description:"Premio generico por sorteo max 30 caracteres.", available: true, start_date: DateTime.new(2018,10,8), end_date: DateTime.new(2018,11,11))


#SurveyState.create(user: users[0], survey: survey1, state: 'Not Delivered')
Filter.create(survey: survey1, query: "users.gender = 'male' AND categories.name = 'musica'")
