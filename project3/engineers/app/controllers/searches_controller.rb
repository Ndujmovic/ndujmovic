class SearchesController < ApplicationController

def search_by_lname
   @engineer = Engineer.find_by_lname( params[:engineer][:lname] )
      render(:controller => :engineers, :action => :show)
end


def search
   p = params[:project]['name'] unless (params[:engineer].nil? or params[:engineer]['name'].nil?)
   p =  params[:engineer][:lname] unless !p.nil?
   @results = Engineer.multi_solr_search p, :models => [Engineer, Project], :results_format => :objects

   render :action => ("search_results.html.erb")
end


end
