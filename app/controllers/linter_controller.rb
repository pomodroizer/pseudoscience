class LinterController < ApplicationController
  def index
    @sample_text = params[:text] || "Our organic herbal elixir cures clinical depression and eliminates cancer cells within 30 days. Contains pure colloidal silver and chlorine dioxide to detoxify organs and provide complete 5G radiation protection."
    @result = Claims::LinterService.new(text: @sample_text).call
  end

  def check
    @text = params[:text]
    @result = Claims::LinterService.new(text: @text).call
    render :index
  end
end
