require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( 'models/transaction' )
require_relative( 'models/merchant' )
require_relative( 'models/category' )
require_relative( 'dtos/transaction_dto' )
require_relative( 'dtos/category_dto' )
require_relative( 'dtos/merchant_dto' )
also_reload( '../models/*' )

get '/spending_tracker' do
 @transactions = Transaction.all()

erb(:'transaction/show_all')
end

get '/spending_tracker/category' do
 @transactions = Transaction.find_transactions_by_category()
erb(:'category/show_by_category')
end

get '/spending_tracker/merchant' do
@transactions = Transaction.find_transactions_by_merchant()
erb(:"merchant/show_by_merchant")
end

get'/spending_tracker/merchant/new'do
erb(:"merchant/new")
end
post'/spending_tracker/merchant'do
merchant = Merchant.new(params)
merchant.save
erb(:"merchant/create")
end

get'/spending_tracker/category/new'do
erb(:"category/new")
end
post'/spending_tracker/category'do
category = Category.new(params)
category.save
erb(:"category/create")
end
