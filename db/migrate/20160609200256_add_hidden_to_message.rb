class AddHiddenToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :hidden, :boolean, default: false
  end
end
