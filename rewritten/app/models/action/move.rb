class Action::Move < Action::PlaceStone
  before_validation_on_create(:remove_opponent_dead_stones)
  private
  def remove_opponent_dead_stones
    stones_to_remove = self.after.dead_stones[(self.player == "black") ? (1) : (0)]
    stones_to_remove.each(&:remove)
  end
end