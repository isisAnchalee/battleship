require 'rails_helper'

RSpec.describe Api::V1::GamesController, type: :controller do
  describe 'GamesController' do 
    describe '#update' do 
      context 'when logged out'
        let(:uri) { '/api/v1/update' }        
        it 'renders 401' do 
        end
      end

      context 'when logged in' do 
      end
    end
  end
end
