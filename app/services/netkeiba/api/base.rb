module Netkeiba::Api
  class Base
    BASE_URL = 'https://db.netkeiba.com'

    def initialize(admin)
      @admin = admin
    end

    private
    def conn
      @conn ||= Faraday.new(BASE_URL)
    end

    def handle_error(res)
      puts res.status
      if res.status != 200
        # エラーメッセージのヒアドキュメント
        msg = <<~MSG
        status_code: #{res.status}
        body: #{res.body}
        MSG
        # raise Line::ApiError, msg
        raise RuntimeError
      end

      return res
    end
  end
end