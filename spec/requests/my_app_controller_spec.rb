# frozen_string_literal: true

RSpec.describe MyAppController do
  describe "#create" do
    let(:token) { "secret-token" }
    let(:headers) do
      {
        "WEBHOOK-TOKEN": token,
      }
    end
    let(:params) do
      {
        name: "rails",
        version: "7.2.0",
        action: "released",
        timestamp: Time.current,
      }
    end

    it "responds with 200 and no body" do
      post(my_app_path, params:, headers:)

      expect(response).to have_http_status(:ok)
      expect(response.body).to be_empty
    end

    it "stores the response" do
      expect do
        post(my_app_path, params:, headers:)
      end.to change(WebhookRequest, :count).by(1)

      req = WebhookRequest.last
      expect(req.source).to eq("my_webhooks_app")
      expect(req.headers.keys).to contain_exactly("content_type", "user_agent")
      expect(req.body).to start_with("{\"name\"")
    end

    it "responds 401 with the incorrect header token" do
      headers = {}

      post(my_app_path, params:, headers:)

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
