module LogSnag
  class Client
    BASE_URL = "https://api.logsnag.com/v1"

    attr_reader :token, :adapter

    def initialize(token:, adapter: Faraday.default_adapter, stubs: nil)
      @token = token
      @adapter = adapter

      # Test stubs for requests
      @stubs = stubs
    end

    def log(project:, channel:, event:, **params)
      attributes = {project: project, channel: channel, event: event}
      Log.new post_request("log", body: attributes.merge(params)).body
    end

    def connection
      @connection ||= Faraday.new(BASE_URL) do |conn|
        conn.headers["Authorization"] = "Bearer #{token}"
        conn.request :json
        conn.response :json
        conn.adapter adapter, @stubs
      end
    end

    private

    def post_request(url, body:, headers: {})
      handle_response connection.post(url, body, headers)
    end

    def handle_response(response)
      case response.status
      when 400
        raise Error, "Error 400: Your request was malformed. '#{response.body["message"]}'"
      when 401
        raise Error, "Error 401: You did not supply valid authentication credentials. '#{response.body["errors"]}'"
      when 403
        raise Error, "Error 403: You are not allowed to perform that action."
      when 404
        raise Error, "Error 404: No results were found for your request."
      when 409
        raise Error, "Error 409: Your request was a conflict."
      when 429
        raise Error, "Error 429: Your request exceeded the API rate limit."
      when 500
        raise Error, "Error 500: We were unable to perform the request due to server-side problems."
      end

      response
    end

  end
end
