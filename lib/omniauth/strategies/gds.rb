require 'omniauth-oauth2'
require 'multi_json'

class OmniAuth::Strategies::Gds < OmniAuth::Strategies::OAuth2
  uid { user['uid'] }

  info do
    {
      name: user['name'],
      email: user['email']
    }
  end

  extra do
    {
      user: user,
      permissions: user['permissions'],
      organisations: user['organisations'],
    }
  end

  def user
    @user ||= MultiJson.decode(access_token.get('/user.json').body)['user']
  end

end
