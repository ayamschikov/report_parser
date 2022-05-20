# frozen_string_literal: true

class App
  def call
    response = Requests::Report.new.call

    return Printers::Error.print(response) unless response.status == 200

    parsed_response = Parsers::UniqConnectionsCount.new(response.body).parse

    Printers::Terminal.new(parsed_response).print
  end
end
