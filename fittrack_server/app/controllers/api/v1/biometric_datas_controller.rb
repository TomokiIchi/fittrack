#Todo APIのステータスの命名規則を揃えたい
module Api
    module V1
        class BiometricDatasController < ApplicationController
            before_action :set_data, only: [:show, :update, :destroy]
            def index
                datas = BiometricDatum.order(created_at: :desc)
                render json: { status: 'SUCCESS', message: 'Loaded datas', data: datas }
            end

            def show
                render json: { status: 'SUCCESS', message: 'Loaded the data', data: @data }
            end

            def create
                data = BiometricDatum.new(data_params)
                if data.save
                    render json: { status: 'SUCCESS', data: data }
                else
                    render json: { status: 'Failed', data: data.errors }
                end
            end

            def destroy
                @data.destroy
                render json: { status: 'SUCCESS', message: 'Deleted the data', data: @data }
            end

            def update
                if @data.update(data_params)
                    render json: { status: 'SUCCESS', message: 'Updated the data', data: @data }
                else
                    render json: { status: 'Failed', message: 'Not updated', data: @data.errors }
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