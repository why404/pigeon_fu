module PigeonFu
  class Authenticate
  
    def self.start(options={})
      new(options).run
    end
    
    # 调用相关API之前需要获得电信开放平台的认证授权
    def initialize(with_interface_code)
      raise RuntimeError, "constant PIGEON_ACCOUNT_SID sould be defined" unless defined?(ENV["PIGEON_ACCOUNT_SID"])
      raise RuntimeError, "constant PIGEON_ACCOUNT_TOKEN sould be defined" unless defined?(ENV["PIGEON_ACCOUNT_TOKEN"])
      @result = Hash.new
      @options = Hash.new
      @options[:account_sid] = ENV["PIGEON_ACCOUNT_SID"]     # 开发者的用户ID
      @options[:account_token] = ENV["PIGEON_ACCOUNT_TOKEN"] # 开发者访问电信API的密钥
      @options[:api_id] ||= with_interface_code              # API功能接口的编号（电信为每种API定义了一个数字编号，比如发短信的接口ID为10000033）
      @options[:url] ||= PigeonFu::AUTH_INTERFACE_URL
      @options[:timestamp] = (Time.now.to_f * 1000).to_i
      @options[:session_id] = session_id
    end
    
    def run
      parse_result(make_request)
    end
    
    private
      
      def session_id
        PigeonFu::Rest.get(PigeonFu::SESS_INTERFACE_URL)
      end

      # 生成当前用于发起认证请求的签名（signature）
      # 格式：Base64(SHA1(TimeStamp + "$" + APID + "$" + APUserAccount + "$" + FunID + "$" + APKEY))
      def generate_signature
        string_for_token = [@options[:session_id],
                            @options[:account_sid],
                            @options[:account_nick],
                            @options[:api_id],
                            @options[:account_token]
                           ].join("$")
        CGI.escape(Base64.encode64(Digest::SHA1.digest(string_for_token)).chomp!)
      end
      
      # 构造发起认证请求需要的查询字符串
      # 格式：TimeStamp + "$" + APID + "$" + APUserAccount + "$" + FunID + "$" + UrlEncode(Authenticator)
      def generate_query_string
        [@options[:session_id], @options[:account_sid], @options[:account_nick],\
          @options[:api_id], generate_signature].join("$")
      end
      
      # 发起认证请求
      def make_request
        PigeonFu::Rest.get(@options[:url], {'AuthRequest' => generate_query_string})
      end
      
      # 解析认证过后的返回结果
      # 返回数据格式：Result + "$" + TransactionID + "$" + Token+ "$" + ErrorDescription+ "$" + TimeStamp
      def parse_result(data)
        if data.include?("$")
          @result[:number], @result[:transaction_id], @result[:token],\
            @result[:error_description], @result[:timestamp]  = data.split("$")
        end
        # 返回认证后的通行证
        authorized_token
      end
      
      # 是否认证通过？
      def authenticated?
        @result[:number].to_i == 0 ? true : false
      end
      
      # 根据认证结果取得行使指定API功能的凭证
      def authorized_token
        authenticated? ? @result[:token] : (raise Unauthorized, @result)
      end
    
  end
end
