class Board < ActiveRecord::Base
  serialize :board
  
  belongs_to :user
  belongs_to :game


end
