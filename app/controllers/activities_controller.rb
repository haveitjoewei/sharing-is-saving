class ActivitiesController < ApplicationController

  # GET /activities
  # Get all activities, based on current_user and an optional tag for specifying task
  def index
    @activities = PublicActivity::Activity.all
    byebug
    if params.has_key?(:filter)
      filter = params[:filter].to_s
      if filter == 'lender'
        @activities = @activities.where(owner_id: current_user.id)
      elsif filter == 'borrower'
        @activities = @activities.where(recipient_id: current_user.id)
      else
        return render_errors(["Filter has to be either lender or borrower."])
      end
    else
      @activities = @activities.where("owner_id = ? or recipient_id = ?", current_user.id, current_user.id)
    end

    if params.has_key?(:key)
      key = params[:key].to_s
      @activities = @activities.where(key: key)
    end

    activityArray = Array.new
    
    @activities.each do |activity|
      newActivity = update_created_and_updated_at(activity)
      activityArray.push newActivity
    end

    # return render :json => {:status => 1, :activities => @activities}

  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    begin
      @activity = PublicActivity::Activity.all.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render_errors(['No activity found.'])
    end

    return render :json => {:status => 1, :activities => @activities}
  end

  private
    def update_created_and_updated_at(activity)
      newActivity = ActiveSupport::JSON.decode activity.to_json
      newActivity['created_at'] = activity.created_at.to_f
      newActivity['updated_at'] = activity.updated_at.to_f
      return newActivity
    end

end
