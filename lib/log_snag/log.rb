require "ostruct"

module LogSnag
  class Log < OpenStruct

    def initialize(attributes)
      super OpenStruct.new(attributes)
    end

  end
end
