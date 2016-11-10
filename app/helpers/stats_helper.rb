module StatsHelper

  URL = 'https://api-goteam.herokuapp.com/api'
  # URL = "http://localhost:3001/api"

  def self.list(current_user_id)
    HTTParty.get(URL + "/users/#{current_user_id}/stats.json")
  end

  def self.create(current_user_id, sport_id)
    HTTParty.post(URL + "/users/#{current_user_id}/stats.json", body: {"sport_id": sport_id})
  end

  def self.get(id, current_user_id)
    HTTParty.post(URL + "/sports/#{id}/stats/find.json", body: {:user_id => "#{current_user_id}"})
  end

end
