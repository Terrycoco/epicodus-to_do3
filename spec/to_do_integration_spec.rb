require('capybara/rspec')
require('./app')
require('pg')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the task path', {:type => :feature}) do
  it('sends user to category page') do
    visit('/')
    fill_in('description', :with => 'user entry')
    click_button('Add Category')
    expect(page).to have_content('user entry')
  end

  it('sends the user to the task detail list') do
    visit('/')
    fill_in('description', :with => 'user entry2')
    click_button('Add Category')
    click_link('user entry2')
    expect(page).to have_content('Tasks for user entry2')
  end
end
