class GamesController < ApplicationController
  def new
    @game = Game.new
    render :new
  end
end
