require 'rails_helper'

describe TripTrail, type: :model do
  describe 'validations' do
    it do
      should belong_to(:trail)
      should belong_to(:trip)
    end
  end
end
