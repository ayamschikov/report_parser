# frozen_string_literal: true

module Parsers
  class UniqConnectionsCount
    attr_reader :report

    def initialize(report)
      @report = report
    end

    def parse
      @result = {}

      fill_result

      result.transform_values(&:count)
    end

    private

    attr_reader :result

    def fill_result
      report.split("\n").each do |row|
        ip, path = row.split(' - ')
        path.delete!("'")

        if result[path]
          result[path].add(ip)
        else
          result[path] = Set.new([ip])
        end
      end
    end
  end
end
