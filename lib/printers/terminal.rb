# frozen_string_literal: true

module Printers
  class Terminal
    attr_reader :report

    def initialize(report)
      @report = report
    end

    def print
      $stdout.print "Report:\n"

      report.each do |path, count|
        $stdout.print "#{path} - #{count}\n"
      end
    end
  end
end
