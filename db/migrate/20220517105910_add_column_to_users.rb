class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :navbar_color, :string, default: "#866363"
  end
end
