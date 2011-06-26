require 'spec_helper'

describe TimesheetsController do
  describe "GET 'index'"
  describe "GET 'show'"
  describe "GET 'new'"
  describe "POST 'create'"
  describe "GET 'edit'"
  describe "PUT 'update'"
  #These cases should be converted to the actual proper urls
  describe "editing"
  describe "signing" do
    it "should be signable by student owner"
    it "should not be signable by another student"
  end
  describe "approving" do
    it "should be approved by matching professor"
    it "should not be approveable by another professor"
    it "should not be approveable by students"
  end
  describe "processing" do
    it "should be processable by any finance user"
    it "should not be processable by students"
    it "should not be processable by professors"
  end
end
