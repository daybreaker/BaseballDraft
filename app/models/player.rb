class Player < ActiveRecord::Base
  
  has_many :projections
  has_and_belongs_to_many :positions
  belongs_to :team
  
  def self.exists(player, team)
    p = Player.where('name=? and team_id=?', player, team.id).first
    (p.blank?) ? false : p
  end
  
  def position
    positions.collect(&:abbr).join(', ')
  end
  
  def self.import_kffl_players(position)
    
    stats_map = {   
      "SV" => "S",
      "IP" => "INN",
      "H" => "HA",      
      "BB" => "BBI"      
    }
    
    c = Nokogiri::HTML(open("http://www.kffl.com/fantasy-baseball/fantasy-baseball-projections.php?fLeague=MIXED&fPosition=#{position}&order_col=&order_colprev=pit_w&order_down=1&doexport=print"))
    
    rows = c.css('table table tr')

    headers = rows[0].css('td b')[2..(rows[0].css('td b').length-1)].collect(&:text)
    
    rows[1..rows.length-1].each do |row|
      
      #get player URL
      #player_url = row.css('td a')[0].attributes['href'].value
      
      #get player name & team
      team_map = {'LAD' => 'LA', 'LAA' => 'ANA', 'WSH' => 'WAS', 'CWS' => "CHW"}
      team_abbr = team_map.keys.include?(row.css('td')[1].text) ? team_map[row.css('td')[1].text] : row.css('td')[1].text
      team = Team.where('abbr=?',team_abbr).first      
      pos = Position.where('abbr=?',position).first
      player = Player.exists(row.css('td')[0].text, team)
      
      if !player
        player = Player.new(:name => row.css('td')[0].text, :team_id => team.id)
        player.save
      end
      
      
      
      player_positions = player.positions.find_all{|x| x.abbr == position}
      PlayersPositions.new(:player_id => player.id, :position_id => pos.id).save if player_positions.empty?
      
      if Projection.where('site=? AND player_id=?','kffl',player.id).blank?
        projection = Projection.new(:player_id => player.id, :year => 2011, :site=>'kffl')
      
        headers.each do |h|   
          stats_key = stats_map.keys.include?(h) ? stats_map[h] : h
          projection[stats_key] = row.css('td')[headers.index(h)+2].text
        end
        projection.save
      end
      
      
      
    end
  end
  
  
  #%w(C 1B 2B 3B SS OF SP RP).each{|x| Player.import_cbs_players(x) }
  def self.import_cbs_players(position)

    c = Nokogiri::HTML(open("http://fantasynews.cbssports.com/fantasybaseball/stats/sortable/points/#{position}/standard/projections?&print_rows=9999"))
    
    headers = c.css('table.data tr')[1].css('td')[1..(c.css('table.data tr')[1].css('td').count-1)].collect(&:text)
    
    c.css('table.data tr')[2..(c.css('table.data tr').count - 2)].each do |tr|
      
      #player_url
      player_url = tr.css('td a')[0].attributes['href'].value
      #split into player name | team abbr
      info = tr.css('td')[0].text.split(',')
      team = Team.where('abbr=?',info[1][1..(info[1].length-1)]).first
      pos = Position.where('abbr=?',position).first
      player = Player.exists(info[0], team)
      if !player
        player = Player.new(:name => info[0], :team_id => team.id)
        player.save
      end
      
      #Add Position for Player
      
      player_positions = player.positions.find_all{|x| x.abbr == position}
      PlayersPositions.new(:player_id => player.id, :position_id => pos.id).save if player_positions.empty?
      
      if Projection.where('site=? AND player_id=?','cbs',player.id).blank?
        projection = Projection.new(:player_id => player.id, :year => 2011, :site=>'cbs', :url=>'http://fantasynews.cbssports.com'+player_url)
      
        headers.each do |h|
          oldh = h
          h = "H" + h if(['1B','2B','3B'].include?(h))
          projection[h] = tr.css('td')[headers.index(oldh)+1].text
        end
        projection.save
      end
    end      
  end
  
end
