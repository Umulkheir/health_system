class SmsWorker
  include Sidekiq::Worker
  sidekiq_options queue: :sms, retry: false

  def perform(phone_number, code)
    HTTParty.post('http://w3.synqafrica.com/api/messages/send', body: {api_key: 'c8de764e5da0df4449b401869e0960a7', phone_number: phone_number, text: "Hello. Your verification code is #{code}."})
  end
end
