module PigeonFu

  AUTH_INTERFACE_URL = 'http://open.189works.com/InterfaceForap/auth.aspx'
  
  SMS_INTERFACE_CODE = 10000033
  SMS_INTERFACE_URL = 'http://ims.open.ctfactory.com/ims/ghsendim.php'
  
  CALL_INTERFACE_CODE = 0
  CALL_INTERFACE_URL = ''
  
  IVR_INTERFACE_CODE = 0
  IVR_INTERFACE_URL  = ''
  
  AGPS_INTERFACE_CODE = 0
  AGPS_INTERFACE_URL = ''
  
  PHONE_NUMBER_REGEX = /^\d{8,13}$/ # The overwhelming majority phone numbers in China should be supported.
  
  class << self
    def send_message(options={})
      PigeonFu::Sms.send_message(options)
    end
    
    def send_message_to_me(content)
      PigeonFu::Sms.send_message_to_me(content)
    end
  end
  
  
  module Base
    # In fact it will as a class-methods module mix-in class object. For example see PigeonFu::Sms::ClassMethods
    module InstanceMethods
    
      def default_contact
        contacts = contacts_list
        contacts.size > 0 ? contacts[contacts.keys[0]] : nil
      end
      
      def default_ims
        ims = ims_list
        ims.size > 0 ? ims[ims.keys[0]] : nil
      end
      
      def contacts_list
        defined?(PIGEON_CONTANCT) ? fetch_phone_numbers_from(PIGEON_CONTANCT) : {}
      end
      
      def ims_list
        defined?(PIGEON_IMS) ? fetch_phone_numbers_from(PIGEON_IMS) : {}
      end
      
      def fetch_phone_numbers_from(defined_members)
        number_list = Hash.new
        defined_contact = defined_members
        if defined_contact.is_a?(Hash)
          number_list = defined_contact
        else defined_contact.is_a?(String)
          number_list[defined_contact] = defined_contact
        end
        number_list
      end
    
    end
    
  end
 
end