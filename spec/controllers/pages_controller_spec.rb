require 'spec_helper'

describe PagesController do
  describe "login" do
    describe "for valid CAS users but don't exist in the system" do
      before(:each) do
        RubyCAS::Filter.fake('baduser')
        get :home
      end
      it "should return a successful CAS login"
      it "should redirect to homepage" do
        response.should render_template("pages/home")
      end
      pending "should display an error" do
        flash.should_not be_blank
        flash[:error].should_not be_blank
        flash[:error].should =~ /not found/i
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
        response.should render_template("pages/home")
      end
      it "should not display an error" do
        flash.now[:error].should_not =~ /not found/i
      end
    end
  end
end

