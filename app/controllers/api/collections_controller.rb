# frozen_string_literal: true

module Api
  class CollectionsController < ApplicationController
    before_action :authenticate_api_key
    before_action :set_collection, only: [:show, :update, :destroy]

    # GET /collections
    def index
      @collections = if params['latest'] == 'true'
                       Collection.order('created_at').last
                     else
                       Collection.all
                     end

      render json: @collections
    end

    # GET /collections/1
    def show
      render json: @collection
    end

    # POST /collections
    def create
      @collection = Collection.new(collection_params)

      if @collection.save
        render json: @collection, status: :created, location: @collection
      else
        render json: @collection.errors, status: :unprocessable_entity
      end
    end

    # POST /collections/create_collection
    def create_collection
      error = false

      collection = params['collection']
      @collection = Collection.new(description: collection[:description], date: collection[:date])

      unless @collection.save
        error = true
      end

      unless collection[:requests].empty?
        collection[:requests].each do |request|
          @request = Request.new(request_name: request[:request], request_id: request[:id], timestamp: request[:timestamp], collection_id: @collection.id)

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
      end

      if error
        render json: { error: 'there was an error saving the data' }, status: :unprocessable_entity
      else
        render json: { good: 'stuff' }, status: :ok
      end
    end

    # PATCH/PUT /collections/1
    def update
      if @collection.update(collection_params)
        render json: @collection
      else
        render json: @collection.errors, status: :unprocessable_entity
      end
    end

    # DELETE /collections/1
    def destroy
      @collection.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def collection_params
      params.fetch(:collection, {})
    end
  end
end
