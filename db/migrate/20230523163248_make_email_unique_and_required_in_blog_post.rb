class MakeEmailUniqueAndRequiredInBlogPost < ActiveRecord::Migration[7.0]
  def up
    BlogPost.update_all('email = id')
    change_column_null :blog_posts, :email, false
    add_index :blog_posts, :email, unique: true
  end

  def down
    remove_index :blog_posts, :email
    change_column_null :blog_posts, :email, true
    BlogPost.update_all(email: nil)
  end
end
