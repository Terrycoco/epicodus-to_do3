class Task

  attr_reader(:description, :id )

  define_method(:initialize) do |attributes|
    @description =  attributes.fetch(:description)
    @id = attributes.fetch(:id)
  end

  # define_method(:save) do
  #   result = DB.exec("INSERT INTO task (description, cat_id) VALUES ('#{@description}', #{@cat_id}) RETURNING id;")
  #   @id = result.first().fetch("id").to_i()
  # end

  define_method(:id) do
    @id
  end

  define_method(:description) do
    @description
  end

end
