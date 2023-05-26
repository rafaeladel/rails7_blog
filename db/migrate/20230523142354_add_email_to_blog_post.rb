class AddEmailToBlogPost < ActiveRecord::Migration[7.0]
  def up
    add_column :blog_posts, :email, :string
  end

  def down
    remove_column :blog_posts, :email
  end
end
  
