require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( 'models/transaction' )
require_relative( 'models/transaction_dto' )
also_reload( '../models/*' )

get '/spending_tracker' do
 @transactions = Transaction.all()

erb(:"show_all")
end

get '/spending_tracker/category' do
 @transactions = Transaction.find_transactions_by_catogory()
erb(:"show_by_category")
end
