class CreateCommentvotes < ActiveRecord::Migration
  def change
    create_table :commentvotes do |t|
      t.integer :comment_id 
      t.integer :counter, default: 0
      t.integer :user_id

      t.timestamps
    end
  end
end
