# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::QcMeritsController, type: :controller do
  def authenticated_header(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    "Bearer #{token}"
  end

  before(:each) do
    @player = FactoryBot.create(:player)
    @qc = FactoryBot.create(:qc, player_id: @player.id)
    @qc_merit = FactoryBot.create(:qc_merit, qc_id: @qc.id)
  end

  describe 'POST #create' do
    context 'With valid attributes' do
      it 'Increases merit count by 1' do
        request.headers['Authorization'] = authenticated_header(@player)
        @qc_merit_params = FactoryBot.attributes_for(:qc_merit, qc_id: @qc.id)

        expect { post :create, params: { qc_id: @qc.id, qc_merit: @qc_merit_params }, format: :json }.to change(QcMerit, :count).by(1)
      end
    end

    # context 'With invalid attributes' do
    #   it 'Increases merit count by 0' do
    #     request.headers['Authorization'] = authenticated_header(@player)
    #     @invalid_merit_params = FactoryBot.attributes_for(:qc_merit, qc_id: 'Attribute')

    #     expect { post :create, params: { qc_id: @qc.id, qc_merit: @invalid_merit_params }, format: :json }.to change(QcMerit, :count).by(0)
    #   end
    # end
  end

  describe 'DELETE #destroy' do
    it 'Decreases merit count by 1' do
      request.headers['Authorization'] = authenticated_header(@player)
      expect { delete :destroy, params: { qc_id: @qc_merit.qc_id, id: @qc_merit.id, format: :json } }.to change(QcMerit, :count).by(-1)
    end
  end

  describe 'PATCH #update' do
    it 'Updates merit attributes' do
      request.headers['Authorization'] = authenticated_header(@player)
      @updated_merit_params = FactoryBot.attributes_for(:qc_merit, qc_id: @qc.id, name: 'test1')

      expect(@qc_merit.name).not_to eq('test1')

      patch :update, params: { qc_id: @qc.id, id: @qc_merit.id, qc_merit: @updated_merit_params, format: :json }
      @qc_merit.reload

      expect(@qc_merit.name).to eq('test1')
    end
  end
end
