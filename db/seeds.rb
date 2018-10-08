# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'

categories = [{name:"musica"},
              {name:"arte"},
              {name:"moda"}]

Category.create(categories)

careers = [{name:"Ingenieria Civil"},
              {name:"Enfermeria"},
              {name:"Odontologia"}]

Career.create(careers)

users_data = [{email:"sbaixas@miuandes.cl", password:"123456", password_confirmation:"123456", first_name:"Sebastian", last_name:"Baixas", age: 27, gender: true, active: true, accumulated_score: 0, career_id: 1}]

users = User.create(users_data)

surveys_data = {name:"Encuesta Generica", description:"Texto que describe de manera detallada la encuesta generica, deberia ser mas o menos largo.", score: 120, start_date: DateTime.new(2018,10,5), end_date: DateTime.new(2018,10,20), max_answers: 100, min_answers: 15}

survey1 = Survey.create(surveys_data)

open_question1 = OpenQuestion.create(survey: survey1, statement: "Texto de pregunta abierta generica asociada a la encuesta puede ser tan largo como la descripcion.")

alternative_question1 = AlternativeQuestion.create(survey: survey1, statement: "Texto pregunta de alternativas generica asociada a la encuesta deberia ser mas corto que el de prgunta abierta.")

alternative11 = Alternative.create(alternative_question: alternative_question1, content: "Contenido en texto de la alternativa 1.")
alternative12 = Alternative.create(alternative_question: alternative_question1, content: "Contenido en texto de la alternativa 2.")
alternative13 = Alternative.create(alternative_question: alternative_question1, content: "Contenido en texto de la alternativa 3.")
alternative14 = Alternative.create(alternative_question: alternative_question1, content: "Contenido en texto de la alternativa 4.")

multiple_question1 = MultipleQuestion.create(survey: survey1, statement: "Texto pregunta de seleccion multiple generica asociada a la encuesta deberia ser mas corto que el de prgunta abierta.")

multiple11 = Alternative.create(alternative_question: alternative_question1, content: "Contenido en texto de la alternativa 1.")
multiple12 = Alternative.create(alternative_question: alternative_question1, content: "Contenido en texto de la alternativa 2.")
multiple13 = Alternative.create(alternative_question: alternative_question1, content: "Contenido en texto de la alternativa 3.")
multiple14 = Alternative.create(alternative_question: alternative_question1, content: "Contenido en texto de la alternativa 4.")


SurveyState.create(user: users[0], survey: survey1, state: 'Not Delivered')

