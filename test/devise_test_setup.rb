require 'test_helper'

class ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @current_admin_user = users(:one)
    sign_in @current_admin_user
  end
end
