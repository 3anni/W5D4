# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true
  validates :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  def self.random_code
    shorty = SecureRandom::urlsafe_base64

    until !ShortenedUrl.exists?(short_url: shorty)
      shorty = SecureRandom::urlsafe_base64
    end

    shorty
  end

  after_initialize do |short_url|
    res = generate_short_url
    if self.new_record?
      self.short_url = res
    end
  end

  private
  def generate_short_url
    ShortenedUrl.random_code
  end
end
