require 'rails_helper'

describe DashboardController, type: :controller do
  describe 'Current status happy path', vcr: { cassette_name: 'current_status' } do
    subject { get :current_status }

    its(:status) { is_expected.to eq(200) }
    its(:body) { is_expected.to match_json_schema('current_status') }
  end

  describe 'Homepage status happy path', vcr: { cassette_name: 'homepage_status' } do
    subject { get :homepage_status }

    its(:status) { is_expected.to eq(200) }
    its(:body) { is_expected.to match_json_schema('homepage_status') }
  end

  describe 'Availability history status happy path', vcr: { cassette_name: 'availability_history' } do
    subject(:service_response) { @availability_results_controller }

    before do
      remember_through_tests('availability_results_controller') do
        get :availability_history
      end
    end

    its(:status) { is_expected.to eq(200) }
    its(:body) { is_expected.to match_json_schema('availability_history') }

    # rubocop:disable RSpec/ExampleLength
    it 'has no gap and from < to' do
      json = JSON.parse(service_response.body)

      json['results'].each do |provider|
        provider['endpoints_availability_history'].each do |ep|
          max_index = ep['availability_history'].size - 1
          index = 0
          previous_to_time = nil

          ep['availability_history'].each do |avail|
            if index < max_index
              # from < to (except for last one)
              expect(Time.parse(avail[0])).to be < Time.parse(avail[2])
              index += 1
            end

            # has no gap
            unless previous_to_time.nil?
              from_time = Time.parse(avail[0])
              expect(from_time).to eq(previous_to_time)
            end

            previous_to_time = Time.parse(avail[2])
          end
        end
      end
    end
  end
end
