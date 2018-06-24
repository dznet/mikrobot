require mtik

class Mikrotik
  def initialize(host, user, passwd)
    @host, @user, @passwd = host, user, passwd
  end

  def connect
    @connect ||= MTik::Connection.new(host: @host, user: @user, pass: @passwd)
  end

  def ping(address="google.com", count=1)
    connect.get_reply(
      '/ping',
      "=address=#{address}",
      "=count=#{count}"
    )
  end

  def hand_response(response)
    response.each do |res|
      case res.first[0]
      when "!re"
        res.each do |r|
          Rails.logger.info "#{r[0]}:\t#{r[1]}"
        end
      when "!done"
        Rails.logger.info res.first[0]
      when "!trap"w
        Rails.logger.info res["message"]
      else
        Rails.logger.info res
      end
    end
  end

  def get_resources
    connect.get_reply(
      '/system/resource/print'
    )
  end
