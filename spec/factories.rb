FactoryGirl.define do
	factory :user do
		sequence(:name)  { |n| "Test User_#{n}" }
		sequence(:email) { |n| "test_#{n}@example.com" }
		password "foobar"
		password_confirmation "foobar"

		factory :admin do
			admin true
		end
	end
end