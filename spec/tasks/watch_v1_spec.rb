# do NOT require this, VCR won't work, requests will be really made !
#require 'support/rake_helper.rb'

describe 'watch_v1:all', vcr: { cassette_name: 'apie_v1' } do
  include_context 'rake'

  # /!\
  # we use at_most+at_least instead of exactly because :
  # Tools::PingWorker generate multiple threads and sometimes some threads are killed by rspec
  # before they end so they never call the right number of times

  context 'calls with all endpoints' do
    it 'at least 5' do
      expect_any_instance_of(PingAPIEOnV1).to receive(:perform_ping).at_least(5).times.and_call_original
      subject.invoke
      sleep 0.1
    end

    it 'at most 14' do
      expect_any_instance_of(PingAPIEOnV1).to receive(:perform_ping).at_most(14).times.and_call_original
      subject.invoke
    end

    it 'calls perform_ping, no mail and no errors ' do
      expect_any_instance_of(PingMailer).not_to receive(:ping)
      expect(Rails.logger).not_to receive(:error)

      subject.invoke
    end
  end

  context 'call with period = 5' do
    let(:period) { 5 }
    it 'at least once' do
      expect_any_instance_of(PingAPIEOnV1).to receive(:perform_ping).at_least(:once).times.and_call_original
      subject.invoke(period)
      sleep 0.1
    end

    it 'at most 3' do
      expect_any_instance_of(PingAPIEOnV1).to receive(:perform_ping).at_most(3).times.and_call_original
      subject.invoke(period)
    end

    it 'calls the task with a period parameter' do
      expect(PingAPIEOnV1).to receive(:new).with(:period => period).exactly(:once).and_call_original
      expect_any_instance_of(PingMailer).not_to receive(:ping)
      expect(Rails.logger).not_to receive(:error)

      subject.invoke(period)
    end
  end
end