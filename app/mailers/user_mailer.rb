class UserMailer < ApplicationMailer
  default from: "andwerewalking@tmdevries.com"

  def outbid_email(user, item)
	@user = user
	@item = item
	@url = "andwerewalking.tmdevries.com/login"
	email_with_name = %("#{@user.first_name}" <#{@user.email}>)
	mail(to: email_with_name, subject: "You've been outbid!")
  end

  def outbid_text(user, item)
  	@user = user
  	@item = item
  	mail(to: 'andwerewalking@tmdevries.com', subject:"TASKER/@user.first_name/@user.phone_number/@item.item_title")
  end

  def thankyou_email(user, item, bid, message)
    @user = user
    @item = item
    @bid = bid
    @message = message
    email_with_name = %("#{@user.first_name}" <#{@user.email}>)
    if item.nil?
      subject = "Auction Results"
    else
      subject = "You won!"
    end
    mail(to: email_with_name, subject: subject)
  end

end
