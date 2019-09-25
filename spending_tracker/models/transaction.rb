require_relative('../db/sql_runner')
require ('date')
class Transaction
  attr_accessor :merchant_id , :amount,:category_id,:transaction_date , :category_count
  attr_reader :id
  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @category_id = options['category_id'].to_i
    @merchant_id = options['merchant_id'].to_i
    @amount= options['amount'].to_i
    @transaction_date = options['transaction_date']
  end
  def save()
    sql = "INSERT INTO transactions
    (
      category_id ,
      merchant_id ,
      amount,
      transaction_date


    )
    VALUES
    (
      $1,$2,$3,$4
    )
    RETURNING id"
    values = [@category_id,@merchant_id,@amount,@transaction_date]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end
  def self.update_category(id,category_id)
    p id
    p category_id

    sql = "UPDATE transactions
    SET
    category_id ,
    merchant_id ,
    amount,
    transaction_date
    =
    $1,$2,$3,$4
    WHERE id = $5"
    values = [category_id,id]
    SqlRunner.run( sql, values )
  end
  def self.update(params)
    sql = "UPDATE transactions
    SET
    (
      category_id ,
      merchant_id ,
      amount,
      transaction_date
      ) =
      (
        $1, $2, $3, $4
      )
      WHERE id = $5"
      values = [params[:category_id],params[:merchant_id],params[:amount],params[:transaction_date], params[:id]]
      SqlRunner.run( sql, values )
    end
    def self.update_transaction(params,id)
      sql = "UPDATE transactions
      SET
      category_id ,
      merchant_id ,
      amount,
      transaction_date
      =
      $1,$2,$3,$4
      WHERE id = $5"
      values = [params[:category_id],params[:merchant_id],params[:amount],params[:transaction_date],id]
      SqlRunner.run( sql, values )
    end
    def self.all()
      sql = "SELECT * from transactions ;"
      results = SqlRunner.run( sql )
      result = results.map { |transaction| TransactionDto.new( transaction ) }
      return result
    end







    def self.get_all_transactions()
      sql = "SELECT  transactions.id, categories.name AS category_name , merchants.name as merchant_name , transactions.amount , transactions.transaction_date  from transactions inner join merchants on transactions.merchant_id = merchants.id inner join categories on transactions.category_id =categories.id order by transactions.transaction_date DESC ;"

      results = SqlRunner.run( sql )
      result = results.map { |transaction| TransactionDto.new( transaction ) }
      return result
    end

    def self.delete_all()
      sql = "DELETE FROM transactions"
      SqlRunner.run( sql )
    end
    def self.delete(id)
      sql = "DELETE FROM transactions where id = $1"
      SqlRunner.run( sql , [id] )
    end

    def self.find(id)
      sql = "SELECT * FROM transactions
      WHERE id = $1"
      values = [id]
      results = SqlRunner.run( sql, values )
      result = results.map { |transaction| Transaction.new( transaction ) }
      return result.first()
    end
    def self.find_transactions_by_category()
      sql="SELECT categories.name as category_name ,SUM( transactions.amount) as amount FROM transactions INNER JOIN categories ON transactions.category_id = categories.id GROUP BY categories.name"
      results = SqlRunner.run( sql)
      return results.map { |transaction| GroupByCategoryDto.new( transaction ) }
    end
    def self.find_transactions_by_category_name(name)
      sql="SELECT categories.name AS category_name , merchants.name as merchant_name , transactions.amount , transactions.transaction_date  from transactions inner join merchants on transactions.merchant_id = merchants.id inner join categories on transactions.category_id =categories.id where categories.name = $1 order by transactions.transaction_date ;"
      values = [name]
      results = SqlRunner.run( sql,values )
      p result = results.map { |transaction| TransactionDto.new( transaction ) }
      return result
    end
    def self.find_transactions_by_merchant()
      sql ="SELECT count (merchants.name) as frequency , merchants.name as merchant_name , SUM( transactions.amount) as amount  FROM transactions INNER JOIN merchants ON transactions.merchant_id = merchants.id GROUP BY  merchants.name"
      results=SqlRunner.run( sql)
      return results.map { |transaction| GroupByMerchantDto.new( transaction ) }
    end
    def self.find_transactions_by_merchant_name(name)
      sql ="SELECT count (merchants.name) as frequency , merchants.name as merchant_name , SUM( transactions.amount) as amount  FROM transactions INNER JOIN merchants ON transactions.merchant_id = merchants.id where merchants.name = $1 GROUP BY  merchants.name"
      values = [name]
      results=SqlRunner.run( sql , values)
      result  = results.map { |transaction| GroupByMerchantDto.new( transaction ) }

      return result
    end

    def self.find_trasaction_wit_id_category_name(id,name)
      sql ="SELECT  transactions.id, categories.name AS category_name , merchants.name as merchant_name , transactions.amount , transactions.transaction_date  from transactions inner join merchants on transactions.merchant_id = merchants.id inner join categories on transactions.category_id =categories.id where transactions.id = $1 And categories.name = $2 order by transactions.transaction_date "
      values = [id,name]
      results=SqlRunner.run( sql , values)
      result  = results.map { |transaction| TransactionDto.new( transaction ) }

      return result
    end
    def self.check_tansaction_id(id)
      sql ="select count (category_id) as category_count from transactions where category_id = $1;"
      values = [id]
      results=SqlRunner.run( sql , values)
      category_count = results.first()['category_count'].to_i
      return category_count
    end
    def self.check_tansaction_merchant_id(id)
      sql ="select count (merchant_id) as merchant_count from transactions where merchant_id = $1;"
      values = [id]
      results=SqlRunner.run( sql , values)
      merchant_count = results.first()['merchant_count'].to_i
      return merchant_count
    end


  end
