require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews}

  describe 'restaurant review association' do
    let!(:kfc) { Restaurant.create(name: 'KFC') }
    it 'deletes the review when the restaurant is deleted' do
      kfc.reviews.create(thoughts: 'meh', rating: 3)
      expect { kfc.destroy }.to change { Review.count }
    end
  end

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end
end
