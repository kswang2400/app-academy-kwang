# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  short_url    :string
#  long_url     :string
#  submitter_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true, length: { maximum: 1024 }
  validate :no_more_than_five_per_minute

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user
  )

  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :tags,
    through: :taggings,
    source: :tagtopic
  )

  def self.random_code
    loop do
      url = SecureRandom.urlsafe_base64
      return url unless ShortenedUrl.exists?(short_url: url)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: ShortenedUrl.random_code
    )
  end

  def self.prune
    ShortenedUrl.all.each do |url|
      url.destroy if url.num_recent_uniques(100) == 0 &&
        !url.submitter.premium
    end

    nil
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques(n)
    visits.select(:user_id).distinct
      .where('created_at > ?', n.minutes.ago)
      .count
  end

  def no_more_than_five_per_minute
    if submitter.submitted_urls
      .where('created_at > ?', 1.minutes.ago)
      .count > 5 && !submitter.premium
      errors[:spam] << "can't submit more than 5 per minute"
    end
  end
end
