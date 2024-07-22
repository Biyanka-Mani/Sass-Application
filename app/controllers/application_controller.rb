class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  # set_current_tenant_by_subdomain_or_domain(:account,:subdomain,:domain)
  # before_action do 
  #   binding.irb
  # end
  # set_current_tenant_through_filter
  # before_action :set_tenant

  # private

  # def set_tenant
  #   tenant = Account.find_by(subdomain: request.subdomain) # or request.domain for domain
  #   set_current_tenant(tenant)
  # end
  
set_current_tenant_through_filter
before_action :set_tenant

private
def set_tenant
  if current_user
    ActsAsTenant.current_tenant = current_user.tenant
   
  end
end

end
