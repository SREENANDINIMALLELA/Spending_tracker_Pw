require_relative('../db/sql_runner')
class CategoryDto
  attr_accessor :id ,:name
  def initialize(args)
    p "neee#{args}"
    @id = args['id']
    @name = args['name']
  end
end
