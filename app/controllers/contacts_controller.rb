# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    if (params[:group_id] && !params[:group_id].empty?)
      @contacts = Contact.where(group_id: params[:group_id]).page(params[:page])
    else
      @contacts = Contact.all.page(params[:page])
    end
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    
    respond_to do |format|
      if @contact.save
        format.html { redirect_to contacts_path, success: 'Contact was successfully created.'  }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to contacts_path, success: 'Contact was successfully updated.'  }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_path, success: 'Contact as successfully destroyed.' }
      format.json {  head :no_content }
    end
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :company, :email, :phone, :address, :group_id)
  end
end 