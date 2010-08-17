# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.email "a@b.com"
  f.password "mypassword"
  f.password_confirmation 'mypassword'
end
