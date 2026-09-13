class ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to root_path, notice: "Thank you. Your report has been submitted to our verification pipeline."
    else
      flash.now[:alert] = "Please provide the claim text before submitting."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def report_params
    params.require(:report).permit(:claim_text, :source_url, :platform)
  end
end
