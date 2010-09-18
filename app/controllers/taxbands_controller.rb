class TaxbandsController < ApplicationController
  # GET /taxbands
  # GET /taxbands.xml
  def index
    @taxbands = Taxband.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @taxbands }
    end
  end

  # GET /taxbands/1
  # GET /taxbands/1.xml
  def show
    @taxband = Taxband.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @taxband }
    end
  end

  # GET /taxbands/new
  # GET /taxbands/new.xml
  def new
    @taxband = Taxband.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @taxband }
    end
  end

  # GET /taxbands/1/edit
  def edit
    @taxband = Taxband.find(params[:id])
  end

  # POST /taxbands
  # POST /taxbands.xml
  def create
    @taxband = Taxband.new(params[:taxband])

    respond_to do |format|
      if @taxband.save
        format.html { redirect_to(@taxband, :notice => 'Taxband was successfully created.') }
        format.xml  { render :xml => @taxband, :status => :created, :location => @taxband }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @taxband.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /taxbands/1
  # PUT /taxbands/1.xml
  def update
    @taxband = Taxband.find(params[:id])

    respond_to do |format|
      if @taxband.update_attributes(params[:taxband])
        format.html { redirect_to(@taxband, :notice => 'Taxband was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @taxband.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /taxbands/1
  # DELETE /taxbands/1.xml
  def destroy
    @taxband = Taxband.find(params[:id])
    @taxband.destroy

    respond_to do |format|
      format.html { redirect_to(taxbands_url) }
      format.xml  { head :ok }
    end
  end
  
  def import
    band_xml = File.read('public/counciltaxbands.xml')
    band_hash = Hash.from_xml(band_xml)
    logger.info("--- band_hash: #{band_hash.inspect}")
    band_hash['council_tax_bands']['periods']['period'].each do |period|
      @start_date = period['date_start']
      @end_date = period['date_end']
      @market_value_date = period['date_market_value']
      period['bands'].each do |band|
        @taxband = Taxband.new()
        @taxband.start_date = @start_date
        @taxband.end_date = @end_date
        @taxband.market_value_date = @market_value_date
        @taxband.name = band['name']
        @taxband.lower_limit = band['lower_limit'].to_i
        @taxband.upper_limit = band['upper_limit'].to_i
        @taxband.charge = band['charge']
        @taxband.save
      end
    end
  end
end
