class PostPolicy < ApplicationPolicy
    def update?
        return true if post_approved? and user.admin?
        return true if user_or_admin and !post_approved?

        
    end 

    private

        def user_or_admin
            record.user == user || user.admin?
        end

        def post_approved?
            record.status == 'approved'
        end
end