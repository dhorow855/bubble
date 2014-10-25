require 'spec_helper'

describe "Static pages" do
  
  subject { page }
  
  shared_examples_for "all static pages" do
      it { should have_selector('h1', text: heading) }
      it { should have_title(full_title(page_title)) }
    end
  
  describe "Home page" do
    before { visit root_path }
    
    let(:heading)     { 'Bubble' }
    let(:page_title)  { '' }
    
    it { should have_selector('h1', text: 'Bubble') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
    
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end
      
      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
      
      describe "micropost count" do
        before { click_link "delete", match: :first }
        it "should be singular when count equals 1" do
          expect(page).to have_selector("span", text: "1 bubble")
        end
      end
    end
  end
  
  describe "micropost pagination" do
    let(:user)   { FactoryGirl.create(:user) }
    before do
      31.times { FactoryGirl.create(:micropost, user: user) }
      sign_in user
      visit root_path
    end
    after { user.microposts.destroy_all}
    
    it { should have_selector("div.pagination") }
  end

  describe "Help page" do
    before { visit help_path }

    let(:heading) { 'Help' }
    let(:page_title)  { 'Help' }
    
    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }

    let(:heading) { 'About' }
    let(:page_title)  { 'About' }
    
    it_should_behave_like "all static pages"
  end
  
  describe "Contact page" do
    before { visit contact_path }

    let(:heading) { 'Contact' }
    let(:page_title)  { 'Contact' }
    
    it_should_behave_like "all static pages"
  end
  
  it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      page.should have_selector 'title', text: full_title('About')
      click_link "Help"
      page.should have_selector 'title', text: full_title('Help')
      click_link "Contact"
      page.should have_selector 'title', text: full_title('Contact')
      click_link "Sign up now!"
      page.should have_selector 'title', text: full_title('Sign up')
      click_link "bubble"
      page.should have_selector 'title', text: full_title('Bubble')
  end
end