class Category

attr_reader(:description, :id)

define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @id = attributes.fetch(:id)
    @tasks = []
end

# define_method(:add_task) do |task|
#   @tasks.push(task)
# end


define_singleton_method(:all) do
  categories = []


  cat_result_set = DB.exec("select * from category;")

  cat_result_set.each() do |row|
    description = row.fetch("description")
    cat_id = row.fetch("id").to_i()
    tasks = []

    task_result_set = DB.exec("select * from task where cat_id = #{cat_id};")
    task_result_set.each() do |taskrow|
      task_descr = taskrow.fetch("description")
      task_id = taskrow.fetch("id")
      new_task = Task.new({:description => task_descr, :id => task_id})
      tasks.push(new_task)
    end

    new_cat = Category.new({:description => description, :id => cat_id})
    @tasks = tasks
    categories.push(new_cat)
  end
  categories
end

define_method(:save) do
  result = DB.exec("INSERT INTO category (description) VALUES ('#{@description}') RETURNING id;")
  @id = result.first().fetch("id").to_i()
  @tasks.each do |task|
    task_descr = task.description()
    task_id = DB.exec("INSERT INTO task (description, cat_id) VALUES ('#{task_descr}', #{@id}) RETURNING id;")
  end
end

define_method(:add_task) do |newtask|
  task_descr = newtask.description()
  result = DB.exec("INSERT INTO task (description, cat_id) VALUES ('#{task_descr}', #{@id}) RETURNING id;")
  task_id = result.first().fetch("id").to_i()
  @tasks.push(newtask)
end

define_singleton_method(:find) do |id_to_find|
  #find this record in the database by id number store in result
  result = DB.exec("select * from category where id =  #{id_to_find};")
  #go to first row and fetch the values of that row into variables
  @id = result.first().fetch('id').to_i()
  @description = result.first().fetch('description')
  #create a new object from those returned variables
  new_cat = Category.new({:description => @description, :id => @id})

  #return that object
    new_cat
  end


  define_method(:tasks) do
    @tasks
  end
end #end class
