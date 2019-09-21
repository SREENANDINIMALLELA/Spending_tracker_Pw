require_relative('../db/sql_runner')
class Transaction
  attr_accessor :merchant_id , :amount,:category_id
  attr_reader :id
  def initialize(options)
    @id = options['id'].to_i()
    @category_id = options['category_id'].to_i
    @merchant_id = options['merchant_id'].to_i
    @amount= options['amount'].to_i

  end
  def save()
    sql = "INSERT INTO transactions
    (
      category_id ,
      merchant_id ,
      amount
    )
    VALUES
    (
      $1,$2,$3
    )
    RETURNING id"
    values = [@category_id,@merchant_id,@amount]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run( sql )
    return results.map { |transaction| Transaction.new( transaction ) }
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql )
  end

  def self.find(id)
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

end
