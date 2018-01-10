FactoryBot.define do
    factory :post do
      date Date.today
      rationale  "Some rationale"
      user
    end

    factory :second_post, class: Post do
      date Date.yesterday
      rationale  "Some content"
      user
    end

    factory :post_from_other_user, class: Post do
      date Date.yesterday
      rationale "Some additional rationale"
      non_authorized_user
    end
end