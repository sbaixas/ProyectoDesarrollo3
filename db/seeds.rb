# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'date'
require 'firebase_cloud_messenger'
fcm = FirebaseCloudMessenger.new()
fcm.notify_new_survey(User.all)
categories_data = [{name:"Musica"}, 
              {name:"Arte"},
              {name:"Moda"},
          	  {name:"Deporte"}]

categories = Category.create(categories_data)

groups_data = [{tag: "Proyecto de Desarrollo de Software"},
		  {tag: "Introduccion a la Ingenieria de Software"},
		  {tag: "Modelos Estocasticos"}]

groups = Group.create(groups_data)

careers = [{name:"Ingenieria Civil"},
              {name:"Enfermeria"},
              {name:"Odontologia"}]

Career.create(careers)

users_data = [{email:"sbaixas@miuandes.cl", password:"123456", password_confirmation:"123456", first_name:"Sebastian", last_name:"Baixas", birthdate: DateTime.new(1991,8,27), rut:"180182535", gender: "male", active: true, accumulated_score: 120, career_id: 1},
			  {email:"adaldunate@miuandes.cl", password:"123456", password_confirmation:"123456", first_name:"Angeles", last_name:"Aldunate", birthdate: DateTime.new(1993,11,29), rut:"186370430", gender: "female", active: false, accumulated_score: 0, career_id: 1},
			  {email:"jafernandez1@miuandes.cl", password:"123456", password_confirmation:"123456",active: false, accumulated_score: 0, career_id: 1},
			{email:"jvejar1@miuandes.cl", password:"123456", password_confirmation:"123456",active: false, accumulated_score: 0, career_id: 1}]

users = User.create(users_data)

UserGroup.create(user:users[0], group:groups[0])
UserGroup.create(user:users[1], group:groups[0])
UserGroup.create(user:users[2], group:groups[0])
UserGroup.create(user:users[3], group:groups[0])
UserGroup.create(user:users[1], group:groups[1])
UserGroup.create(user:users[2], group:groups[1])
UserGroup.create(user:users[3], group:groups[1])
UserGroup.create(user:users[1], group:groups[2])
UserGroup.create(user:users[2], group:groups[2])



UserCategory.create(user:users[0], category: categories[4])
UserCategory.create(user:users[2], category: categories[4])


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

prize = Prize.create(name:"2 Entradas Cimemark", description:"Para ir con la polola", available: true, start_date: DateTime.new(2018,10,7), end_date: DateTime.new(2018,10,15))
prize = Prize.create(name:"Iphone X", description:"Te aumentará el ego", available: true, start_date: DateTime.new(2018,10,7), end_date: DateTime.new(2018,10,15))

prize = Prize.create(name:"Lavadora automática", description:"Anda a lavar", available: true, start_date: DateTime.new(2018,10,7), end_date: DateTime.new(2018,10,15))

surveys_data = {name:"Olimpiada de bolitas", description:"Quien crees que ganara las olimpiadas?", score: 120, start_date: DateTime.new(2018,10,8), end_date: DateTime.new(2018,10,20), max_answers: 100, min_answers: 15}

survey2 = Survey.create(surveys_data)


alternative_question2 = AlternativeQuestion.create(survey: survey2, statement: "Quien sera el ganador de este año?")

alternative15 = Alternative.create(alternative_question: alternative_question2, content: "O`Rangers")
alternative16 = Alternative.create(alternative_question: alternative_question2, content: "Yellow Mellow")
alternative17 = Alternative.create(alternative_question: alternative_question2, content: "Shining Swarm")
alternative18 = Alternative.create(alternative_question: alternative_question2, content: "Chocolateers")

multiple_question2 = MultipleQuestion.create(survey: survey2, statement: "De los siguientes, que equipos debieron haber llegado a la final?")

multiple15 = MultipleAlternative.create(multiple_question: multiple_question2, content: "Lime Limers")
multiple16 = MultipleAlternative.create(multiple_question: multiple_question2, content: "Momo")
multiple17 = MultipleAlternative.create(multiple_question: multiple_question2, content: "Oceanics")
multiple18 = MultipleAlternative.create(multiple_question: multiple_question2, content: "Savage Speeders")

multiple_question3 = MultipleQuestion.create(survey: survey2, statement: "Cuales de los siguientes te hubiera gustado que vendieran en el evento")

multiple19 = MultipleAlternative.create(multiple_question: multiple_question3, content: "Bolitas")
multiple110 = MultipleAlternative.create(multiple_question: multiple_question3, content: "Churrasco italiano")
multiple111 = MultipleAlternative.create(multiple_question: multiple_question3, content: "Poleras de las olimpiadas")
multiple112 = MultipleAlternative.create(multiple_question: multiple_question3, content: "Globos para los ninos")

prize = Prize.create(name:"Premio", description:"Premio generico por sorteo, descripcion relativamente larga", available: true, start_date: DateTime.new(2018,10,7), end_date: DateTime.new(2018,10,9))
UserPrize.create(user: users[0],prize: prize)

#SurveyState.create(user: users[0], survey: survey1, state: 'Not Delivered')
Filter.create(survey: survey2, query: "categories.name = 'Deporte'")
Filter.create(survey: survey1, query: "groups.tag = 'Proyecto de Desarrollo de Software'")
