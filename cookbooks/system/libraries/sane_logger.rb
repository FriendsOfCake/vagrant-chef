class Chef
  class Log
    # Processing... messages should go in the debug level
    def self.info(msg=nil, &block)
      if msg.include?('Guard resource')
        debug(msg, &block)
      elsif msg =~ /^Processing|entered create/
        debug(msg, &block)
      elsif msg =~ /(no longer in run list, remove minitest tests)$/
        debug(msg, &block)
      else
        super
      end
    end

    # Previous|Cloning|Current... messages should go in the debug level
    def self.warn(msg=nil, &block)
      if msg =~ /^(Previous|Cloning|Current)/
        debug(msg, &block)
      else
        super
      end
    end
  end
end
