class InterestsController < ApplicationController
  before_action :set_interest, only: [:show, :edit, :update, :destroy]

  # GET /interests
  # GET /interests.json
  def index
    @interests = Interest.all
  end

  # GET /interests/1
  # GET /interests/1.json
  def show
  end

  # GET /interests/new
  def new
    @interest = Interest.new
  end

  # GET /interests/1/edit
  def edit
  end

  def addInterest
    course_id = params[:course_id]
    person_id = current_person.id
    @interest = Interest.new
    @interest.course_id = course_id
    @interest.person_id = person_id
    @interest.save
    jsonObject = {"interestedPeople" => getInterestedPeople(course_id).length}
    respond_to do |format|
      format.html
      format.json { render json: jsonObject }
    end
  end

  def getInterestedPeople(course_id)
    @course = Course.find(course_id)
    @interests = @course.interests
    return @interests
  end

  def removeInterest
    course_id = params[:course_id]
    person_id = current_person.id
    @interest = current_person.interests.where('course_id = ?', "#{course_id}").first
    Interest.destroy(@interest.id)
    jsonObject = {"interestedPeople" => getInterestedPeople(course_id).length}
    respond_to do |format|
      format.html
      format.json { render json: jsonObject }
    end
  end

  # POST /interests
  # POST /interests.json
  def create
    @interest = Interest.new(interest_params)

    respond_to do |format|
      if @interest.save
        format.html { redirect_to @interest, notice: 'Interest was successfully created.' }
        format.json { render :show, status: :created, location: @interest }
      else
        format.html { render :new }
        format.json { render json: @interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interests/1
  # PATCH/PUT /interests/1.json
  def update
    respond_to do |format|
      if @interest.update(interest_params)
        format.html { redirect_to @interest, notice: 'Interest was successfully updated.' }
        format.json { render :show, status: :ok, location: @interest }
      else
        format.html { render :edit }
        format.json { render json: @interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interests/1
  # DELETE /interests/1.json
  def destroy
    @interest.destroy
    respond_to do |format|
      format.html { redirect_to interests_url, notice: 'Interest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interest
      @interest = Interest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interest_params
      params.fetch(:interest, {})
    end
end
