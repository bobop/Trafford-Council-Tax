require 'autocomplete'
class PropertiesController < ApplicationController
  autocomplete :property, :street, :full => true, :limit => 50
  def welcome
    
  end
  
  # GET /properties
  # GET /properties.xml
  def index
    if params[:street]
      @properties = Property.where(["street = ?",params[:street]]).order('primary_address ASC').all
      @current_taxbands = Taxband.where(["end_date > ?",Time.now.strftime("%Y-%m-%d")]).all
    else
      
    end
    #@properties = Property.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @properties }
    end
  end
  
  protected

  # GET /properties/1
  # GET /properties/1.xml
  def show
    @property = Property.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @property }
    end
  end

  # GET /properties/new
  # GET /properties/new.xml
  def new
    @property = Property.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @property }
    end
  end

  # GET /properties/1/edit
  def edit
    @property = Property.find(params[:id])
  end

  # POST /properties
  # POST /properties.xml
  def create
    @property = Property.new(params[:property])

    respond_to do |format|
      if @property.save
        format.html { redirect_to(@property, :notice => 'Property was successfully created.') }
        format.xml  { render :xml => @property, :status => :created, :location => @property }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /properties/1
  # PUT /properties/1.xml
  def update
    @property = Property.find(params[:id])

    respond_to do |format|
      if @property.update_attributes(params[:property])
        format.html { redirect_to(@property, :notice => 'Property was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.xml
  def destroy
    @property = Property.find(params[:id])
    @property.destroy

    respond_to do |format|
      format.html { redirect_to(properties_url) }
      format.xml  { head :ok }
    end
  end
  
  def import
    #property_xml = File.read('public/counciltaxbanding.xml')
    doc = Hpricot.XML(File.read('public/counciltaxbanding.xml'))
    #property_hash = Hash.from_xml(property_xml)
    #logger.info("--- property_hash: #{property_hash.inspect}")
    #property_hash['ctax_records']['property'].each do |property|
    (doc/:property).each do |property|
      @property = Property.new()
      @property.secondary_address = (property/'secondary-address').inner_html
      @property.primary_address = (property/'primary-address').inner_html
      @property.street = (property/'street').inner_html
      @property.town = (property/'town').inner_html
      @property.band = (property/'band').inner_html
      @property.longitude = (property/'longitude').inner_html
      @property.latitude = (property/'latitude').inner_html
      @property.save
    end
  end
end
