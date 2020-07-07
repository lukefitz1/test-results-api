# frozen_string_literal: true

module Api
  class RequestsController < ApplicationController
    before_action :set_request, only: [:show, :update, :destroy]

    # GET /requests
    def index
      @requests = Request.all

      render json: @requests, include: { assertions: { only: :id } }
    end

    # GET /requests/1
    def show
      render json: @request
    end

    # POST /requests
    def create
      @request = Request.new(request_params)

      if @request.save
        render json: @request, status: :created, location: @request
      else
        render json: @request.errors, status: :unprocessable_entity
      end
    end

    # POST /features
    def create_requests
      error = false

      params['_json'].each do |request|
        @request = Request.new(request_name: request[:request], request_id: request[:id], timestamp: request[:timestamp])

        unless @request.save
          error = true
        end

        unless request[:assertions].empty?
          request[:assertions].each do |assertion|

            @assertion = Assertion.new(assertion_name: assertion[:name], assertion_result: assertion[:result], request_id: @request.id)

            unless @assertion.save
              error = true
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

    # PATCH/PUT /requests/1
    def update
      if @request.update(request_params)
        render json: @request
      else
        render json: @request.errors, status: :unprocessable_entity
      end
    end

    # DELETE /requests/1
    def destroy
      @request.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def request_params
      params.require(:request).permit(:request_name, :request_id, :timestamp)
    end
  end
end
