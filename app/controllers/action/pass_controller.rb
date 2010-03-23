class Action::PassController < Action::PlayerActionController
  
  def create
    @pass = Action::Pass.create(
      :game => @game
    )
    (render :status => 403 and return) unless @pass.valid?
    @game.update_notifications(current_user)
    self.assemble_info # it has been updated!
    @info[:move] = @pass
    respond_to do |format|
      format.html {
        render :partial => 'action/gameplay/action', :locals => { :action => @pass }
      }
      format.json {
        render :json => @info
      }
    end
  end
  
  def valid
    @pass = Action::Pass.new(
      :game => @game,
      :position => params[:position]
    )
    render :status => 403 unless @pass.valid?
  end

end
