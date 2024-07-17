# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @rubygems_count = WebhookRequest.where(source: "rubygems").count
    @my_webhooks_app_count = WebhookRequest.where(source: "my_webhooks_app").count
  end
end
