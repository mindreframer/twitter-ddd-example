# https://github.com/piscolomo/fabricas
Fabricas.define do
  factory :user, class_name: 'Repo::User' do
    email 'email@gmail.com'
    email_confirmed true
  end

  factory :post, class_name: 'Repo::Post' do
    content 'email@gmail.com'
    email_confirmed true
  end
end
