class PostPolicy < ApplicationPolicy
    def update?
        admin_types.include?(user.type) or record.user_id == user.id
    end 
end