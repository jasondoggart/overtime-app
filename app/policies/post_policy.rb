class PostPolicy < ApplicationPolicy
    def update?
        user.admin? or record.user_id == user.id
    end 
end