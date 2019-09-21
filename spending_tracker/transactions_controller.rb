require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( 'models/transaction' )
require_relative( 'models/transaction_dto' )
also_reload( '../models/*' )

get '/spending_tracker' do
 @transactions = Transaction.all()

erb(:"show_all")
end
