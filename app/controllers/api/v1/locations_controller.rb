module Api
  module V1
    class LocationsController < ApplicationController
      before_action :set_location, only: [ :show, :update, :destroy ]

      # GET /api/v1/locations
      def index
        locations = Location.all
        render json: { locations: locations.map { |loc| location_response(loc) }, message: "Locations fetched successfully" }, status: :ok
      end

      # GET /api/v1/locations/:id
      def show
        render json: { location: location_response(@location), message: "Location fetched successfully" }, status: :ok
      end

      # POST /api/v1/locations
      def create
        if current_user.role == "admin"
          location = Location.new(location_params)
          if location.save
            render json: { location: location_response(location), message: "Location created successfully" }, status: :created
          else
            render json: location.errors, status: :unprocessable_entity
          end
        else
          render json: { error: "You are not authorized to create a location" }, status: :forbidden
        end
      end

      # PATCH/PUT /api/v1/locations/:id
      def update
        if @location.update(location_params)
          render json: { location: location_response(@location), message: "Location updated successfully" }, status: :ok
        else
          render json: @location.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/locations/:id
      def destroy
        @location.destroy
        render json: { message: "Location deleted successfully" }, status: :ok
      end

      private

      def set_location
        @location = Location.find_by(id: params[:id])
        render json: { error: "Location not found" }, status: :not_found unless @location
      end

      def location_params
        params.require(:location).permit(
          :location_name, :category, :sub_category, :general_amenities, :interior_ameneties,
          :exterior_ameneties, :utility_ameneties, :max_people_allowed, :film_specific_ameneties,
          :map_link, :accessibilities, :permission, :staying_facility, :property_type, :address,
          :country, :state, :city, :pincode, :description, :terms_and_conditions, :remarks, :user_id,
          :document, images: []
        )
      end

      # Custom JSON Response Method
      def location_response(location)
        {
          id: location.id,
          location_name: location.location_name,
          category: location.category,
          sub_category: location.sub_category,
          general_amenities: location.general_amenities,
          interior_ameneties: location.interior_ameneties,
          exterior_ameneties: location.exterior_ameneties,
          utility_ameneties: location.utility_ameneties,
          max_people_allowed: location.max_people_allowed,
          film_specific_ameneties: location.film_specific_ameneties,
          map_link: location.map_link,
          accessibilities: location.accessibilities,
          permission: location.permission,
          staying_facility: location.staying_facility,
          property_type: location.property_type,
          address: location.address,
          country: location.country,
          state: location.state,
          city: location.city,
          pincode: location.pincode,
          description: location.description,
          terms_and_conditions: location.terms_and_conditions,
          remarks: location.remarks,
          user_id: location.user_id,
          images: location.images.attached? ? location.images.map { |image| image.url } : nil,
          document: location.document.attached? ? location.document.url : nil,
          created_at: location.created_at,
          updated_at: location.updated_at
        }
      end
    end
  end
end
