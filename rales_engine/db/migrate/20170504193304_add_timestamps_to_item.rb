class AddTimestampsToItem < ActiveRecord::Migration[5.0]
  def change
    add_timestamps :items, default: DateTime.now 
  end
end
