require_relative('../db/sql_runner')
require ('date')
class Transaction
  attr_accessor :merchant_id , :amount,:category_id,:date_time
  attr_reader :id
  def initialize(options)
    # @id = options['id'].to_i()
    @category_id = options['category_id'].to_i
    @merchant_id = options['merchant_id'].to_i
    @amount= options['amount'].to_i
    @date_time = options['date_time']
    p @date_time
    # @date_time = Date.strptime( options['date_time'] ,"%Y-%M-%d %H:%m:%6N")


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

  def self.get_all_transactions()
    sql = "SELECT categories.name AS category_name , merchants.name as merchant_name , transactions.amount , transactions.date_time from transactions inner join merchants on transactions.merchant_id = merchants.id inner join categories on transactions.category_id =categories.id order by transactions.date_time ;"
    results = SqlRunner.run( sql )
    return results.map { |transaction| TransactionDto.new( transaction ) }
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
  def self.find_transactions_by_category()
    sql="SELECT categories.name as category_name ,SUM( transactions.amount) as amount FROM transactions INNER JOIN categories ON transactions.category_id = categories.id GROUP BY categories.name"
     results = SqlRunner.run( sql)
   return results.map { |transaction| GroupByCategoryDto.new( transaction ) }
  end
  def self.find_transactions_by_category_name(name)
    sql="SELECT categories.name AS category_name , merchants.name as merchant_name , transactions.amount , transactions.date_time from transactions inner join merchants on transactions.merchant_id = merchants.id inner join categories on transactions.category_id =categories.id where categories.name = $1 order by transactions.date_time;"
    values = [name]
     results = SqlRunner.run( sql,values )
     result = results.map { |transaction| TransactionDto.new( transaction ) }
    return result
  end
  def self.find_transactions_by_merchant()
    sql ="SELECT count (merchants.name) as frequency , merchants.name as merchant_name , SUM( transactions.amount) as amount  FROM transactions INNER JOIN merchants ON transactions.merchant_id = merchants.id GROUP BY  merchants.name"
    results=SqlRunner.run( sql)
    return results.map { |transaction| GroupByMerchantDto.new( transaction ) }
  end
  def self.find_transactions_by_merchant_name(name)
    p name
    sql ="SELECT count (merchants.name) as frequency , merchants.name as merchant_name , SUM( transactions.amount) as amount  FROM transactions INNER JOIN merchants ON transactions.merchant_id = merchants.id where merchants.name = $1 GROUP BY  merchants.name"
    values = [name]
    results=SqlRunner.run( sql , values)
    p "emroiiiii"
result  = results.map { |transaction| GroupByMerchantDto.new( transaction ) }
p result
 return result
  end
  def self.find(date_time)
    sql = "SELECT (SELECT date_time FROM transactions WHERE id = @id )::timestamp::date"
    values = [id]
    SqlRunner.run( sql, values )

  end

end
