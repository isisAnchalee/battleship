FactoryGirl.define do
  factory :waiting_game do
    first_player_id 1
    second_player_id 0
    room_name "hellohello"
    full false
    state 'waiting'
  end

  factory :setup_game do
    first_player_id 1
    second_player_id 2
    room_name "Game In Setup Mode"
    full true
    state 'setup'
  end
end
