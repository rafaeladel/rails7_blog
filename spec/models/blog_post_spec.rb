require 'rails_helper'

describe BlogPost, type: :model do
  before(:all) do 
    @posts = create_test_posts
  end

  it "scopes correctly" do 
    expect(BlogPost.draft.length).to eq 6
    expect(BlogPost.published.length).to eq 5
    expect(BlogPost.scheduled.length).to eq 14
  end

  it "follows the default scope" do
    posts = BlogPost.all
    expect(posts.first.state).to eq(:scheduled)
    #expect(posts[7].state).to eq(:published)
    expect(posts.last.state).to eq(:draft)
  end
  
  it "is draft by default" do
    post = create(:blog_post) 
    expect(post.draft?).to be_truthy
    expect(post.published?).to be_falsy
    expect(post.scheduled?).to be_falsy
    expect(post.state).to eq :draft
  end
  
  it "scheduled if published_at is in future" do
    post = create(:blog_post, published_at: 1.day.from_now)
    expect(post.draft?).to be_falsy
    expect(post.published?).to be_falsy
    expect(post.scheduled?).to be_truthy
    expect(post.state).to eq :scheduled
  end

  it "published if published_at is in past" do
    post = create(:blog_post, published_at: 1.day.ago)
    expect(post.draft?).to be_falsy
    expect(post.published?).to be_truthy
    expect(post.scheduled?).to be_falsy
    expect(post.state).to eq :published
  end


  private
  def create_test_posts
    puts "before"
    create_list(:blog_post, 25) do |post, i|
      case i
      when 0..5
        post.published_at = nil
      when 6..10
        post.published_at = 1.day.ago
      when 11..24
        post.published_at = 1.day.from_now
      end
      post.save!
    end
  end
end
