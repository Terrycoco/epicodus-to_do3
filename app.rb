require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require('pg')
require('./lib/task')
require('./lib/category')

DB = PG.connect({:dbname => 'to_do_test'})

get('/') do
  @cats = Category.all()
  erb(:index)
end

post('/new') do
  descr = params.fetch('description')
  new_cat = Category.new({:description => descr, :id => nil})
  new_cat.save()
  @cats = Category.all()
  erb(:index)
end

# get('/cats/:id') do
#   id = params.fetch('id').to_i()
#   @cat = Category.find(id)
#   erb(:tasks)
# end

get('/cats/:id/tasks') do
  id = params.fetch('id')
  cat = Category.find(id)
  @cat = cat
  erb(:tasks)

end

post('/cats/:id') do
  descr = params.fetch('description')
  id = params.fetch('id')
  new_task = Task.new({:description => descr, :id => nil})
  cat = Category.find(id)
  cat.add_task(new_task)
  @cat = cat
  erb(:tasks)

end
