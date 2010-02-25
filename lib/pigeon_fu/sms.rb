module PigeonFu
  class Sms
    
    module ClassMethods
      include PigeonFu::Base::InstanceMethods
      
      def send_message(options={})
        raise ArgumentError, "You must pass the :to argument to specify the receiver." unless options[:to]
        raise ArgumentError, "You must pass the :say argument to specify the short message." unless options[:say]
        @sms = PigeonFu::Sms.new
        @sms.auth = PigeonFu::Authenticate.new(PigeonFu::SMS_INTERFACE_CODE)
        @sms.content = encoded_message_from(options[:say])
        @sms.receivers = fetch_receivers_from(options[:to])
        @sms.sender = fetch_sender_number(options[:from])
        @sms.send_phone_text_message
      end
      
      def send_message_to_me(text_content)
        send_message :to => default_contact, :say => text_content, :from => default_ims
      end
      
      def encoded_message_from(content)
        Base64.encode64(content.strip).gsub('+', '%2B').gsub('&','%26') # CGI.escape
      end
      
      def fetch_receivers_from(given_receivers)
        contacts = contacts_list
        receiver_phone_numbers = []
        if given_receivers.is_a?(String)
          receivers = given_receivers.include?(',') ? given_receivers.split(',') : given_receivers.to_a
        elsif given_receivers.is_a?(Symbol)
          case given_receivers
          when :all
            receivers = contacts.values
          end
        end
        receivers.each do |receiver|
          receiver = contacts[receiver] if contacts.has_key?(receiver)
          if receiver.is_a_phone_number?
            receiver_phone_numbers << receiver
          else
            raise ArgumentError, "#{receiver} haven't or isn't a valid phone number"
            # TODO
            # logger
          end
        end
        receiver_phone_numbers
      end
      
      def fetch_sender_number(given_sender)
        if given_sender.nil?
          sender = default_ims
        else
          ims = ims_list
          sender = ims.has_key?(given_sender) ? ims[given_sender] : given_sender
        end
        raise ArgumentError, "#{sender} is not a valid phone number" unless (sender && sender.is_a_phone_number?)
        sender
      end
    end
    
    module InstanceMethods
      attr_writer :auth, :content, :receivers, :sender
      
      def send_phone_text_message
        @receivers.each { |receiver| send_message_to(receiver) }
      end
      
      def send_message_to(receiver)
        token = @auth.run
        response = PigeonFu::Rest.get(PigeonFu::SMS_INTERFACE_URL, \
          {'SendMsgRequest' => [token, receiver, @content, @sender].join("$")})
        response_code = response.split("=")[1]
        
        # FIXME
        if response_code.to_i == 200
          puts "message was successfully sent to #{receiver}!"
        else
          puts "message was send failed! Error: #{response_code}"
        end
      end
    end
    
    extend self::ClassMethods
    include self::InstanceMethods
    
  end
end