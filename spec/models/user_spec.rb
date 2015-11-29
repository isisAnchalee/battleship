require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ FactoryGirl.create(:user) }

  context "validations" do
    it { should validate_presence_of :email }
  end

  context "associations" do
    it { should have_many :boards }
    it { should have_many :second_players }
    it { should have_many :first_players }
    it { should have_many :first_player_board }
    it { should have_many :second_player_board }
    it { should have_many :first_players }
    it { should have_many :second_players }
  end
end
