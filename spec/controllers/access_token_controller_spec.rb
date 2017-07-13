require 'rails_helper'
require 'support/shared_examples/controllers'

RSpec.describe AccessTokensController, type: :controller do
  include_examples "authenticated new"
  let(:user) { create(:registrant) }
end
