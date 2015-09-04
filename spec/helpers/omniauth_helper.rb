def set_omniauth(opts = {})
  default = {
    :provider => :facebook,
    :uid     => "1234",
    :info => {
      :email => "foobar@example.com",
      :name => "bar"
    }
  }
  credentials = default.merge(opts)
  provider = credentials[:provider]
  user_hash = credentials[:info]

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
    'uid' => credentials[:uid],
    'provider' => provider.to_s,
    "info" => {
      "email" => user_hash[:email],
      "name" => user_hash[:name],
    }
    })
  end

  def set_invalid_omniauth(opts = {})
    credentials = { :provider => :facebook,
      :invalid  => :invalid_crendentials
    }.merge(opts)

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]
  end
