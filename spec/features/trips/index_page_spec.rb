require 'rails_helper'

RSpec.describe 'hiking trips index page', type: :feature do
  before(:each) do
    @peaked_mountain = Trip.create!(name: "Peaked Mountain", start_date: '2020-07-17', end_date: '2020-07-17')
    @tantiusques = Trip.create!(name: "Tantiusques", start_date: '2020-07-18', end_date: '2020-07-18')
    @lunder_pond_loop = Trail.create!(length: 1, name: "Lunden Pond Loop", address: "43 Butler Road")
    @miller_forest_loop = Trail.create!(length: 2, name: "Miller Forest Trail", address: "43 Butler Road")
    TripTrail.create!(trip: @peaked_mountain, trail: @lunder_pond_loop)
    TripTrail.create!(trip: @peaked_mountain, trail: @miller_forest_loop)
    TripTrail.create!(trip: @tantiusques, trail: @miller_forest_loop)
  end
  it 'can display a list of all hiking trip names' do
    visit '/trips'

    expect(page).to have_content("#{@peaked_mountain.name}")
    expect(page).to have_content("#{@tantiusques.name}")
  end
  it 'can link to a unique page for each hiking trip' do
    visit '/trips'

    expect(page).to have_link("Peaked Mountain")

    click_on "Peaked Mountain"

    expect(current_path).to eq("/trips/#{@peaked_mountain.id}")
  end
end
