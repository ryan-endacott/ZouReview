require 'grade_crawler_job'


class AdminController < ApplicationController

  def index
  end

  def crawl_grades

    if params[:password] == ENV['SECRET_PASSWORD'] and params[:term]
      terms = params[:term].split(',').collect(&:strip)
      terms.each do |term|
        Delayed::Job.enqueue GradeCrawlerJob.new(term)
      end
      flash[:success] = "Success!  Crawling of the following terms is beginning: #{params[:term]}"
    else
      flash[:error] = "Error!  Incorrect password."
    end

    redirect_to admin_path and return

  end

end
