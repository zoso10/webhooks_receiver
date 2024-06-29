# frozen_string_literal: true

class WebhookRequest < ApplicationRecord
  enum source: {
    rubygems: "rubygems",
  }.freeze
end
