# frozen_string_literal: true

module Printers
  class Error
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def print
      $stdout.print "There was an error with #{response.status} status code\n"
    end
  end
end
