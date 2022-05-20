# frozen_string_literal: true

require './lib/requests/report'

describe Requests::Report do
  subject(:report_request) { described_class.new }

  let(:uuid) { '86d33e54-c653-11e8-948b-6ba330d80b69' }
  let(:headers) do
    {
      'Content-Type' => 'application/json',
      'Authorization' => '2e45f515fa57821137a14082d4a68c4738fafe7d1b145e399afe71a52124e38b'
    }
  end

  before do
    allow(SecureRandom).to receive(:uuid).and_return(uuid)

    stub_request(:post, described_class::REPORTS_SOURCE_URL)
      .with(headers: headers)
      .to_return(
        status: status,
        body: response_body
      )
  end

  describe '#call' do
    context 'with successful call' do
      let(:status) { 200 }
      let(:response_body) do
        "104.56.19.34 - '/'\n115.249.26.171 - '/membership'\n226.94.121.62 - '/sign_in'\n12.168.137.214 - '/sign_in'\n140.41.6.88 - '/'\n" # rubocop:disable Layout/LineLength
      end

      it { expect(report_request.call.body).to eq(response_body) }
    end

    context 'with unsuccessful call' do
      let(:status) { 401 }
      let(:response_body) { '' }

      it { expect(report_request.call.body).to eq(response_body) }
    end
  end
end
