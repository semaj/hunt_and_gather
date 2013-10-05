class BuildingsController < ApplicationController
  # GET /buildings
  # GET /buildings.json
  def index
    @buildings = Building.all

  end

  # GET /buildings/1
  # GET /buildings/1.json
  def show
    @building = Building.find(params[:id])
  end

  # GET /buildings/new
  # GET /buildings/new.json
  def new
    @building = Building.new

  end

  # GET /buildings/1/edit
  def edit
    @building = Building.find(params[:id])
  end

  # POST /buildings
  # POST /buildings.json
  def create
    @building = Building.new(params[:building])

    respond_to do |format|
      if @building.save
        format.html { redirect_to @building, notice: 'Building was successfully created.' }
        format.json { render json: @building, status: :created, location: @building }
      else
        format.html { render action: "new" }
        format.json { render json: @building.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /buildings/1
  # PUT /buildings/1.json
  def update
    @building = Building.find(params[:id])

    respond_to do |format|
      if @building.update_attributes(params[:building])
        format.html { redirect_to @building, notice: 'Building was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @building.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buildings/1
  # DELETE /buildings/1.json
  def destroy
    @building = Building.find(params[:id])
    @building.destroy

  end
end
