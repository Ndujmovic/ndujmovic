require 'rubygems'
require 'rufus/scheduler'
require 'lib/tf_idf'

class EngineersController < ApplicationController

  in_place_edit_for :engineer, :fname
  in_place_edit_for :engineer, :lname
  in_place_edit_for :engineer, :years_of_experience
  auto_complete_for :engineer, :lname
  auto_complete_for :engineer, :fname

  def get_matches
    update_similar
    puts "*** Executed get matches #{params[:id]}"    
@engineer = Engineer.find(params[:id]) 
    render :update do |page|        
    page.replace_html 'match_div', 
    :partial => "shared/matches_partial", 
    :object => @similar_engineers 
    page.visual_effect :highlight, 'match_div'        
    end 
    end 

def search_by_lname
   @engineer = Engineer.find_by_lname( params[:engineer][:lname] )
end

def search
   p = params[:q]['classtext_field']
   @results = Engineer.multi_solr_search p, :models => [Engineer, Project], :results_format => :objects

   render :template => "searches", :action => ("search_results.html.erb")
end

    def tag
@engineers=Engineer.find_tagged_with( params[:id])

    flash[:notice] = "Items tagged with #{params[:id]}"
render(:action => :index)
    end


   def update_similar
     
      # get engineer's resumes
      @all_engineers = Engineer.all
      @all_engineers.each do |e|
      e_file = e.id
      out = File.new("resumes/#{e_file}.txt", "w")
      out.puts e.get_resume
      out.close
      end

      scheduler = Rufus::Scheduler.start_new
      @similar_engineers = Hash.new
      @similar_engineers["a"] = "asdf"
      scheduler.every '10s' do
         # get similar engineers
      @similar_engineers["b"] = "basdf"
         cosine_sims = get_cosine_sim("resumes")
         cosine_sims.each { |file_pair, cosine|
      @similar_engineers["c"] = "basdf"
            # file_pair looks like
            # (tempdir/jhu_mcgilman.txt and tempdir/jhu_jfrankford.txt)
            @eng_pairs = file_pair.scan(/[\d]+/)
            eng1 = Engineer.find_by_id(@eng_pairs[0])
            eng2 = Engineer.find_by_id(@eng_pairs[1])
            if(eng1.id == params[:id]) 
                @similar_engineers[eng2.id] = cosine
            elsif (eng2.id == params[:id]) 
                @similar_engineers[eng1.id] = costine
            end
            #puts "#{file_pair}: #{cosine}"
         }
         puts "HELLO!!!!!"
      end
       #  @similar_engineers = Engineer.all
      #scheduler.join
   end

# GET /engineers
# GET /engineers.xml
    def index
 #   @engineers = Engineer.all
   @engineers = Engineer.paginate :all, :per_page => 10, :page => params[:page]
    respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @engineers }
    end
    end

# GET /engineers/1
# GET /engineers/1.xml
    def show
    update_similar
@engineer = Engineer.find(params[:id])
    @resume = Resource.find_last_by_engineer_id(@engineer)
    respond_to do |format|
    format.html # show.html.erb
    format.xml  { render :xml => @engineer }
    end
    end


def get_resume
   @resume_text = ""
   @engineer = Engineer.find(params[:id])
   if @engineer.resources then
      engineer.resources.each do |r|
         @resume_text = File.read(r.path)
      end
   end
   @resume_text
end

# GET /engineers/new
# GET /engineers/new.xml
    def new
    @engineer = Engineer.new

    respond_to do |format|
    format.html # new.html.erb
    format.xml  { render :xml => @engineer }
    end
    end

# GET /engineers/1/edit
    def edit
@engineer = Engineer.find(params[:id])
    @resume = Resource.find_last_by_engineer_id(@engineer)
    end

# POST /engineers
# POST /engineers.xml
    def create
      @engineer = Engineer.new(params[:engineer])
      @engineer.project_assignments.each do |pa|
        puts "Adding project to pa #{pa.name}"
        pa.project = Project.find_by_name(pa.name)
      end

      respond_to do |format|
        if @engineer.save
          flash[:notice] = 'Engineer was successfully created.'
          format.html { redirect_to(@engineer) }
          format.xml  { render :xml => @engineer, :status => :created, :location => @engineer }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @engineer.errors, :status => :unprocessable_entity }
        end
      end
    end

# PUT /engineers/1
# PUT /engineers/1.xml
    def update
      @engineer = Engineer.find(params[:id])

      respond_to do |format|
        if @engineer.update_attributes(params[:engineer])
          if params[:resource][:f]
             @old_resource = Resource.find_by_engineer_id(@engineer)
             @old_resource.destroy unless @old_resource.nil?
             @resource = Resource.new(params[:resource])
             @resource.engineer = @engineer
             @resource.save!
           end
           if params[:email][:address]
            @email = Email.new(params[:email])
            @email.engineer = @engineer
            @email.save!
           end
          flash[:notice] = 'Engineer was successfully updated.'
          format.html { redirect_to(@engineer) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @engineer.errors, :status => :unprocessable_entity }
        end
      end
    end


# DELETE /engineers/1
# DELETE /engineers/1.xml
    def destroy
@engineer = Engineer.find(params[:id])
    @engineer.destroy

    respond_to do |format|
    format.html { redirect_to(engineers_url) }
    format.xml  { head :ok }
    end
    end
    end
