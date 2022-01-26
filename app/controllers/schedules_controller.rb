class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :update, :destroy]

  # GET /schedules
  def index
    @schedules = Schedule.all

    render jsonapi: @schedules, include: [:room]#, except: [:created_at, :updated_at], 
                #include: [room: { except: [:created_at, :updated_at] }]
  end

  # GET /schedules/1
  def show
    render jsonapi: @schedule, include: [:room] #except: [:created_at, :updated_at], include: [room: { except: [:created_at, :updated_at] } ]
  end

  # POST /schedules
  def create
    @schedule = Schedule.new(schedule_params)

    if @schedule.save
      render jsonapi: @schedule, status: :created, location: @schedule
    else
      render jsonapi_errors: @schedule.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /schedules/1
  def update
    if @schedule.update(schedule_params)
      render jsonapi: @schedule
    else
      render jsonapi_errors: @schedule.errors, status: :unprocessable_entity
    end
  end

  # DELETE /schedules/1
  def destroy
    @schedule.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def schedule_params
      params.require(:schedule).permit(:subject, :start_at, :end_at, :room_id)
    end
end
