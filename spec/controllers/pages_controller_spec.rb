require 'spec_helper'

describe PagesController do
  describe "login" do
    describe "for valid CAS users but don't exist in the system" do
      before(:each) do
        get :home
        RubyCAS::Filter.fake('baduser')
      end
      it "should return a successful CAS login"
      it "should redirect to homepage" do
        response.should redirect_to(root_path)
      end
      it "should display an error" do
        flash.now[:error].should =~ /access/i
      end
    end
    describe "for valid CAS users that exist in the system" do
      before(:each) do
        @user = Factory(:student)
        @user.save
        get :home
        RubyCAS::Filter.fake('teststudent3')
      end
      it "should return a successful CAS login"
      it "should redirect to homepage" do
        response.should redirect_to(root_path)
      end
      it "should not display an error" do
        flash.now[:error].should_not =~ /access/i
      end
    end
  end
end

