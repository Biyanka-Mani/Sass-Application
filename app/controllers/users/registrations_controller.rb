# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    ActiveRecord::Base.transaction do
 
      super do |resource|
        debugger
        if resource.persisted?
          begin
            Rails.logger.info "Resource persisted: #{resource.inspect}"
              account = Account.new(account_params)
              # account.user = resource
    
              # Ensure account is valid and save
              if account.save
                # Update the user with the associated account
                resource.update!(account: account)
                ActsAsTenant.current_tenant=account
                debugger
                flash[:notice] = "Signed up successfully."
              else
                raise ActiveRecord::RecordInvalid.new(account)
              end
            
          rescue ActiveRecord::RecordInvalid => e
            flash[:alert] = "Account creation failed: #{e.message}"
            resource.destroy # Rollback the user creation if account creation fails
            redirect_to new_user_registration_path and return
          end
        else
          raise ActiveRecord::RecordInvalid.new(resource) # Raise exception to trigger rollback
        end
      end
    end
  end
  
  private
  
  def account_params
    params.require(:account).permit(:name, :subdomain, :domain)
  end
  
  


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end



  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, account: [:name, :subdomain, :domain]])
  # end

  # def sign_up_params
  #   params.require(:user).permit(:email, :password, :password_confirmation, account: [:name, :subdomain, :domain])
  # end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

end
