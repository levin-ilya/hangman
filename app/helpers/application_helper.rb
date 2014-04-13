module ApplicationHelper

  def hideEmail(email)
    email[0,4] + '*' + ('*' * rand(8));
  end
end
