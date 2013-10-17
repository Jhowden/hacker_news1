class CreatePostvotes < ActiveRecord::Migration
  def change
    create_table :postvotes do |t|

      t.integer :post_id
      t.integer :value, default: 0
      t.integer :user_id

      t.timestamps
    end
  end
end
