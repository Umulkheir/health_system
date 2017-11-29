class HomeController < ApplicationController
	layout 'dashboard', only: [:error]
  def index
  end
  def error
  	
  end
end
