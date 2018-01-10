FactoryBot.define do
    factory :post do
      date Date.today
      rationale  "Some rationale"
      user
      overtime_request 3.5
    end

    factory :second_post, class: Post do
      date Date.yesterday
      rationale  "Some content"
      user
      overtime_request 0.5
    end

    factory :post_from_other_user, class: Post do
      date Date.yesterday
      rationale "Some additional rationale"
      non_authorized_user
      overtime_request 2.5
    end
end