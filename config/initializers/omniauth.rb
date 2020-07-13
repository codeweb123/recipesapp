Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, 'a4bbf4945507ec012e1d', '51305c2a8267f915292b623e2ff5881e85854a69'
  end