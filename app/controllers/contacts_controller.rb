# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:edit, :update, :destroy]

  def index
    if (params[:group_id] && !params[:group_id].empty?)
      @contacts = current_user.contacts.where(group_id: params[:group_id]).
        order(created_at: :desc).page(params[:page])
    else
      @contacts = current_user.contacts.page(params[:page]).
        order(created_at: :desc)
    end
  end

  def autocomplete
    @contacts = Contact.search(params[:term]).
      order(created_at: :desc).
        page(params[:page])
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = current_user.contacts.build(contact_params)
    if @contact.save
      flash[:success] = "Contact was successfuly created."
      redirect_to contacts_path
    else
      flash[:error] = "Contact failed to be created."
      render 'new'
    end
  end

  def edit
    authorize @contact
  end

  def update
    authorize @contact
    if @contact.update(contact_params)
      flash[:success] = "Contact was successfully updated."
      redirect_to contacts_path
    else
      flash[:error] = "Contact failed to be updated."
      render :edit
    end
  end

  def destroy
    authorize @contact
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
    params.require(:contact)
      .permit(:name, :company, :email, :phone, :address, :group_id, :avatar)
  end
end 