class ApplicationController < ActionController::Base
  #protect_from_forgery

  before_filter :load_game

  def index; end

  private
    def load_game
      require_dependency 'game'
    end
end
