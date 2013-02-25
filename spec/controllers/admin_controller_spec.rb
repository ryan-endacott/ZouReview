require 'spec_helper'

describe AdminController do

  describe '#crawl_grades' do

    context 'correct password' do

      it 'should correctly start a job to crawl the grades' do
        pending 'GradeCrawlerJob needs to be made'
      end

      it 'should render a success message' do
        pending 'GradeCrawlerJob needs to be made'
      end

      after(:each) do
        post :crawl_grades, :term => 'FS2010', :password => ENV['SECRET_PASSWORD']
      end
    end

    context 'incorrect password' do

      it 'should redirect to the admin page with an error' do

      end

      after(:each) do
        post :crawl_grades, :term => 'FS2010', :password => 'lol'
      end
    end

  end

end
