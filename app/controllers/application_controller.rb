class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    case resource
      when Customer
        root_path
      when Admin
        admin_top_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :customer
        new_customer_session_path
    elsif resource == :admin
        new_admin_session_path
    else
    end
  end

end
