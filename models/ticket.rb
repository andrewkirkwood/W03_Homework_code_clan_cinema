require_relative("../db/sql_runner")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    data = SqlRunner.run(sql)
    return data.map{|ticket| Ticket.new(ticket)}
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE from tickets where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def check_enough_funds(customer, film)
    return true if customer.funds >= film.price
    return false if customer.funds < film.price
  end

  def sell_ticket(customer,film)
    if check_enough_funds(customer,film) == true
      customer.reduce_funds(film)
      sql = "UPDATE customers SET funds = $1 WHERE id = $2;"
      values = [customer.funds, customer.id]
      SqlRunner.run(sql, values)
      ticket = ({'customer_id' => customer.id,
      'film_id' => film.id })
      Ticket.new(ticket).save
    else
      return nil
    end
  end
end
