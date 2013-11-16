class CharacterBlueprintsController < ApplicationController
  before_action :set_character_blueprint, only: [:show, :edit, :update, :destroy]
  before_action :set_character

  # GET /character_blueprints
  # GET /character_blueprints.json
  def index
    @character_blueprints = CharacterBlueprint.all
  end

  # GET /character_blueprints/1
  # GET /character_blueprints/1.json
  def show
  end

  # GET /character_blueprints/new
  def new
    @character_blueprint = CharacterBlueprint.new
  end

  # GET /character_blueprints/1/edit
  def edit
  end

  # POST /character_blueprints
  # POST /character_blueprints.json
  def create
    @character_blueprint = CharacterBlueprint.new(character_blueprint_params)

    respond_to do |format|
      if @character_blueprint.save
        format.html { redirect_to character_blueprint_path @character, @character_blueprint, notice: 'Character blueprint was successfully created.' }
        format.json { render action: 'show', status: :created, location: @character_blueprint }
      else
        format.html { render action: 'new' }
        format.json { render json: @character_blueprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /character_blueprints/1
  # PATCH/PUT /character_blueprints/1.json
  def update
    respond_to do |format|
      if @character_blueprint.update(character_blueprint_params)
        format.html { redirect_to action: :show, notice: 'Character blueprint was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @character_blueprint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /character_blueprints/1
  # DELETE /character_blueprints/1.json
  def destroy
    @character_blueprint.destroy
    respond_to do |format|
      format.html { redirect_to character_blueprints_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character_blueprint
      @character_blueprint = CharacterBlueprint.find(params[:id])
    end

    def set_character
      @character = Character.find(params[:character_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def character_blueprint_params
      params[:character_blueprint].permit(:blueprint_id, :material_efficiency, :production_efficiency)
    end
end
