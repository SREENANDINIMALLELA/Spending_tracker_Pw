require_relative('../db/sql_runner')
class Category
  attr_accessor :name
  attr_reader :id
  def initialize(options)
    @name =options['name']
  end
  def save()
    sql = "INSERT INTO categories
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM categories"
    results = SqlRunner.run( sql )
    return results.map { |category| Category.new( category) }
  end

  def self.delete_all()
    sql = "DELETE FROM categories"
    SqlRunner.run( sql )
  end

  def self.find(id)
    sql = "DELETE FROM categories
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

end
