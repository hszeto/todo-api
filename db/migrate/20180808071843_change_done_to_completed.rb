class ChangeDoneToCompleted < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :done, :completed
  end
end
