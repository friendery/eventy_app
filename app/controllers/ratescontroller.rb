class RatesController < ApplicationController
  def update
    @rate = Rate.find(params[:id])
    @event = @rate.comment
    if @rate.update_attributes(score: params[:score])
      respond_to do |format|
      format.js
      end
    end
  end
end