class Api::V1::Activity::ActivitiesController < ApplicationController

  # GET /activities
  # Get all activities, based on current_user and an optional tag for specifying task
  def index
    # byebug
    @activities = PublicActivity::Activity.all

    
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

    return render :json => {:status => 1, :exchange => @activities}

  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = PublicActivity::Activity.all.find(params[:id])
    
    if !@activity
      return render_errors(['No activity found.'])
    end

    return render :json => {:status => 1, :exchange => @activities}
  end

end
