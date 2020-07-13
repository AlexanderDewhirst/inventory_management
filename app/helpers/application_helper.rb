module ApplicationHelper

    def flash_class(level)
        case level.to_sym
            when :notice then "alert alert-success"
            when :success then "alert alert-success"
            when :error then "alert alert-error"
            when :alert then "alert alert-error"
        end
    end

    def request_filtered_params
        request.filtered_parameters
    end

    def active_nav(params, header)
        controller, action = params.values_at(:controller, :action)

        active_hash = {
            home: {
                controller: [:pages],
                action: [:index]
            },
            login: {
                controller: [],
                action: []
            },
            signup: {
                controller: [],
                action: []
            },
            inventory: {
                controller: [:items],
                action: [:index, :new, :edit, :show]
            },
            categories: {
                controller: [:categories],
                action: [:index, :new, :edit, :show]
            },
            features: {
                controller: [:features],
                action: [:index, :new, :edit, :show]
            }
        }

        if active_hash[header][:controller].include?(controller.to_sym) && active_hash[header][:action].include?(action.to_sym)
            'active'
        else
            ''
        end
    end

end
