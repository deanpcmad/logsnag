require "ostruct"

module LogSnag
  class Insight < OpenStruct

    def initialize(attributes)
      super OpenStruct.new(attributes)
    end

  end
end
