#frozen_string_literal: true

FactoryBot.define do
  factory :blog_post, class: "BlogPost" do
    sequence(:title) { |n| "rafael#{n}" }
    sequence(:body) { |n| "rafael body#{n}" }
    sequence(:email) { |n| "email #{n}" }
  end
end
