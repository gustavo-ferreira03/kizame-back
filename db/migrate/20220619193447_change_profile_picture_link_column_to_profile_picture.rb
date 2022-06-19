class ChangeProfilePictureLinkColumnToProfilePicture < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :profile_picture_link, :profile_picture
  end
end
