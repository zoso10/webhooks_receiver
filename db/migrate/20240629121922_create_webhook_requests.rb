# frozen_string_literal: true

class CreateWebhookRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :webhook_requests, id: :uuid do |t|
      t.string :source, null: false
      t.jsonb :headers
      t.string :body
      t.jsonb :metadata, default: {}
      t.timestamps null: false
    end
  end
end
