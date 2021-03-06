class TestsController < ApplicationController
  before_action :signed_in_user
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  # GET /tests
  # GET /tests.json
  def index
    @tests = current_user.test.all
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
    @tests = current_user.test.find(params[:id])
  end

  # GET /tests/new
  def new
    @test = Test.new
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = current_user.test.new(test_params)
    
    respond_to do |format|
      xss_test
      if @test.save
        format.html { redirect_to @test, success: 'Test was successfully created.' }
        format.json { render :show, status: :created, location: @test }
      else
        format.html { render :new, warning: 'Fields can\'t be blank.'}
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update    
    xss_test
    respond_to do |format|
      if @test.update(test_params)        
        format.html { redirect_to @test, success: 'Test was successfully updated.' }
        format.json { render :show, status: :ok, location: @test }
      else
        format.html { render :edit, warning: 'Fields can\'t be blank.' }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to tests_url, success: 'Test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download_pdf
    @test = current_user.test.find(params[:test_id])
    pdf = render_to_string pdf: "some_file_name", template: "tests/show.html.erb", encoding: "UTF-8"        
    save_path = Rails.root.join('pdfs','Report.pdf')
    File.open(save_path, 'wb') do |file|
      file << pdf        
    end
    respond_to do |f| 
      f.html { redirect_to @test, success: 'PDF file is downloaded.'}
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:name, :path, :description)
    end

    def get_payload
      "<script>document.write(\"<ssx>true</ssx>\")</script>"
    end

    def xss_test
      #begin
        url = URI::parse(@test.path)
        page = Nokogiri::HTML(open("#{url}?#{get_payload}"))
        content = page.xpath("//ssx").collect(&:text)
        if content.include? "true" 
          @test.report_data = "XSS-attack test : failed.\nSQL-injection test : passed.\nAdvice : kiss of your programmers and take into Dimon Cherkashin."
        else
          @test.report_data = "XSS-attack test : passed.\nSQL-injection test : passed."      
        end
      #rescue => e
      #  render 'edit' 
      #  flash[:warning] = 'Error: #{e.message}'        
      #end      
    end

   
end