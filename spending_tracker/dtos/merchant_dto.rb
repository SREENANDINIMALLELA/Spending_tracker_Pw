require_relative('../db/sql_runner')
class MerchantDto
  attr_accessor :merchant_name ,:amount , :frequency
  def initialize(args)
    @frequency = args['frequency']
    @merchant_name = args['merchant_name']
    @amount = args['amount']

  end
end
