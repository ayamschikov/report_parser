# frozen_string_literal: true

require './lib/parsers/uniq_connections_count'

describe Parsers::UniqConnectionsCount do
  subject(:parser) { described_class.new(report) }

  context 'with empty report' do
    let(:report) { '' }
    let(:expected) { {} }

    it { expect(parser.parse).to eq(expected) }
  end

  context 'with short example report' do
    let(:expected) do
      {
        '/' => 2,
        '/membership' => 1,
        '/sign_in' => 2
      }
    end

    context 'without duplicate path and ip' do
      let(:report) do
        "104.56.19.34 - '/'\n115.249.26.171 - '/membership'\n226.94.121.62 - '/sign_in'\n12.168.137.214 - '/sign_in'\n140.41.6.88 - '/'\n" # rubocop:disable Layout/LineLength
      end

      it { expect(parser.parse).to eq(expected) }
    end

    context 'with duplicate path and ip' do
      let(:report) do
        "104.56.19.34 - '/'\n104.56.19.34 - '/'\n115.249.26.171 - '/membership'\n115.249.26.171 - '/membership'\n226.94.121.62 - '/sign_in'\n12.168.137.214 - '/sign_in'\n140.41.6.88 - '/'\n" # rubocop:disable Layout/LineLength
      end

      it { expect(parser.parse).to eq(expected) }
    end
  end

  context 'with sample report from API' do
    # rubocop:disable Layout/LineLength
    let(:report) do
      "104.56.19.34 - '/'\n115.249.26.171 - '/membership'\n226.94.121.62 - '/sign_in'\n12.168.137.214 - '/sign_in'\n140.41.6.88 - '/'\n57.244.147.34 - '/'\n223.28.31.111 - '/sign_up'\n226.94.121.62 - '/membership'\n57.218.172.237 - '/products'\n238.193.23.70 - '/sign_up'\n82.127.97.51 - '/products'\n226.94.121.62 - '/about'\n181.112.9.239 - '/about'\n226.94.121.62 - '/sign_in'\n189.38.188.67 - '/'\n169.11.209.106 - '/about'\n71.135.225.216 - '/'\n144.124.181.18 - '/products'\n181.112.9.239 - '/sign_in'\n144.124.181.18 - '/products'\n74.103.208.101 - '/sign_in'\n219.250.250.195 - '/products'\n47.129.61.67 - '/'\n223.28.31.111 - '/sign_in'\n182.44.135.229 - '/sign_up'\n127.243.16.119 - '/sign_up'\n104.56.19.34 - '/products'\n12.168.137.214 - '/sign_up'\n115.249.26.171 - '/products'\n82.127.97.51 - '/'\n38.76.54.106 - '/products'\n43.34.126.11 - '/products'\n144.124.181.18 - '/'\n157.56.166.165 - '/sign_in'\n140.41.6.88 - '/'\n172.132.252.133 - '/about'\n47.129.61.67 - '/products'\n238.193.23.70 - '/sign_up'\n157.56.166.165 - '/'\n205.177.83.9 - '/sign_in'\n189.38.188.67 - '/'\n71.135.225.216 - '/sign_up'\n47.129.61.67 - '/about'\n43.34.126.11 - '/sign_up'\n129.130.104.173 - '/membership'\n129.130.104.173 - '/products'\n226.94.121.62 - '/membership'\n90.10.184.218 - '/membership'\n141.138.179.46 - '/products'\n181.112.9.239 - '/membership'\n90.10.184.218 - '/'\n43.34.126.11 - '/about'\n191.141.74.98 - '/products'\n38.76.54.106 - '/sign_in'\n169.11.209.106 - '/sign_up'\n121.22.4.216 - '/sign_up'\n43.34.126.11 - '/'\n104.56.19.34 - '/products'\n43.34.126.11 - '/sign_in'\n169.11.209.106 - '/about'\n238.193.23.70 - '/sign_up'\n57.168.111.84 - '/membership'\n172.132.252.133 - '/sign_in'\n115.249.26.171 - '/about'\n182.44.135.229 - '/sign_up'\n144.124.181.18 - '/membership'\n47.129.61.67 - '/sign_in'\n48.196.6.111 - '/sign_in'\n121.22.4.216 - '/'\n129.130.104.173 - '/'\n38.76.54.106 - '/'\n191.141.74.98 - '/about'\n52.25.34.176 - '/products'\n57.244.147.34 - '/membership'\n57.168.111.84 - '/products'\n38.76.54.106 - '/about'\n236.48.73.1 - '/about'\n205.177.83.9 - '/membership'\n157.56.166.165 - '/sign_up'\n238.193.23.70 - '/sign_in'\n226.94.121.62 - '/about'\n57.218.172.237 - '/products'\n104.56.19.34 - '/sign_up'\n226.94.121.62 - '/sign_in'\n57.244.147.34 - '/sign_up'\n253.241.245.238 - '/'\n219.250.250.195 - '/products'\n82.127.97.51 - '/membership'\n205.177.83.9 - '/products'\n182.44.135.229 - '/products'\n157.56.166.165 - '/about'\n57.218.172.237 - '/about'\n219.250.250.195 - '/about'\n108.94.251.173 - '/'\n25.27.162.163 - '/'\n157.56.166.165 - '/sign_up'\n140.41.6.88 - '/membership'\n57.244.147.34 - '/products'\n141.138.179.46 - '/sign_in'\n43.34.126.11 - '/about'\n"
    end
    # rubocop:enable Layout/LineLength
    let(:expected) do
      {
        '/' => 17,
        '/about' => 13,
        '/membership' => 11,
        '/products' => 17,
        '/sign_in' => 14,
        '/sign_up' => 12
      }
    end

    it { expect(parser.parse).to eq(expected) }
  end
end
