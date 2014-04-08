class RatesController < ApplicationController
  def update
    @rate = Rate.find(params[:id])
    @event = @rate.event
    if @rate.update_attributes(score: params[:score])
      User.all.each do |f|
        if f.events.count > 0
          @createdevent = f.events
          sum = 0
          @createdevent.each do |s|
            sum += s.average_rate
          end
          ave = sum / @createdevent.count
          rate = (1 + Math.log(@createdevent.count))*ave
          f.update_attribute(:rate, rate)
        else
          rate = 0
          f.update_attribute(:rate, rate)
        end
      end
      respond_to do |format|
        format.js
      end
    end
  end
end
