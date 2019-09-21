require_relative('../db/sql_runner')
class TransactionDto
  attr_accessor :category_name ,:merchant_name ,:amount
  def initialize(args)
    @category_name = args['category_name']
    @merchant_name = args['merchant_name']
    @amount = args['amount'].to_f
  end
end