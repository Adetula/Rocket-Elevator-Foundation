class InterventionsController < ApplicationController
  before_action :set_intervention, only: %i[ show edit update destroy ]

  def getBuildingsByCustomer
      @customer_id = params[:customer_id]
                                  #column      #compared thing
      @buildings = Building.where(customer_id: @customer_id)

      puts @buildings

      respond_to do |format|
        format.json { render :json => @buildings }
      end
  end

  
  def getBatteriesByBuilding
    @batteries = Battery.where(building_id: params[:building_id])
    respond_to do |format|
        format.json { render :json => @batteries }
    end
end

  def getColumnsByBattery
    @columns = Column.where(battery_id: params[:battery_id])
    respond_to do |format|
        format.json { render :json => @columns }
    end
end


def getElevatorsByColumn
  @elevators = Elevator.where(column_id: params[:column_id])
  respond_to do |format|
      format.json { render :json => @elevators }
  end
end






  # GET /interventions or /interventions.json
  def index
    @interventions = Intervention.all
  end

  # GET /interventions/1 or /interventions/1.json
  def show
  end

  # GET /interventions/new
  def new
    @intervention = Intervention.new
  end

  # GET /interventions/1/edit
  def edit
  end


  #
  def create
    @intervention = Intervention.new()

    @intervention.author_id = current_user.id
    @intervention.customer_id = params[:customer]
    @intervention.building_id = params[:building]
    @intervention.battery_id = params[:battery]
    @intervention.column_id = params[:column]  
    @intervention.elevator_id = params[:elevator]
    @intervention.employee_id = params[:employee]
    @intervention.report = params[:report]

    

    if @intervention.save!
      redirect_back fallback_location: root_path, notice: "Congrats! Your intevention is successfully saved"
    end 
  end 


  # PATCH/PUT /interventions/1 or /interventions/1.json
  def update
    respond_to do |format|
      if @intervention.update(intervention_params)
        format.html { redirect_to @intervention, notice: "Intervention was successfully updated." }
        format.json { render :show, status: :ok, location: @intervention }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interventions/1 or /interventions/1.json
  def destroy
    @intervention.destroy
    respond_to do |format|
      format.html { redirect_to interventions_url, notice: "Intervention was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intervention
      @intervention = Intervention.find(params[:id])
    end
    
    # Only allow a list of trusted parameters through.
    def intervention_params
      params.require(:intervention).permit(:author, :customer_id, :building_id, :battery_id, :column_id, :elevator_id, :employee_id, :Start_date, :End_Time, :Result, :Report, :Status)
    end
end