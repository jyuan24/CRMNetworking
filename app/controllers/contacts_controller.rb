class ContactsController < ApplicationController
    before_action :authenticate_user!, only: [:show, :create, :destroy, :update]

    def index
        @contacts = Contact.all
        render json: @contacts
    end

    def edit
        contact = current_user.contacts.find params[:id]
        render json: contact, status: 201
    end

    def show
        contact = Contact.find params[:id]
        render json: contact
    end

    def create
        contact = current_user.contacts.create contact_params
        render json: contact, status:201
    end

    def update
        @contact = current_user.contacts.find params[:id]
        @contact.update_attributes(contact_params)
        render json: @contact, status: 201
    end

    def destroy
        @contact = current_user.contacts.find params[:id]
        if @contact.destroy
            render json: @contact
        else
            render json: {error: 'could not delete'}, status: 400
        end
    end

    private
    def contact_params
        params.require(:contact).permit(:first_name, :last_name)
    end
end
