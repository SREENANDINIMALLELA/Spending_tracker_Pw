require_relative('../db/sql_runner')
class Customer
  attr_accessor :name , :wallet
   attr_reader :id
  def initialize(options)
    p options
    @name = options['name']
    @wallet= options['wallet'].to_i
  end
  def save()

    sql = "INSERT INTO customers
    (
      name , wallet
    )
    VALUES
    (
      $1 , $2
    )
    RETURNING id
  "
    values = [@name , @wallet]
   results = SqlRunner.run(sql, values)
  @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    results = SqlRunner.run( sql )
    return results.map { |customer| Customer.new( customer) }
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run( sql )
  end

  def self.find(id)
    sql = "SELECT * FROM customers
    WHERE id = $1"
    values = [id]
  p results =  SqlRunner.run( sql, values )
   p cust = results.map { |customer| CustomerDto.new(customer) }
   p cust.first()
  # p return cust
  end

end
