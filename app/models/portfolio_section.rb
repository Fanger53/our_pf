class PortfolioSection < ApplicationRecord
  belongs_to :portfolio
  
  validates :section_type, presence: true, inclusion: { in: Portfolio::SECTION_TYPES.keys }
  validates :title, presence: true
  validates :position, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  scope :ordered, -> { order(:position) }
  scope :by_type, ->(type) { where(section_type: type) }
  
  serialize :settings, JSON
  
  before_validation :set_default_position, if: -> { position.nil? }
  
  def section_type_name
    Portfolio::SECTION_TYPES[section_type] || section_type.humanize
  end
  
  def parsed_settings
    return {} unless settings.present?
    settings.is_a?(String) ? JSON.parse(settings) : settings
  rescue JSON::ParserError
    {}
  end
  
  def update_settings(new_settings)
    current_settings = parsed_settings
    self.settings = current_settings.merge(new_settings)
  end
  
  private
  
  def set_default_position
    max_position = portfolio.portfolio_sections.maximum(:position) || 0
    self.position = max_position + 1
  end
end
