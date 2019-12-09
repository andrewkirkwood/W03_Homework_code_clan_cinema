require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')
require_relative('./models/screening')

require('pry-byebug')

Screening.delete_all()
Ticket.delete_all()
Customer.delete_all()
Film.delete_all()


customer1 = Customer.new({ 'name' => 'Johnny', 'funds' => 10 })
customer1.save
customer2 = Customer.new({ 'name' => 'Andy', 'funds' => 30 })
customer2.save
customer3 = Customer.new({ 'name' => 'Customer3', 'funds' => 40 })
customer3.save

film1 = Film.new({ 'title' => 'Macbeth', 'price' => 4, 'screening_time' => '1800' })
film1.save
film2 = Film.new({ 'title' => 'Home Alone', 'price' => 10, 'screening_time' => '1830'})
film2.save
film3 = Film.new({ 'title' => 'The Departed', 'price' => 2, 'screening_time' => '1800' })
film3.save
film4 = Film.new({ 'title' => 'Inherent Vice', 'price' => 3, 'screening_time' => '1900' })
film4.save

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id })
ticket1.save
ticket2 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id })
ticket2.save
ticket3 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id })
ticket3.save

screening1 = Screening.new({ 'film_id' => film1.id, 'screening_time' => 1800})
screening1.save
screening2 = Screening.new({ 'film_id' => film2.id, 'screening_time' => 1830})
screening2.save
screening3 = Screening.new({ 'film_id' => film3.id, 'screening_time' => 1800})
screening3.save

film1.customers_watching
film2.customers_watching

binding.pry
nil
