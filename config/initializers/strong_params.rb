
# Add strong parameters requirement to all models
ActiveRecord::Base.send(:include, ActiveModel::ForbiddenAttributesProtection)
