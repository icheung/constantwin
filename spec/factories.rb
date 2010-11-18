require 'factory_girl'
#:login, :email, :name, :password, :password_confirmation
Factory.define :user do |f|
  f.login "foo"
  f.email "foo@example.com"
  f.name "fooname"
  f.password "foopassword"
  f.password_confirmation {|u| u.password}
end