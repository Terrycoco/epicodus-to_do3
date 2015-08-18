require("rspec")
require("pg")
require("task")
require("category")


DB = PG.connect({:dbname => "to_do_test"})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM task *;")
    DB.exec("DELETE FROM category *;")
  end
end
