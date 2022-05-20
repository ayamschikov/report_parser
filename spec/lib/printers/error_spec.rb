# frozen_string_literal: true

require './lib/printers/error'

describe Printers::Error do
  subject(:printer) { described_class.new(response) }

  let(:response) do
    Struct.new(:status, :body).new(401, '')
  end

  describe '#print' do
    it { expect { printer.print }.to output("There was an error with 401 status code\n").to_stdout }
  end
end
