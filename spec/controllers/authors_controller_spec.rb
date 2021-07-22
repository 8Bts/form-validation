require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  describe 'POST /authors' do
    context 'with valid params' do
      subject do
        post :create,
             params: {
               author: {
                 first_name: 'Bill',
                 last_name: 'Gates',
                 email: 'gatess@ll.cc'
               }
             }
      end

      it 'should render new' do
        expect(subject).to render_template(:new)
      end

      it 'should set flash to [User data has been sent!]' do
        expect(subject.request.flash[:success]).to be_present
      end

      it 'should respond with status code 201' do
        expect(subject).to have_http_status(:created)
      end

      it 'should call RequestJob.perform_later' do
        expect(RequestJob).to receive(:perform_later)
        post :create,
             params: {
               author: {
                 first_name: 'King',
                 last_name: 'James',
                 email: 'king@sss.cc'
               }
             }
      end
    end

    context 'with invalid params' do
      it 'gets status 422' do
        post :create, params: {
          author: {
            first_name: nil,
            last_name: nil,
            email: nil
          }
        }
        expect(response).to have_http_status(422)
      end

      it 'should not call RequestJob.perform_later' do
        expect(RequestJob).to_not receive(:perform_later)
        post :create,
             params: {
               author: {
                 first_name: nil,
                 last_name: 'Gates',
                 email: 'gatess@ll.cc'
               }
             }
      end
    end
  end
end
