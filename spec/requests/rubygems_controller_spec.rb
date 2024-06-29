# frozen_string_literal: true

RSpec.describe RubygemsController do
  describe "#index" do
    let(:headers) do
      {
        Host: "52.38.177.176",
        HTTP_VERSION:	"HTTP/1.1",
        HTTP_HOST:	"webhook-test.com",
        CONTENT_LENGTH: 1560,
        USER_AGENT: "Faraday v2.9.2",
        CONTENT_TYPE: "application/json",
        ACCEPT_ENCODING: "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
        ACCEPT: "*/*",
      }
    end
    let(:params) do
      # rubocop:disable Layout/LineLength
      '{"name":"gemcutter","downloads":1544388,"version":"0.7.1","version_created_at":"2011-12-02T20:44:41.674Z","version_downloads":685353,"platform":"ruby","authors":"Nick Quaranto","info":"Provides the `gem yank` and `gem webhook` commands to RubyGems.","licenses":null,"metadata":{"wiki_uri":"http://wiki.github.com/qrush/gemcutter","homepage_uri":"http://rubygems.org","bug_tracker_uri":"http://github.com/qrush/gemcutter/issues","source_code_uri":"http://github.com/qrush/gemcutter","mailing_list_uri":"http://groups.google.com/group/gemcutter","documentation_uri":"http://gemcutter.org/pages/gem_docs"},"yanked":false,"sha":"e216b37b5e3e2f5e04ee1f772424f023eedf3548edf5628e7793749ed4b70d44","spec_sha":"0182742792eebc690bdbb320f58a22eb8fd24e7ab276f20c4fb092455eaf5cf0","project_uri":"https://rubygems.org/gems/gemcutter","gem_uri":"https://rubygems.org/gems/gemcutter-0.7.1.gem","homepage_uri":"http://rubygems.org","wiki_uri":"http://wiki.github.com/qrush/gemcutter","documentation_uri":"http://gemcutter.org/pages/gem_docs","mailing_list_uri":"http://groups.google.com/group/gemcutter","source_code_uri":"http://github.com/qrush/gemcutter","bug_tracker_uri":"http://github.com/qrush/gemcutter/issues","changelog_uri":null,"funding_uri":null,"dependencies":{"development":[{"name":"activesupport","requirements":"\u003e= 0"},{"name":"i18n","requirements":"\u003e= 0"},{"name":"rake","requirements":"\u003e= 0"},{"name":"rr","requirements":"\u003e= 0"},{"name":"shoulda","requirements":"\u003e= 0"},{"name":"webmock","requirements":"\u003e= 0"}],"runtime":[]}}'
      # rubocop:enable Layout/LineLength
    end

    it "responds with 200 and no body" do
      post(rubygems_path, params:, headers:)

      expect(response).to have_http_status(:ok)
      expect(response.body).to be_empty
    end

    it "stores the response" do
      expect do
        post(rubygems_path, params:, headers:)
      end.to change(WebhookRequest, :count).by(1)

      req = WebhookRequest.last
      expect(req.source).to eq("rubygems")
      expect(req.headers.keys).to contain_exactly("content_type", "user_agent")
      expect(req.body).to start_with("{\"name\"")
    end
  end
end
