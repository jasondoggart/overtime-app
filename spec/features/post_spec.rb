require 'rails_helper'

describe 'navigate' do
  before do
    @user = FactoryBot.create(:user)
    login_as(@user, :scope => :user)
  end

  describe 'index' do
    before do
      visit posts_path
    end
    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of Posts' do
      post1 = FactoryBot.create(:post)
      post2 = FactoryBot.create(:second_post)
      visit posts_path
      expect(page).to have_content(/Rationale|content/)
    end

    it 'has a scope so that users can only see their own posts' do
      post1 = Post.create(date: Date.today, rationale: "asdf", user: @user)
      post2 = Post.create(date: Date.today, rationale: "asdf", user: @user)
      other_user = User.create(first_name: "Non", last_name: "Authorized", email: "nonauth@nope.com", password: "asdfasdf", password_confirmation: "asdfasdf")
      post_from_other_user = Post.create(date: Date.today, rationale: "This should not be seen", user: other_user)

      visit posts_path
      
      expect(page).to_not have_content(/This should not be seen/)
    end
  end

  describe 'new' do
    it 'has a link from the homepage' do
      visit root_path

      click_link("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end
  end

  describe 'creation' do
    before do
      visit new_post_path
    end
    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Some Rationale"
      click_on "Save"
      expect(page).to have_content("Some Rationale")
    end

    it 'will have a user associated with it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "User Association"
      click_on "Save"

      expect(@user.posts.last.rationale).to eq("User Association")
    end
  end

  describe 'edit' do
    before do
      @post = Post.create(date: Date.today, rationale: "asdf", user: @user)
    end

    it 'can be edited' do
      visit edit_post_path(@post)

      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Edited Content"
      click_on "Save"

      expect(page).to have_content("Edited Content")
    end

    it 'cannot be edited by an unauthorized user' do
      logout(:user)
      non_authorized_user = FactoryBot.create(:non_authorized_user)
      login_as(non_authorized_user, :scope => :user)

      visit edit_post_path(@post)
      expect(current_path).to eq(root_path)
    end
  end

  describe 'deletion' do
    it 'can be deleted' do
      @post = FactoryBot.create(:post)
      @post.update(user: @user)
      visit posts_path

      click_link("delete_post_#{@post.id}")
      expect(page.status_code).to eq(200)
    end
  end
end
