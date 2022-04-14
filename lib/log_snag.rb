require "faraday"
require "json"
require_relative "log_snag/version"

module LogSnag
  class Error < StandardError; end

  autoload :Client, "log_snag/client"
  autoload :Log,    "log_snag/log"

end
