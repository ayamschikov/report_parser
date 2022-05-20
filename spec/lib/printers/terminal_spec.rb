# frozen_string_literal: true

require './lib/printers/terminal'

describe Printers::Terminal do
  subject(:printer) { described_class.new(report) }

  let(:report) do
    {
      '/' => 3,
      '/login' => 4
    }
  end

  describe '#print' do
    it { expect { printer.print }.to output("Report:\n/ - 3\n/login - 4\n").to_stdout }
  end
end
