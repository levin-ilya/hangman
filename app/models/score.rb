class Score < ActiveRecord::Base
  belongs_to :player

  # Class method to get top scores
  def self.topScores
    topScoreSQL = 'SELECT CONCAT(SUBSTRING(email,1,4),\'*****\'),sum(win),sum(lost) FROM scores s INNER JOIN players p on p.id=s.player_id group by player_id order by sum(win) desc,sum(lost) asc'
    return ActiveRecord::Base.connection.execute(topScoreSQL).each do |v| v  end
  end
end
