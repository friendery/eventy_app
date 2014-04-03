class RatesController < ApplicationController
  def update
    @rate = Rate.find(params[:id])
    @event = @rate.event
    if @rate.update_attributes(score: params[:score])
      respond_to do |format|
        format.js
      end
    end
  end
end
