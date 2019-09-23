require_relative('../db/sql_runner')
class TransactionCategoryNameDto
  attr_accessor :merchant_name ,:amount ,:date_time
  def initialize(args)
    @merchant_name = args['merchant_name']
    @amount = args['amount'].to_f
    @date_time = args['date_time']
  end
end
