require 'spec_helper'

describe App do
  include Rack::Test::Methods

  def app
    API
  end

  describe App do
    describe 'GET /v1/numbers' do
      it 'get several numbers' do
        get "/v1/numbers"
        last_response.status.should == 200
      end
    end
  end
end