class InitMikroBot

  def run
    router.ping
  end

  private

  def router
    @router ||= Mikrotik.new(
      Figaro.env.router_host,
      Figaro.env.router_user,
      Figaro.env.router_pass
    )
  end
end
