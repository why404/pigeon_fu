module PigeonFu #:nodoc:
  
  class Exception < RuntimeError #:nodoc:
    def message(default=nil)
      self.class::ErrorMessage
    end
  end

  class Unauthorized < Exception #:nodoc:
    ErrorMessage = 'Unauthorized'

    def initialize(response)
      @error_code = response[:number]
      @error_desc = response[:error_description]
    end

    def message
      "Error code #{@error_code}, #{@error_desc}."
    end

    def to_s
      message
    end
  end

  class SendSMSFailed < Exception #:nodoc:
    ErrorMessage = 'Message was send failed!'
    
    attr_accessor :message

    def initialize(response_code)
      @message = "Message was send failed! Error: #{response_code}."
    end
  end

end
