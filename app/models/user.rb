class User < ApplicationRecord
  has_secure_password
  has_many :portfolios, dependent: :destroy
  
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  
  before_save { self.email = email.downcase }
  after_create :create_default_portfolio
  
  def main_portfolio
    portfolios.first
  end
  
  def public_portfolio
    portfolios.find_by(is_public: true) || main_portfolio
  end
  
  def portfolio_slug
    main_portfolio&.slug || generate_user_slug
  end
  
  private
  
  def create_default_portfolio
    portfolios.create!(
      title: "Portafolio de #{name}",
      description: "Mi portafolio personal",
      template: 'default',
      is_public: false
    )
  end
  
  def generate_user_slug
    name.downcase.gsub(/[^a-z0-9\s-]/, '').gsub(/\s+/, '_')
  end
end
