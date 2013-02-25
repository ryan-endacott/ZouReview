require 'spec_helper'
require 'grade_crawler_job'

describe AdminController do

  describe '#crawl_grades' do

    let(:grade_crawler_job) { GradeCrawlerJob.new 'FS2010' }

    before(:each) do
      Delayed::Job.stub(:enqueue)
      GradeCrawlerJob.stub(:new).and_return grade_crawler_job
    end

    it 'should render the index view' do
      post :crawl_grades
      expect(response).to render_template('index')
    end

    context 'correct password' do

      it 'should correctly start a job to crawl the grades' do
        Delayed::Job.should_receive(:enqueue).with(grade_crawler_job)
        post :crawl_grades, :term => 'FS2010', :password => ENV['SECRET_PASSWORD']
      end

      it 'should render a success message' do
        post :crawl_grades, :term => 'FS2010', :password => ENV['SECRET_PASSWORD']
        flash[:success].should_not be_nil
      end

    end

    context 'incorrect password' do

      it 'should redirect to the admin page with an error' do
        post :crawl_grades, :term => 'FS2010', :password => 'lol'
        flash[:error].should_not be_nil
      end

      it 'should not start a job to crawl grades' do
        Delayed::Job.should_not_receive(:enqueue)
        post :crawl_grades, :term => 'FS2010', :password => 'lol'
      end

    end

  end

end
