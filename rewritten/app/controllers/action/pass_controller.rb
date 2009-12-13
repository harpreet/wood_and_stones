class Action::PassController < Action::PlayerActionController
  def create
    @move = Action::Pass.create(:game => (@game), :position => (params[:position]))
    render(:status => 403) unless @move.valid?
  end
  def valid
    @move = Action::Pass.new(:game => (@game), :position => (params[:position]))
    render(:status => 403) unless @move.valid?
  end
end