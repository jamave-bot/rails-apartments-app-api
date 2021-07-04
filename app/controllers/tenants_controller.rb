class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :show_errors


    def index
        render json: Tenant.all
    end

    def show
        tenant = find_tenant
        render json: tenant
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant
    end

    def update
        tenant = find_tenant
        tenant.update!(tenant_params)
        render json: tenant
    end


    def destroy
        tenant = find_tenant
        tenant.destroy
        render json: {message: "Tenant evicted"}
    end

    private 

    def tenant_params
        params.permit(:name, :age)
    end

    def find_tenant
        Tenant.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "Apartment not found" }, status: :not_found
    end

    def show_errors(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
