# frozen_string_literal: true

class MyAppController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :validate_token!

  def create
    WebhookRequest
      .create!(source:, body:, headers:, metadata: { name:, version: })

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

  def name
    params.require(:name)
  end

  def version
    params.require(:version)
  end

  def validate_token!
    request_token = request.headers["WEBHOOK_TOKEN"].to_s
    configured_token = ENV.fetch("WEBHOOK_TOKEN")
    Rails.logger.info("headers: #{request.headers['WEBHOOK_TOKEN']}")
    Rails.logger.info("headers: #{request.headers['WEBHOOK-TOKEN']}")
    Rails.logger.info("headers: #{request.headers['webhook_token']}")
    Rails.logger.info("headers: #{request.headers['webhook-token']}")

    if !ActiveSupport::SecurityUtils.secure_compare(request_token, configured_token)
      head :unauthorized
    end
  end
end
