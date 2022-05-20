# frozen_string_literal: true

require './lib/masking'

describe '#masking' do # rubocop:disable RSpec/DescribeClass
  it { expect(masking(1_234_567_812_345_678)).to eq('############5678') }
  it { expect(masking(125_678)).to eq('##5678') }
  it { expect(masking(5678)).to eq('5678') }
  it { expect(masking(8)).to eq('8') }
end
