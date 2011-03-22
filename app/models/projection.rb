class Projection < ActiveRecord::Base
  belongs_to :player
  
  def self.findHighestScoringByPosition(pos, lim)
    Projection.joins(:player => :positions).where("positions.abbr = '#{pos}'").order('projections.FPTS desc').limit(lim)
    
  end
end
