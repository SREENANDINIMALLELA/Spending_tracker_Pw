require_relative('../db/sql_runner')
class CustomerDto
  attr_accessor :wallet
  @wallet = 0
  def initialize(args)
     @wallet = args['wallet'].to_i
  end

end
