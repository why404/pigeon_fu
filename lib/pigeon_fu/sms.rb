module PigeonFu
  class Sms
    
    module ClassMethods
      # include PigeonFu::Base::InstanceMethods
      
      def send_message(options={})
        raise ArgumentError, "You must pass the :to argument to specify the receiver." unless options[:to]
        raise ArgumentError, "You must pass the :say argument to specify the short message." unless options[:say]
        @sms = PigeonFu::Sms.new
        @sms.auth = PigeonFu::Authenticate.new(PigeonFu::SMS_INTERFACE_CODE)
        @sms.content = encoded_message_from(options[:say])
        @sms.receivers = fetch_receivers_from(options[:to])
        @sms.sender = fetch_sender_from(options[:from])
        @sms.send_phone_text_message
      end
      
      def send_message_to_me(text_content)
        send_message :to => default_contact, :say => text_content, :from => default_ims
      end
      
      def encoded_message_from(content)
        Base64.encode64(content.strip).gsub('+', '%2B').gsub('&','%26').chomp! # CGI.escape
      end
      
      def fetch_receivers_from(given_receivers)
        receiver_phone_numbers = []
        if given_receivers.is_a?(String)
          receivers = given_receivers.include?(',') ? given_receivers.split(',') : [given_receivers]
        end
        receivers.each do |receiver|
          if receiver.is_a_phone_number?
            receiver_phone_numbers << receiver
          else
            raise ArgumentError, "#{receiver} haven't or isn't a valid phone number"
          end
        end
        receiver_phone_numbers
      end
      
      def fetch_sender_from(given_sender = nil)
        unless given_sender.nil?
          raise ArgumentError, "#{sender} is not a valid phone number." unless sender.is_a_phone_number?
        end
        given_sender
      end
    end
    
    module InstanceMethods
      attr_writer :auth, :content, :receivers, :sender
      
      def send_phone_text_message
        @receivers.each { |receiver| send_message_to(receiver) }
      end
      
      def send_message_to(receiver)
        auth_token = @auth.run
        request_vars = {'SendMsgRequest' => [auth_token, receiver, @content, @sender].join("$")}
        response = PigeonFu::Rest.get(PigeonFu::SMS_INTERFACE_URL, request_vars)
        response_code = response.split("=")[1]
        raise SendSMSFailed, response_code unless response_code.to_i == 200
      end
    end
    
    extend self::ClassMethods
    include self::InstanceMethods
    
  end
end
