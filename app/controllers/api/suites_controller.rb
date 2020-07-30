# frozen_string_literal: true

module Api
  class SuitesController < ApplicationController
    before_action :authenticate_api_key
    before_action :set_suite, only: [:show, :update, :destroy]

    # GET /suites
    def index
      @suites = if params['latest'] == 'true'
                 Suite.order('created_at').last
               else
                 Suite.all
               end

      render json: @suites
    end

    # GET /suites/1
    def show
      render json: @suite
    end

    # POST /suites
    def create
      @suite = Suite.new(suite_params)

      if @suite.save
        render json: @suite, status: :created#, location: @suite
      else
        render json: @suite.errors, status: :unprocessable_entity
      end
    end

    # POST /suites/create_suite
    def create_suite
      error = false

      suite = params['suite']
      @suite = Suite.new(description: suite[:description], date: suite[:date])

      unless @suite.save
        error = true
      end

      unless suite[:features].empty?
        suite[:features].each do |feature|
          @feature = Feature.new(feature_name: feature[:feature_name], suite_id: @suite.id)

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
      end

      if error
        render json: { error: 'there was an error saving the data' }, status: :unprocessable_entity
      else
        render json: { good: 'stuff' }, status: :ok
      end
    end

    # PATCH/PUT /suites/1
    def update
      if @suite.update(suite_params)
        render json: @suite
      else
        render json: @suite.errors, status: :unprocessable_entity
      end
    end

    # DELETE /suites/1
    def destroy
      @suite.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_suite
        @suite = Suite.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def suite_params
        params.require(:suite).permit(:date, :description)
      end
  end
end
