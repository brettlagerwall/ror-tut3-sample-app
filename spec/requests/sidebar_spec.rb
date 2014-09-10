require 'spec_helper'

describe "sidebar" do

  before(:each) do
    @user = Factory(:user)
    micropost = Factory(:micropost, :user => @user)
    visit signin_path
    fill_in :email, :with => @user.email
    fill_in :password, :with => @user.password
    click_button
  end

  it "should show the correct number of microposts" do
    visit root_path
    response.should have_selector('span', :content => "1 micropost")
  end

  it "should have the correct pluralization" do
    @user.microposts.create!(:content => "I rock")
    visit root_path
    response.should have_selector('span', :content => "2 microposts")
  end
end
