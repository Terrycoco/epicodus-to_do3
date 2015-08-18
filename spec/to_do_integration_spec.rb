require('capybara/rspec')
require('./app')
require('pg')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the task path', {:type => :feature}) do
  it('sends user to category page') do
    visit('/')
    fill_in('description' :with => 'user entry')
    click_button('Submit')
    expect(page).to have_content('Buy coffee')
  end
end
