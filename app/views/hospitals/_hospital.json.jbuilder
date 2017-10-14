json.extract! hospital, :id, :name, :location, :description, :approved, :created_at, :updated_at
json.url hospital_url(hospital, format: :json)
