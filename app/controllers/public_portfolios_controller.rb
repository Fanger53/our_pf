class PublicPortfoliosController < ApplicationController
  before_action :set_portfolio
  
  def show
    unless @portfolio&.published?
      redirect_to root_path, alert: 'Portafolio no encontrado o no público.'
      return
    end
    
    @user = @portfolio.user
    @sections = @portfolio.portfolio_sections.ordered
    
    # Seleccionar el layout basado en la plantilla
    render layout: portfolio_layout
  end
  
  private
  
  def set_portfolio
    @portfolio = Portfolio.find_by(slug: params[:slug])
  end
  
  def portfolio_layout
    case @portfolio&.template
    when 'modern'
      'portfolio_modern'
    when 'creative'
      'portfolio_creative'
    when 'minimal'
      'portfolio_minimal'
    else
      'portfolio_default'
    end
  end
end
