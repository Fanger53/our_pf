class PortfoliosController < ApplicationController
  before_action :require_user
  before_action :set_user
  before_action :set_portfolio, only: [:show, :edit, :update, :destroy]
  before_action :require_owner, only: [:show, :edit, :update, :destroy]

  def index
    @portfolios = @user.portfolios.includes(:portfolio_sections)
  end

  def show
    @sections = @portfolio.portfolio_sections.ordered
  end

  def new
    @portfolio = @user.portfolios.build
    @templates = Portfolio::TEMPLATES
  end

  def create
    @portfolio = @user.portfolios.build(portfolio_params)
    
    if @portfolio.save
      create_default_sections(@portfolio)
      redirect_to [@user, @portfolio], notice: 'Portafolio creado exitosamente.'
    else
      @templates = Portfolio::TEMPLATES
      render :new
    end
  end

  def edit
    @templates = Portfolio::TEMPLATES
    @section_types = Portfolio::SECTION_TYPES
  end

  def update
    if @portfolio.update(portfolio_params)
      redirect_to [@user, @portfolio], notice: 'Portafolio actualizado exitosamente.'
    else
      @templates = Portfolio::TEMPLATES
      @section_types = Portfolio::SECTION_TYPES
      render :edit
    end
  end

  def destroy
    @portfolio.destroy
    redirect_to user_portfolios_path(@user), notice: 'Portafolio eliminado exitosamente.'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_portfolio
    @portfolio = @user.portfolios.find(params[:id])
  end

  def require_owner
    unless @user == current_user
      redirect_to root_path, alert: 'No tienes permiso para acceder a este portafolio.'
    end
  end

  def portfolio_params
    params.require(:portfolio).permit(:title, :description, :template, :is_public)
  end
  
  def create_default_sections(portfolio)
    case portfolio.template
    when 'default'
      create_default_template_sections(portfolio)
    when 'modern'
      create_modern_template_sections(portfolio)
    when 'creative'
      create_creative_template_sections(portfolio)
    when 'minimal'
      create_minimal_template_sections(portfolio)
    end
  end
  
  def create_default_template_sections(portfolio)
    sections = [
      { section_type: 'hero', title: 'Bienvenido', content: "¡Hola! Soy #{portfolio.user.name}", position: 1 },
      { section_type: 'about', title: 'Acerca de Mí', content: 'Cuéntanos sobre ti...', position: 2 },
      { section_type: 'skills', title: 'Mis Habilidades', content: 'Lista tus habilidades principales...', position: 3 },
      { section_type: 'projects', title: 'Mis Proyectos', content: 'Muestra tus mejores proyectos...', position: 4 },
      { section_type: 'contact', title: 'Contacto', content: 'Cómo contactarme...', position: 5 }
    ]
    
    sections.each do |section_data|
      portfolio.portfolio_sections.create!(section_data)
    end
  end
  
  def create_modern_template_sections(portfolio)
    sections = [
      { section_type: 'hero', title: 'Inicio', content: "Soy #{portfolio.user.name}, desarrollador", position: 1 },
      { section_type: 'about', title: 'Sobre Mí', content: 'Mi historia profesional...', position: 2 },
      { section_type: 'experience', title: 'Experiencia', content: 'Mi trayectoria laboral...', position: 3 },
      { section_type: 'projects', title: 'Portafolio', content: 'Proyectos destacados...', position: 4 },
      { section_type: 'testimonials', title: 'Testimonios', content: 'Lo que dicen de mí...', position: 5 },
      { section_type: 'contact', title: 'Hablemos', content: 'Información de contacto...', position: 6 }
    ]
    
    sections.each do |section_data|
      portfolio.portfolio_sections.create!(section_data)
    end
  end
  
  def create_creative_template_sections(portfolio)
    sections = [
      { section_type: 'hero', title: 'Mi Mundo Creativo', content: "Bienvenido al portafolio de #{portfolio.user.name}", position: 1 },
      { section_type: 'about', title: 'Mi Historia', content: 'El viaje creativo...', position: 2 },
      { section_type: 'gallery', title: 'Galería', content: 'Mis trabajos visuales...', position: 3 },
      { section_type: 'projects', title: 'Proyectos Creativos', content: 'Mis creaciones...', position: 4 },
      { section_type: 'skills', title: 'Herramientas Creativas', content: 'Software y técnicas...', position: 5 },
      { section_type: 'contact', title: 'Colaboremos', content: 'Trabajemos juntos...', position: 6 }
    ]
    
    sections.each do |section_data|
      portfolio.portfolio_sections.create!(section_data)
    end
  end
  
  def create_minimal_template_sections(portfolio)
    sections = [
      { section_type: 'hero', title: portfolio.user.name, content: 'Descripción breve...', position: 1 },
      { section_type: 'projects', title: 'Trabajo', content: 'Proyectos seleccionados...', position: 2 },
      { section_type: 'contact', title: 'Contacto', content: 'email@example.com', position: 3 }
    ]
    
    sections.each do |section_data|
      portfolio.portfolio_sections.create!(section_data)
    end
  end
end
