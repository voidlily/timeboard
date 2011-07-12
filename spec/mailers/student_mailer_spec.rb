require "spec_helper"

describe StudentMailer do
  pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @user = Factory(:student)
    @email = StudentMailer.reminder_email(@user)
  end

  it "should be delivered to the user's email" do
    @email.should deliver_to(@user.email)
  end

  it "should contain the user's name in the mail body" do
    @email.should have_body_text(/#{@user.name}/)
  end

  it "should have the correct body text" do
    @email.should have_body_text(/reminder/)
    @email.should have_body_text(/timesheet/)
    @email.should have_body_text(/due/)
  end

  it "should have the correct subject" do
    @email.should have_body_text(/timesheet/)
    @email.should have_body_text(/due/)
  end

end
