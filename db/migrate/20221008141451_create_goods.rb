class CreateGoods < ActiveRecord::Migration[7.0]
  def change
    create_table :goods do |t|

      t.timestamps
    end
  end
end
