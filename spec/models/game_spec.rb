require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game){ FactoryGirl.create(:waiting_game) }

  context 'validations' do
    it { should validate_inclusion_of(:state)
                  .in_array(['waiting', 'setup', 'playing', 'over']) }
  end

  context 'associations' do
    it { should belong_to :first_player }
    it { should belong_to :second_player }
    it { should have_one :first_player_board }
    it { should have_one :second_player_board }
  end
end
