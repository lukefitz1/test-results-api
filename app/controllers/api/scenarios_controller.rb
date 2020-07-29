# frozen_string_literal: true

module Api
  class ScenariosController < ApplicationController
    before_action :authenticate_api_key
    before_action :set_scenario, only: [:show, :update, :destroy]

    # GET /scenarios
    def index
      @scenarios = Scenario.all

      render json: @scenarios, include: { steps: { only: :id } }
    end

    # GET /scenarios/1
    def show
      render json: @scenario, include: { steps: { only: :id } }
    end

    # POST /scenarios
    def create
      @scenario = Scenario.new(scenario_params)

      if @scenario.save
        render json: @scenario, status: :created #, location: @scenario
      else
        render json: @scenario.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /scenarios/1
    def update
      if @scenario.update(scenario_params)
        render json: @scenario
      else
        render json: @scenario.errors, status: :unprocessable_entity
      end
    end

    # DELETE /scenarios/1
    def destroy
      @scenario.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
    def set_scenario
      @scenario = Scenario.find(params[:id])
    end

      # Only allow a trusted parameter "white list" through.
    def scenario_params
      # params.fetch(:scenario, {})
      params.require(:scenario).permit(:scenario_name, :feature_id)
    end
  end
end
