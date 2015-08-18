require('rspec')
require('category')
require('task')
require('pg')

DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
      DB.exec("DELETE from task *;")
  end
end

describe(Task) do

describe('#initialize') do
  it('creates a new task for an object') do
    new_task = Task.new({:description => 'description', :id => nil })
    expect(new_task.description()).to(eq('description'))
  end
end

# describe('#id') do
#   it('returns a new task with its id ') do
#     new_cat = Category.new({:description => 'mother category', :id => nil})
#     new_cat.save()
#     new_cat_id = new_cat.id()
#     new_task = Task.new({:description => 'i am a task', :id => nil })
#     self.add_task(new_task)
#     expect(new_task.id()).to(be_an_instance_of(Fixnum))
#   end
# end

end
