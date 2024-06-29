# frozen_string_literal: true

class RubygemsController < ApplicationController
  def create
    WebhookRequest
      .create!(source:, body:, headers:, metadata: { name:, version: })

    head :ok
  end

  private

  def source
    "rubygems"
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
end
