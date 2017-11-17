json.extract! patient_history, :id, :symptoms, :diagnosis, :tests, :physicals, :prescription, :created_at, :updated_at
json.url patient_history_url(patient_history, format: :json)
