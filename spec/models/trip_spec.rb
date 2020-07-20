require 'rails_helper'

describe Trip, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }

    it { should have_many(:trails).through(:trip_trails) }
  end
end
