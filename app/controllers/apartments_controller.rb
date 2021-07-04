class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :show_errors

    def index
        render json: Apartment.all
    end

    def show
        apartment = find_apartment
        render json: apartment
    end

    def create
        new_apartment = Apartment.create!(apartment_params)
        render json: new_apartment
    end
    
    def update
        apartment_to_update = find_apartment
        apartment_to_update.update!(apartment_params)
        render json: apartment_to_update
    end

    def destroy
        apartment = find_apartment
        apartment.destroy
        redner json: {message: "Apartment deleted"}
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def find_apartment
        Apartment.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "Apartment not found" }, status: :not_found
    end

    def show_errors(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
