require 'grade_crawler_job'


class AdminController < ApplicationController

  def index
  end

  def crawl_grades

    if params[:password] == ENV['SECRET_PASSWORD']
      Delayed::Job.enqueue GradeCrawlerJob.new(params[:term])
      flash[:success] = "Success!  Crawling of term #{params[:term]} is beginning."
    else
      flash[:error] = "Error!  Incorrect password."
    end

    redirect_to admin_path and return

  end

end
