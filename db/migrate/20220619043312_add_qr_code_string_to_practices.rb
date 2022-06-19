class AddQrCodeStringToPractices < ActiveRecord::Migration[7.0]
  def change
    add_column :practices, :qr_code_string, :string
  end
end
