require File.dirname(__FILE__) + '/../../test_helper'

class Action::MoveTest < ActiveRecord::TestCase
  
  context Action::Move do
    
    setup do
      @before = Board.create(:dimension => 9)
      @game = Game.create(:dimension => 9)
      @player = 'white'
      @opponent = 'black'
    end
    
    context "to the top-left corner" do
      
      setup do
        @position = 'aa'
      end
      
      context "on an empty board" do
        
        setup do
          @move = Action::Move.create(:game => @game, :before => @before, :position => @position, :player => @player)
        end
        
        should "be a valid move" do
          assert @move.valid?
        end
        
        should "produce a board with the correct placement" do
          assert @move.after
          assert @move.after['aa'].has?(@player)
        end
        
      end
      
      context "when killing another stone" do
        
        setup do
          @before['ab'] = @opponent
          @before['bb'] = @player
          @before['ac'] = @player
          @move = Action::Move.create(:game => @game, :before => @before, :position => @position, :player => @player)
        end
        
        should "be a valid move" do
          assert @move.valid?
        end
        
        should "kill opponent's stones" do
          assert @move.after['ab'].open?
        end
        
      end
        
      context "when playing into suicide" do
        
        setup do
          @before['ab'] = @opponent
          @before['ba'] = @opponent
          @move = Action::Move.create(:game => @game, :before => @before, :position => @position, :player => @player)
        end
        
        should "not be valid" do
          assert !@move.valid?
        end
        
      end
      
      # TODO: Rule of Ko
    
    end
    
  end
  
end