require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    data = SqlRunner.run(sql)
    return data.map{|film| Film.new(film)}
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE from films where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON tickets.customer_id = customers.id
    WHERE film_id = $1"
    values = [@id]
    data = SqlRunner.run(sql, values)
    return data.map { |film| Film.new(film)}
  end

  def customers_watching()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON tickets.customer_id = customers.id
    WHERE film_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).count
  end

  def self.screenings
    sql = "SELECT films.*,films.title,screenings.screening_time FROM films
 INNER JOIN screenings ON screenings.film_id = films.id
 WHERE films.id = $1"
    values = [@id]
    data = SqlRunner.run(sql, values)
    return data.map { |screening| Film.new(screening)}
  end


end
