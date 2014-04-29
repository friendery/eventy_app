class RatesController < ApplicationController
  def update
    @rate = Rate.find(params[:id])
    @event = @rate.event
    if @rate.update_attributes(score: params[:score])
      User.all.each do |f|
        if f.events.count > 0
          @createdevent = f.events
          sum = 0
          count = 0
          @createdevent.each do |s|
            if(s.average_rate > 0)
              sum += s.average_rate
              count++
            end
          end
          ave = sum / count
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
