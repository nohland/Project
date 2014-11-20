#this is our app file

 require 'rubygems'
 require 'bundler/setup'
 Bundler.require
 require './models/User'
 require './models/TodoItem'

if ENV['DATABASE_URL']
   ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
   ActiveRecord::Base.establish_connection(
        :adapter  => 'sqlite3',
        :database => 'db/development.db',
        :encoding => 'utf8'
)
end

get '/' do

    erb :welcome

end

post '/' do


end



