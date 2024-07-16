# frozen_string_literal: true

class WebhookRequest < ApplicationRecord
  enum source: {
    rubygems: "rubygems",
    my_webhooks_app: "my_webhooks_app",
  }.freeze
end
