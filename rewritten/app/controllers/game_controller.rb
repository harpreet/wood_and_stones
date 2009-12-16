class GameController < ApplicationController
  def create
    @black = (it = params[:black] and User.find_or_create_by_email(it))
    @white = (it = params[:white] and User.find_or_create_by_email(it))
    if (self.current_user and ((not (@black == self.current_user)) and (not (@white == self.current_user)))) then
      render(:status => 401)
    else
      Game.transaction do
        @game = Game.create(:black => (@black), :white => (@white), :dimension => (params[:dimension]), :handicap => (params[:handicap]))
        if @game.valid? then
          Secret.create!(:user => (@game.black), :target => (@game))
          Secret.create!(:user => (@game.white), :target => (@game))
          redirect_to(:method => :show)
        end
      end
    end
  end
end