# frozen_string_literal: true

module Api
  class FeaturesController < ApplicationController
    before_action :set_feature, only: [:show, :update, :destroy]

    # GET /features
    def index
      @features = Feature.all

      render json: @features, include: { scenarios: { only: :id, include: { steps: { only: :id } } } }
    end

    # GET /features/1
    def show
      render json: @feature, include: { scenarios: { only: :id, include: { steps: { only: :id } } } }
    end

    # POST /features
    def create
      @feature = Feature.new(feature_params)

      if @feature.save
        render json: @feature, status: :created #, location: @feature
      else
        render json: @feature.errors, status: :unprocessable_entity
      end
    end

    # POST /features
    def create_features
      error = false

      params['_json'].each do |feature|
        @feature = Feature.new(feature_name: feature[:feature_name])

        unless @feature.save
          error = true
        end

        unless feature[:scenarios].empty?
          feature[:scenarios].each do |scenario|
            @scenario = Scenario.new(scenario_name: scenario[:scenario_name], feature_id: @feature.id)

            unless @scenario.save
              error = true
            end

            unless scenario[:steps].empty?
              scenario[:steps].each do |step|
                @step = Step.new(step_name: step[:step_name], result: step[:result], scenario_id: @scenario.id)

                unless @step.save
                  error = true
                end
              end
            end
          end
        end
      end

      if error
        render json: { error: 'there was an error saving the data' }, status: :unprocessable_entity
      else
        render json: { good: 'stuff' }, status: :ok
      end
    end

    # PATCH/PUT /features/1
    def update
      if @feature.update(feature_params)
        render json: @feature
      else
        render json: @feature.errors, status: :unprocessable_entity
      end
    end

    # DELETE /features/1
    def destroy
      @feature.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_feature
      @feature = Feature.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def feature_params
      params.require(:feature).permit(:feature_name)
    end
  end
end
