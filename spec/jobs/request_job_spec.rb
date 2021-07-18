require 'rails_helper'

RSpec.describe RequestJob, type: :job do
  describe 'execution with #perform_later' do
    it 'makes async http request' do
      ActiveJob::Base.queue_adapter = :test
      expect { RequestJob.perform_later }.to have_enqueued_job
    end

    it 'makes async http request with given params' do
      ActiveJob::Base.queue_adapter = :test
      expect do
        RequestJob.perform_later(first_name: 'Bill', last_name: 'Gates', email: 'gates@ccc.com')
      end.to have_enqueued_job.with(first_name: 'Bill', last_name: 'Gates', email: 'gates@ccc.com')
    end

    it 'performs job asynchronously' do
      ActiveJob::Base.queue_adapter = :test
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
      expect do
        RequestJob.perform_later
      end.to have_performed_job.on_queue('default')
    end
  end
end
