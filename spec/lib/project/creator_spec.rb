require 'rails_helper'

describe Project::Creator do
  describe '#perform' do
    it 'creates a project' do
      expect { described_class.new.perform }.to change { Project.count }.by(1)
    end
  end
end
