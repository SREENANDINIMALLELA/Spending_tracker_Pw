require_relative('../db/sql_runner')
class TransactionDto
  attr_accessor :category_name ,:merchant_name ,:amount ,:date_time
  def initialize(args)
    @category_name = args['category_name']
    @merchant_name = args['merchant_name']
    @amount = args['amount'].to_f
    @date_time = args['date_time']
  end
end
