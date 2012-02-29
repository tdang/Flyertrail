require 'spec_helper'

describe Promotion do

  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "lorem ipsum" }
  end
  
  it "should create a new instance with valid attributes" do
    @user.promotions.create!(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @promotion = @user.promotions.create(@attr)
    end
    
    it "should have a user attribute" do
      @promotion.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @promotion.user_id.should == @user.id
      @promotion.user.should == @user
    end
  end
  
  describe "validations" do

    it "should have a user id" do
      Promotion.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.promotions.build(:content => "    ").should_not be_valid
    end
    
    it "should reject long content" do
      @user.promotions.build(:content => "a" * 141).should_not be_valid
    end
  end

  describe "from_users_followed_by" do
    
    before(:each) do
      @other_user = Factory(:user, :email => Factory.next(:email))
      @third_user = Factory(:user, :email => Factory.next(:email))
      
      @user_post  = @user.promotions.create!(:content => "foo")
      @other_post = @other_user.promotions.create!(:content => "bar")
      @third_post = @third_user.promotions.create!(:content => "baz")
      
      @user.follow!(@other_user)
    end
    
    it "should have a from_users_followed_by method" do
      Promotion.should respond_to(:from_users_followed_by)
    end
    
    it "should include the followed user's promotions" do
      Promotion.from_users_followed_by(@user).should include(@other_post)
    end
    
    it "should include the user's own promotions" do
      Promotion.from_users_followed_by(@user).should include(@user_post)
    end
    
    it "should not include an unfollowed user's promotions" do
      Promotion.from_users_followed_by(@user).should_not include(@third_post)
    end
  end
end
