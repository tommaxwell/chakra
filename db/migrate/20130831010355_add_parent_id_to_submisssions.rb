class AddParentIdToSubmisssions < ActiveRecord::Migration
  def change
  	add_column :submissions, :parent_id, :integer
  end
end
