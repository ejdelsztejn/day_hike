require 'rails_helper'

RSpec.describe 'hiking trip show page', type: :feature do
  before(:each) do
    @peaked_mountain = Trip.create!(name: "Peaked Mountain", start_date: '2020-07-17', end_date: '2020-07-17')
    @tantiusques = Trip.create!(name: "Tantiusques", start_date: '2020-07-18', end_date: '2020-07-18')
    @lunder_pond_loop = Trail.create!(length: 1, name: "Lunden Pond Loop", address: "43 Butler Road")
    @miller_forest_loop = Trail.create!(length: 2, name: "Miller Forest Trail", address: "43 Butler Road")
    TripTrail.create!(trip: @peaked_mountain, trail: @lunder_pond_loop)
    TripTrail.create!(trip: @peaked_mountain, trail: @miller_forest_loop)
    TripTrail.create!(trip: @tantiusques, trail: @miller_forest_loop)
  end
  it 'can display a list of trails included in the trip' do
    visit "/trips/#{@peaked_mountain.id}"

    expect(page).to have_content(@lunder_pond_loop.name)
    expect(page).to have_content(@lunder_pond_loop.length)
    expect(page).to have_content(@lunder_pond_loop.address)
    expect(page).to have_content(@miller_forest_loop.name)
    expect(page).to have_content(@miller_forest_loop.length)
    expect(page).to have_content(@miller_forest_loop.address)
  end
  it 'can display the total hiking distance of all trails' do
    visit "/trips/#{@peaked_mountain.id}"

    expect(page).to have_content("Total trail length: #{@peaked_mountain.trails.sum(:length)}")
  end
  it 'can display the averge hiking distance of all trails' do
    visit "/trips/#{@peaked_mountain.id}"

    expect(page).to have_content("Average trail length: #{@peaked_mountain.trails.average(:length)}")
  end
  it 'can display the longest trail on the trip' do
    visit "/trips/#{@peaked_mountain.id}"

    expect(page).to have_content("Longest Trail on Trip: #{@peaked_mountain.trails.order(:length).last.name}")
  end
  it 'can display the shortest trail on the trip' do
    visit "/trips/#{@peaked_mountain.id}"

    expect(page).to have_content("Shortest Trail on Trip: #{@peaked_mountain.trails.order(:length).first.name}")
  end
end
