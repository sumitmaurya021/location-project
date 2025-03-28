module Api
  module V1
    class EnquiriesController < ApplicationController
      before_action :set_enquiry, only: [ :show, :update, :destroy ]
      skip_before_action :doorkeeper_authorize!, only: [ :create ]

      # GET /api/v1/enquiries
      def index
        enquiries = Enquiry.all.order(created_at: :desc)
        render json: { enquiries: enquiries, message: "Enquiries fetched successfully" }, status: :ok
      end

      # GET /api/v1/enquiries/:id
      def show
        render json: { enquiry: enquiry_response(@enquiry), message: "Enquiry fetched successfully" }, status: :ok
      end

      # POST /api/v1/enquiries
      def create
        enquiry = Enquiry.new(enquiry_params)
        if enquiry.save
          render json: { enquiry: enquiry_response(enquiry), message: "Enquiry created successfully" }, status: :created
        else
          render json: { errors: enquiry.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/enquiries/:id
      def update
        if @enquiry.update(enquiry_params)
          render json: { enquiry: enquiry_response(@enquiry), message: "Enquiry updated successfully" }, status: :ok
        else
          render json: { errors: @enquiry.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/enquiries/:id
      def destroy
        @enquiry.destroy
        render json: { message: "Enquiry deleted successfully" }, status: :ok
      end

      private

      def set_enquiry
        @enquiry = Enquiry.find_by(id: params[:id])
        render json: { error: "Enquiry not found" }, status: :not_found unless @enquiry
      end

      def enquiry_params
        params.require(:enquiry).permit(:your_name, :your_email, :phone_no, :location_enquiry, :location_id)
      end

      def enquiry_response(enquiry)
        {
          id: enquiry.id,
          your_name: enquiry.your_name,
          your_email: enquiry.your_email,
          phone_no: enquiry.phone_no,
          location_enquiry: enquiry.location_enquiry,
          location_id: enquiry.location_id,
          created_at: enquiry.created_at,
          updated_at: enquiry.updated_at
        }
      end
    end
  end
end
