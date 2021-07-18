require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  describe 'POST /authors' do
    context 'with valid params' do
      before do
        post :create,
             params: {
               first_name: 'Bill',
               last_name: 'Gates',
               email: 'gatess@ll.cc'
             }
      end

      it { should render_template(:new) }
      it { should respond_with(:created) }
      it { should set_flash[:success].to('User data has been sent!') }
    end

    context 'with invalid params' do
      it 'sends request with invalid params and get status 422' do
        post :create, params: nil
        expect(response).to have_http_status(422)

        post :create, params: {
          first_name: nil,
          last_name: 'Gates',
          email: 'gatess@ll.cc'
        }
        expect(response).to have_http_status(422)

        post :create, params: {
          first_name: 'Bill',
          last_name: nil,
          email: 'gatess@ll.cc'
        }
        expect(response).to have_http_status(422)

        post :create, params: {
          first_name: 'Bill',
          last_name: 'Gates',
          email: nil
        }
        expect(response).to have_http_status(422)

        post :create, params: {
          first_name: 'Bill',
          last_name: 'Gates',
          email: 'gatess@'
        }
        expect(response).to have_http_status(422)
      end
    end
  end
end
