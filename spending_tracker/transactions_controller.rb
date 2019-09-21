require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( 'models/transaction' )
require_relative( 'dtos/transaction_dto' )
require_relative( 'dtos/category_dto' )
require_relative( 'dtos/merchant_dto' )
also_reload( '../models/*' )

get '/spending_tracker' do
 @transactions = Transaction.all()

erb(:"show_all")
end

get '/spending_tracker/category' do
 @transactions = Transaction.find_transactions_by_category()
erb(:"show_by_category")
end

get '/spending_tracker/merchant' do
@transactions = Transaction.find_transactions_by_merchant()

erb(:"show_by_merchant")
end
