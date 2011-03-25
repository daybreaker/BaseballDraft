class PlayersController < ApplicationController
  # GET /players
  # GET /players.xml
  def index
    
    if params[:position].blank? || params[:position] == 'UTIL'
      @players = Player.joins(:positions, :projections).where('positions.abbr IN ("C", "1B", "2B", "3B", "SS", "OF")').order('projections.FPTS desc').limit(20)
    elsif params[:position] == 'P'
      @players = Player.joins(:positions, :projections).where('positions.abbr IN ("SP", "RP")').order('projections.FPTS desc').limit(20)
    else 
      @players = Player.joins(:positions, :projections).where('positions.abbr=?', params[:position]).order('projections.FPTS desc').limit(20)
    end
    
    if (!params[:position].blank? && (['SP','RP','P'].include?(params[:position])))
      @headers_main =  ["W", "ERA", "WHIP", "K", "S", "INN"]
      @headers_secondary = ["GS", "QS", "CG", "L", "BS", "BBI", "HA"]
      @players.sort!{|x, y| @headers_main.inject(0){|sum, w| sum + y.projections.average(w) } <=> @headers_main.inject(0){|sum, w| sum + x.projections.average(w) } }
    
    else
      @headers_main = ["BA", "R", "HR", "RBI", "SB"]
      @headers_secondary =  ["AB", "BB", "H", "H1B", "H2B", "H3B", "KO", "CS", "OBP", "SLG"]
      @players.sort!{|x, y| @headers_main.inject(0){|sum, w| sum + y.projections.average(w) } <=> @headers_main.inject(0){|sum, w| sum + x.projections.average(w) } }
    end
      
   


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @players }
    end
  end

  # GET /players/1
  # GET /players/1.xml
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/new
  # GET /players/new.xml
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.xml
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        format.html { redirect_to(@player, :notice => 'Player was successfully created.') }
        format.xml  { render :xml => @player, :status => :created, :location => @player }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.xml
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to(@player, :notice => 'Player was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.xml
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to(players_url) }
      format.xml  { head :ok }
    end
  end
end
