class UserMailer < ApplicationMailer
    default from: 'votre-adresse-email@example.com'
  
    def welcome_email(user)
      @user = user
      @url  = 'http://votre-site.com/login'
      mail(to: @user.email, subject: 'Bienvenue sur notre site !')
    end
  end
  