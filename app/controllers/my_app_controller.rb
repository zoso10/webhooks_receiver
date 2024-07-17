# frozen_string_literal: true

class MyAppController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :validate_token!

  def create
    WebhookRequest
      .create!(source:, body:, headers:)

    head :ok
  end

  private

  def source
    "my_webhooks_app"
  end

  def body
    params.to_json
  end

  def headers
    {
      content_type: request.content_type,
      user_agent: request.user_agent,
    }
  end

  def validate_token!
    request_token = request.headers["WEBHOOK-TOKEN"].to_s
    configured_token = ENV.fetch("WEBHOOK_TOKEN")

    if !ActiveSupport::SecurityUtils.secure_compare(request_token, configured_token)
      head :unauthorized
    end
  end
end
