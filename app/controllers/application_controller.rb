class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def friendlyName (instance)
    case instance.class.to_s
      when "Entity"
        "#{instance.name} (#{instance.city}, #{instance.polsub})"
      when "Account"
        instance.account_pathname
      when "Item"
        "#{instance.brand} #{instance.gendesc} #{instance.size} #{instance.unit.unit if instance.unit} (#{instance.barcode})"
      else
        "???"
    end
  end

  def genericResponse (instances)
    respond_to do |format|
     format.html { instances }
     format.json {
      descriptions = instances.map { |instance|
       {label: friendlyName(instance), value: "#{instance.id}"}
      }
      if params[:term]
       term = params[:term].downcase
       descriptions.select! { |desc|
        desc[:label].downcase.index(term)
       }
      end
      render json: descriptions.to_json
     }
    end
  end

end
