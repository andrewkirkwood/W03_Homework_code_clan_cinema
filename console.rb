require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')

require('pry-byebug')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({ 'name' => 'Johnny', 'funds' => 10 })
customer1.save
customer2 = Customer.new({ 'name' => 'Andy', 'funds' => 30 })
customer2.save
customer3 = Customer.new({ 'name' => 'Customer3', 'funds' => 40 })
customer3.save

film1 = Film.new({ 'title' => 'Macbeth', 'price' => 4 })
film1.save
film2 = Film.new({ 'title' => 'Home Alone', 'price' => 10 })
film2.save
film3 = Film.new({ 'title' => 'The Departed', 'price' => 2 })
film3.save

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

film1.customers_watching
film2.customers_watching

binding.pry
nil
