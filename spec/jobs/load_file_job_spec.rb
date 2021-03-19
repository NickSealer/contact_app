# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoadFileJob, type: :job do
  let(:user) { FactoryBot.create(:user) }
  let!(:document) { FactoryBot.create(:document, user: user) }
  let(:csv_text) do
    "name,birthdate,phone,address,credit_card,email\nPedro Rosas,1986/12/20,(+57) 123-123-11-32,Calle 15 # 43 -8,5274 5763 9425 9961,pedro@gmail.com\n"
  end

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  describe '#perform' do
    context 'calls the job' do
      it 'document was enqueued' do
        expect do
          LoadFileJob.perform_later(document, user)
        end.to have_enqueued_job
      end

      it 'job called once' do
        LoadFileJob.perform_later(document, user)
        expect(LoadFileJob).to have_been_enqueued.exactly(:once)
      end

      it 'job enqueued at default queue' do
        LoadFileJob.perform_later(document, user)
        expect(LoadFileJob).to have_been_enqueued.on_queue('default')
      end

      it 'job performed' do
        ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
        allow(File).to receive(:read).and_return(csv_text)
        LoadFileJob.perform_later(document, user)
        expect(LoadFileJob).to have_been_performed
      end
    end
  end
end
