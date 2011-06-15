require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :name => "Test User",
      :account => "testuser3",
      :email => "test@example.com",
      :employee_id => "000000"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require an account" do
    no_account_user = User.new(@attr.merge(:account => ""))
    no_account_user.should_not be_valid
  end

  it "should require an email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should accept valid emails" do
    emails = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    emails.each do |address|
    valid_email_user = User.new(@attr.merge(:email => address))
    valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
    valid_email_user = User.new(@attr.merge(:email => address))
    valid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate emails" do
    # Put a user with a given email address into the database
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr.merge(:account => "testuser6"))
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject duplicate accounts" do
    # Put a user with a given account address into the database
    User.create!(@attr)
    user_with_duplicate_account = User.new(@attr.merge(:email => "test2@example.com"))
    user_with_duplicate_account.should_not be_valid
  end

  describe "admin attribute" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end
end
