require 'rails_helper.rb'

describe 'watch_v2:all', vcr: { cassette_name: 'apie_v2' } do
  include_context 'rake'

  before do
    allow_any_instance_of(PingAPIEOnV2).to receive(:worker).and_return(FakeWorker.new)
  end

  context 'with all endpoints' do
    it 'at least 5' do
      expect_any_instance_of(PingAPIEOnV2).to receive(:perform_ping).at_least(5).times.and_call_original
      task.invoke
      sleep 0.1
    end

    it 'at most 25' do
      expect_any_instance_of(PingAPIEOnV2).to receive(:perform_ping).at_most(25).times.and_call_original
      task.invoke
    end

    it 'calls perform_ping, no mail and no errors' do
      create_report_for_all
      expect_any_instance_of(PingMailer).not_to receive(:ping)
      expect(Rails.logger).not_to receive(:error)

      task.invoke
    end
  end

  context 'when only endpoints with period = 5' do
    let(:period) { 5 }

    it 'at least 1' do
      expect_any_instance_of(PingAPIEOnV2).to receive(:perform_ping).at_least(1).times.and_call_original
      task.invoke(period)
      sleep 0.1
    end

    it 'at most 3' do
      expect_any_instance_of(PingAPIEOnV2).to receive(:perform_ping).at_most(3).times.and_call_original
      task.invoke(period)
    end

    it 'calls the task with a period parameter' do
      create_report_for_all
      expect(PingAPIEOnV2).to receive(:new).with(period: period).exactly(:once).and_call_original
      expect_any_instance_of(PingMailer).not_to receive(:ping)
      expect(Rails.logger).not_to receive(:error)

      task.invoke(period)
    end
  end
end
