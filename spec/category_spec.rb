require('rspec')
require('pg')
require('category')


DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
      DB.exec("DELETE from task *;")
      DB.exec("DELETE from category *;")
  end
end



describe (Category) do

  describe('#initialize') do
    it('creates a new category object') do
      test_cat = Category.new({:description =>'school', :id => nil})
      expect(test_cat.description()).to(eq('school'))
    end
  end

  describe('#save') do
    it ('saves one instance of the category object') do
      test_cat = Category.new({:description => 'description', :id => nil})
      test_cat.save()
      expect(test_cat.description()).to(eq('description'))
    end
  end

  describe('.all') do
    it('should be empty at first') do
      expect(Category.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves 2 instances and checks to see that both were saved') do
      test_cat = Category.new({:description => 'description', :id => nil})
      test_cat.save()
      test_cat2 = Category.new({:description => 'school', :id => nil})
      test_cat2.save()
      expect(Category.all().length()).to(eq(2))
    end
  end

  describe('#id') do
    it ('returns the id back') do
      test_cat = Category.new({:description => 'description', :id => nil})
      test_cat.save()
      expect(test_cat.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.find') do
    it('finds the record with given id and returns the Category object') do
      test_cat = Category.new({:description => 'description', :id => nil})
      test_cat.save()
      test_cat_id = test_cat.id()
      new_cat = Category.find(test_cat_id)
      new_cat_id = new_cat.id()
      expect(new_cat_id == test_cat_id).to(eq(true))
    end
  end

  describe('#tasks') do
   it('returns the array of task objects that are children of me') do
     test_cat = Category.new({:description => 'me', :id => nil})
     test_cat.save()
     new_task = Task.new({:description => 'child1', :id => nil})
     task_id = test_cat.add_task(new_task)
     new_task = Task.new({:description => 'child2', :id => nil})
     task_id = test_cat.add_task(new_task)
     expect((test_cat.tasks()).length().>(0))
   end
  end

end #end class
