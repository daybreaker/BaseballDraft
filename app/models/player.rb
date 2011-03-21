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
        player = Player.new(:name => info[0], :team_id => team.id, :url=>'http://fantasynews.cbssports.com'+player_url)
        player.save
      end
      
      #Add Position for Player
      
      player_positions = player.positions.find_all{|x| x.abbr == position}
      PlayersPositions.new(:player_id => player.id, :position_id => pos.id).save if player_positions.empty?
      
      stats = {}
      headers.each do |h|
        stats[h] = tr.css('td')[headers.index(h)+1].text
      end
      
      Projection.new(:player_id => player.id, :year => 2011, :site=>'cbs', :stats => YAML::dump(stats)).save
      
    end
    
    
    
  end
  
end
