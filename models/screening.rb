require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :film_id, :screening_time

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @screening_time = options['screening_time'].to_i
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    data = SqlRunner.run(sql)
    return data.map{|screening| Screening.new(screening)}
  end

  def self.delete_all()
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql)
  end

  def save()
    sql = "INSERT INTO screenings (film_id, screening_time) VALUES ($1, $2) RETURNING id"
    values = [@film_id, @screening_time]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def update()
    sql = "UPDATE screenings SET (film_id, screening_time) = ($1, $2) WHERE id = $3"
    values = [@film_id, @screening_time, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE from screenings where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
