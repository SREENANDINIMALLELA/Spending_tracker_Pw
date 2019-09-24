require_relative('../db/sql_runner')
class TransDto
  attr_accessor :count_category
  def initialize(args)
  @count_category = args['count_category']
  end
end
