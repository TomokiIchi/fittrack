module Api
    module V1
        class BiometricDatasController < ApplicationController
            before_action :set_data, only: [:show, :update, :destroy]
            def index
                datas = BiometricDatum.order(created_at: :desc)
                render json: { status: 'success', message: 'Loaded datas', data: datas }
            end

            def show
                render json: { status: 'success', message: 'Loaded the data', data: @data }
            end

            def create
                data = BiometricDatum.new(data_params)
                if data.save
                    render json: { status: 'success', data: data }
                else
                    render json: { status: 'failed', data: data.errors }
                end
            end

            def destroy
                @data.destroy
                render json: { status: 'success', message: 'Deleted the data', data: @data }
            end

            def update
                if @data.update(data_params)
                    render json: { status: 'success', message: 'Updated the data', data: @data }
                else
                    render json: { status: 'failed', message: 'Not updated', data: @data.errors }
                end
            end

            private
            def set_data
                @data = BiometricDatum.find(params[:id])
            end

            def data_params
                params.permit(:id, :heartrate, :step_count, :height, :weight, :distance, :energy, :water, :sleep)
            end
        end
    end
  end