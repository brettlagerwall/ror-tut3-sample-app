require 'spec_helper'

describe "Microposts" do

  before(:each) do
    @user = Factory(:user)
    visit signin_path
    fill_in :email, :with => @user.email
    fill_in :password, :with => @user.password
    click_button
  end

  describe "creation" do

    describe "failure" do

      it "should not make a new micropost" do
        lambda do
          visit root_path
          fill_in :micropost_content, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Micropost, :count)
      end
    end

    describe "success" do

      it "should make a new micropost" do
        content = "Lorem ipsum dolor sit amet"
        lambda do
          visit root_path
          fill_in :micropost_content, :with => content
          click_button
          response.should have_selector("span.content", :content => content)
        end.should change(Micropost, :count).by(1)
      end
    end
  end

  describe "pagination" do

    it "should not have any pagination links" do
      visit root_path
      response.should_not have_selector("div", :class => "pagination")
    end

    it "should not have any pagination links (still shows a micropost)" do
      @user.microposts.create!(:content => "I rock")
      visit root_path
      response.should_not have_selector("a", :href => "/pages/home?page=1")
    end

    it "should paginate correctly" do
      50.times do
        @user.microposts.create!(:content => "I rock")
      end
      visit root_path
      response.should have_selector("a", :href => "/pages/home?page=1")
      response.should have_selector("a", :href => "/pages/home?page=2")
    end
  end
end
