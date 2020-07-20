require 'rails_helper'

RSpec.describe 'hiking trip show page', type: :feature do
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
  it 'can display a list of trails included in the trip' do
    visit "/trips/#{@peaked_mountain.id}"

    expect(page).to have_content(@peaked_mountain_1.name)
    expect(page).to have_content(@peaked_mountain_1.length)
    expect(page).to have_content(@peaked_mountain_1.address)
    expect(page).to have_content(@peaked_mountain_2.name)
    expect(page).to have_content(@peaked_mountain_2.length)
    expect(page).to have_content(@peaked_mountain_2.address)
  end
end
