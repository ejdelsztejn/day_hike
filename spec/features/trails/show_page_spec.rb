require 'rails_helper'

RSpec.describe 'trail show page', type: :feature do
  before(:each) do
    @peaked_mountain = Trip.create!(name: "Peaked Mountain", start_date: '2020-07-17', end_date: '2020-07-17')
    @tantiusques = Trip.create!(name: "Tantiusques", start_date: '2020-07-18', end_date: '2020-07-18')
    @lunder_pond_loop = Trail.create!(length: 1, name: "Lunden Pond Loop", address: "43 Butler Road")
    @miller_forest_loop = Trail.create!(length: 2, name: "Miller Forest Loop", address: "43 Butler Road")
    TripTrail.create!(trip: @peaked_mountain, trail: @lunder_pond_loop)
    TripTrail.create!(trip: @peaked_mountain, trail: @miller_forest_loop)
    TripTrail.create!(trip: @tantiusques, trail: @miller_forest_loop)
  end
  it 'can display information about the trail' do
     visit "/trails/#{@miller_forest_loop.id}"

     expect(page).to have_content(@miller_forest_loop.name)
     expect(page).to have_content(@miller_forest_loop.address)
     expect(page).to have_content(@peaked_mountain.name)
     expect(page).to have_content(@peaked_mountain.trails.sum(:length))
     expect(page).to have_content(@tantiusques.name)
     expect(page).to have_content(@tantiusques.trails.sum(:length))
  end
end
