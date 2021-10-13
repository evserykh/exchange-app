class Project
  class Creator
    def perform
      Project.create!(api_key: uniq_api_key)
    end

    private

    def uniq_api_key
      loop do
        api_key = SecureRandom.hex
        break api_key unless Project.where(api_key: api_key).exists?
      end
    end
  end
end
