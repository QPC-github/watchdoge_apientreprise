require 'rails_helper'

describe StatsController, type: :controller do
  describe 'happy path (e2e spec)', vcr: { cassette_name: 'stats/jwt_usage' } do
    subject { get :jwt_usage, params: { jti: valid_jti } }

    its(:status) { is_expected.to eq(200) }
    its(:body) { is_expected.to match_json_schema('stats/jwt_usage') }
  end

  describe 'when having an error', vcr: { cassette_name: 'stats/jwt_usage' } do
    subject { get :jwt_usage, params: { jti: valid_jti } }

    before { allow_any_instance_of(Stats::JwtUsageService).to receive(:success?).and_return(false) }

    its(:status) { is_expected.to eq(500) }
  end
end