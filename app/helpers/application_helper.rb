module ApplicationHelper

  #  only shows the first 4 characters of an email + a random number of '*'
  def hideEmail(email)
    email[0,4] + '*' + ('*' * rand(8));
  end
end
