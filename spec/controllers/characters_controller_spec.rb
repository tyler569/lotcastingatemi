# frozen_string_literal: true

require 'rails_helper'
require 'support/auth_token'

RSpec.describe Api::V1::CharactersController, type: :controller do
  def authenticated_header(user)
    "Bearer #{user.token}"
  end

  before do
    @player = FactoryBot.create(:player)
    @chronicle = FactoryBot.create(:chronicle, st_id: @player.id)

    @character = FactoryBot.create(:character, player_id: @player.id)
    @character.ties = [{"hidden": true, "subject": "hidden", "rating": 3}, {"subject": "visible", "rating": 3}]
    @character.save!

    @chronicle_player = FactoryBot.create(:player)
    @chronicle_character = FactoryBot.create(:character, player_id: @chronicle_player.id, chronicle_id: @chronicle.id)

    @chronicle.players = [@chronicle_player]
    @chronicle.save!
  end

  context 'as user in chronicle' do
    describe 'querying a character in the chronicle' do
      it 'does not show hidden intiacies' do
        request.headers['Authorization'] = authenticated_header(@chronicle_player)

        get :show, params: { id: @chronicle.id, format: :json }
        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)
        expect(json['ties'].select{|t| t["hidden"]}.length).to be == 0
      end
    end
  end

  context 'as storyteller' do
    describe 'querying a character in the chronicle' do
      it 'shows hidden intimacies' do
        request.headers['Authorization'] = authenticated_header(@player)

        get :show, params: { id: @chronicle.id, format: :json }
        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)
        expect(json['ties'].select{|t| t["hidden"]}.length).to be > 0
      end
    end
  end
end
