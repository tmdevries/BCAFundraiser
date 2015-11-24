require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "outbid" do
    # Send the email, then test that it got queued
    email = UserMailer.create_invite(User.find(1), Item.find(1)).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal ['andwerewalking@tmdevries.com'], email.from
    assert_equal ['tmdevries@me.com'], email.to
    assert_equal "You've been outbid!", email.subject
  end
end
