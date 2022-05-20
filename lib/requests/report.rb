# frozen_string_literal: true

require 'openssl'
require 'excon'
require 'json'

module Requests
  class Report
    DEFAULT_HEADERS = {
      'Content-Type' => 'application/json'
    }.freeze
    DEFAULT_KEY = '5b464f0dae14138f73c95416658bb8c31f508667e7bcc85a'
    REPORTS_SOURCE_URL = 'https://report-app-test-xom.herokuapp.com/api/reports'

    def call
      Excon.post(REPORTS_SOURCE_URL,
                 body: body,
                 headers: headers)
    end

    private

    def headers
      DEFAULT_HEADERS.merge('Authorization' => generate_token)
    end

    def body
      return @body if defined?(@body)

      @body = {
        report_type: 'plain',
        nonce: SecureRandom.uuid
      }.to_json
    end

    def generate_token
      OpenSSL::HMAC.hexdigest('SHA256', DEFAULT_KEY, body)
    end
  end
end
