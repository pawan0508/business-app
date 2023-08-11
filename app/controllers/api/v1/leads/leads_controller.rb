module Api
  module V1
    module Leads
      class LeadsController < ApplicationController
        before_action :authenticate_user!, only: %i[create]
        skip_before_action :authenticate_user!, only: %i[index]
        before_action :set_lead, only: %i[ show update destroy ]

        # GET /leads
        def index
          @leads = Lead.all

          render json: @leads
        end

        # GET /leads/1
        def show
          render json: @lead
        end

        # POST /leads
        def create
          @lead = current_user.leads.build(lead_params)

          if @lead.save
            render json: @lead, message: 'Lead created Successfully', lead: @lead
          else
            render json: @lead.errors, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /leads/1
        def update
          if @lead.update(lead_params)
            render json: @lead
          else
            render json: @lead.errors, status: :unprocessable_entity
          end
        end

        # DELETE /leads/1
        def destroy
          @lead.destroy
        end

        private
          # Use callbacks to share common setup or constraints between actions.
          def set_lead
            @lead = Lead.find_by(id: params[:id])
          end

          # Only allow a list of trusted parameters through.
          def lead_params
            params.permit(:title, :description, :budget, :income, :status)
          end
      end
    end
  end
end
