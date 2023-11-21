# frozen_string_literal: true

class CreateBlackListTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :black_list_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
