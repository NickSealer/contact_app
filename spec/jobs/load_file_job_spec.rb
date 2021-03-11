require 'rails_helper'
include ActionDispatch::TestProcess

RSpec.describe LoadFileJob, type: :job do
  before do
    ActiveJob::Base.queue_adapter = :test
    @user = FactoryBot.create(:user)
    @document = FactoryBot.create(:document)
  end

  describe '#perform' do
    context 'calls the job' do
      it 'document Waiting status' do
        expect(@document.status).to eq('Waiting')
      end

      it 'document was enqueued' do
        expect {
          LoadFileJob.perform_later(@document, @user)
        }.to have_enqueued_job
        expect {
          LoadFileJob.perform_later(@document, @user)
        }.to have_enqueued_job.at(:no_wait)
      end

      it "job called once" do
        LoadFileJob.perform_later(@document, @user)
        expect(LoadFileJob).to have_been_enqueued.exactly(:once)
      end

      it "job enqueued at default queue" do
        LoadFileJob.perform_later(@document, @user)
        expect(LoadFileJob).to have_been_enqueued.on_queue('default')
      end

      # it "job performed" do
      #   ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
      #
      #   LoadFileJob.perform_later(@document, @user)
      #   expect(LoadFileJob).to have_been_performed
      #   expect {
      #     LoadFileJob.perform_later(@document, @user)
      #   }.to have_performed_job(LoadFileJob)
      # end
    end
  end
end
