class ApplicationController < ActionController::Base
	include Pagy::Backend

  Pagy::DEFAULT[:items] = 10
  Pagy::DEFAULT[:size]  = [1,0,0,1]
end
