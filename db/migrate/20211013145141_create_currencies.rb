class CreateCurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :currencies do |t|
      t.string :symbol
      t.decimal :rate

      t.timestamps
    end
    add_index :currencies, :symbol, unique: true
  end
end
