# frozen_string_literal: true

module Api
  module V1
    class SpellsController < Api::V1::BaseController
      def create
        @character = Character.find(params[:character_id])
        @spell = Spell.new(resource_params)
        @spell.character = @character
        authorize @spell
        if @spell.save
          render json: @spell
        else
          render json: @spell.errors.details, status: :bad_request
        end
      end
    end
  end
end
