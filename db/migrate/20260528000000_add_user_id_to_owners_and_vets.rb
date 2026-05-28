class AddUserIdToOwnersAndVets < ActiveRecord::Migration[8.0]
  def change
    add_reference :owners, :user, foreign_key: true, null: true
    add_reference :vets, :user, foreign_key: true, null: true
  end
end