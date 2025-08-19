class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :portfolio_sections, -> { order(:position) }, dependent: :destroy
  
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9_-]+\z/, message: "solo puede contener letras minúsculas, números, guiones y guiones bajos" }
  validates :template, presence: true
  
  before_validation :generate_slug, if: -> { slug.blank? && title.present? }
  
  scope :public_portfolios, -> { where(is_public: true) }
  scope :by_template, ->(template) { where(template: template) }
  
  # Plantillas disponibles
  TEMPLATES = {
    'default' => 'Plantilla Clásica',
    'modern' => 'Plantilla Moderna',
    'creative' => 'Plantilla Creativa',
    'minimal' => 'Plantilla Minimalista'
  }.freeze
  
  # Tipos de secciones disponibles
  SECTION_TYPES = {
    'hero' => 'Sección Principal',
    'about' => 'Acerca de Mí',
    'skills' => 'Habilidades',
    'projects' => 'Proyectos',
    'experience' => 'Experiencia',
    'education' => 'Educación',
    'contact' => 'Contacto',
    'testimonials' => 'Testimonios',
    'gallery' => 'Galería',
    'custom' => 'Sección Personalizada'
  }.freeze
  
  def to_param
    slug
  end
  
  def published?
    is_public?
  end
  
  def template_name
    TEMPLATES[template] || template.humanize
  end
  
  private
  
  def generate_slug
    base_slug = title.downcase.gsub(/[^a-z0-9\s-]/, '').gsub(/\s+/, '_')
    base_slug = user.name.downcase.gsub(/[^a-z0-9\s-]/, '').gsub(/\s+/, '_') if base_slug.blank?
    
    # Asegurar que el slug sea único
    counter = 1
    potential_slug = base_slug
    while Portfolio.exists?(slug: potential_slug)
      potential_slug = "#{base_slug}_#{counter}"
      counter += 1
    end
    
    self.slug = potential_slug
  end
end
