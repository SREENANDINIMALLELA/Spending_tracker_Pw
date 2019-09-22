require_relative('../db/sql_runner')
class TransactionDto
  attr_accessor :category_name ,:merchant_name ,:amount
  @@total_amount = 0

  def initialize(args)
    @category_name = args['category_name']
    @merchant_name = args['merchant_name']
    @amount = args['amount'].to_f

    @@total_amount  = @@total_amount + @amount
  end

  # getter
 def self.total_amount
   @@total_amount
 end
 
end
