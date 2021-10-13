require 'rails_helper'

describe ProjectsController do
  describe 'POST /projects' do
    it 'creates a project' do
      allow_any_instance_of(Project::Creator).to receive(:uniq_api_key).and_return('api-key')
      post '/projects'
      expect(JSON.parse(response.body)['api_key']).to eq('api-key')
    end
  end
end
