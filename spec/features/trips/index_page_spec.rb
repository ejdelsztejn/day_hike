require 'rails_helper'

RSpec.describe 'hiking trips index page', type: :feature do
  before(:each) do
    @peaked_mountain = Trip.create(name: "Peaked Mountain", start_date: '2020-07-17', end_date: '2020-07-17')
    @tantiusques = Trip.create(name: "Tantiusques", start_date: '2020-07-18', end_date: '2020-07-18')
    @peaked_mountain_1 = @peaked_mountain.trails.create(length: 1, name: "Lunden Pond Loop", address: "43 Butler Road")
    @peaked_mountain_2 = @peaked_mountain.trails.create(length: 2, name: "Miller Forest Trail", address: "43 Butler Road")
    @tantiusques_1 = @tantiusques.trails.create(length: 2, name: "Tantiusques Loop", address: "493 Leadmine Rd")
    TripTrail.create(trip: @peaked_mountain, trail: @peaked_mountain_1)
    TripTrail.create(trip: @peaked_mountain, trail: @peaked_mountain_2)
    TripTrail.create(trip: @tantiusques, trail: @tantiusques_1)
  end
  it 'can display a list of all hiking trip names' do
    peaked_mountain = Trip.create(name: "Peaked Mountain", start_date: '2020-07-17', end_date: '2020-07-17')
    tantiusques = Trip.create(name: "Tantiusques", start_date: '2020-07-18', end_date: '2020-07-18')
    peaked_mountain_1 = peaked_mountain.trails.create(length: 1, name: "Lunden Pond Loop", address: "43 Butler Road")
    peaked_mountain_2 = peaked_mountain.trails.create(length: 2, name: "Miller Forest Trail", address: "43 Butler Road")
    tantiusques_1 = tantiusques.trails.create(length: 2, name: "Tantiusques Loop", address: "493 Leadmine Rd")
    TripTrail.create(trip: peaked_mountain, trail: peaked_mountain_1)
    TripTrail.create(trip: peaked_mountain, trail: peaked_mountain_2)
    TripTrail.create(trip: tantiusques, trail: tantiusques_1)

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