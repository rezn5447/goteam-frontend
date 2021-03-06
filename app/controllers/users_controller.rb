class UsersController < ApplicationController
  include UsersHelper
  def show
    @user = UsersHelper.get(session)
    @stats = StatsHelper.list(session)
    @stats_array = []
    i = 0
    while i < 10
      @stats_array << @stats[i.to_s]
      i += 1
    end
    @matches = MatchesHelper.list(session)
    @upcoming_matches = []
    @past_matches = []
    @matches.each do |match|
      match.each do |k,v|
        if (DateTime.strptime("#{v["date"]}","%Y-%m-%d %H:%M") > DateTime.now) && (@upcoming_matches.length < 3)
          @upcoming_matches << match
        elsif (DateTime.strptime("#{v["date"]}","%Y-%m-%d %H:%M") < DateTime.now) && (@past_matches.length < 3)
          @past_matches << match
        end
      end
    end
  end

  def create
    @user = UsersHelper.post({"user"=>
    {"first_name"=>params['first_name'], "last_name"=>params['last_name'],"email"=>params['email'], "city"=>params['city'], "street"=>params['street'], "state"=>params['state'], "zip"=>params['zip'], "phone"=>params['phone'], "password"=>params['password']}})
    if @user['id'] != nil
      redirect_to root_path
    else
      render 'new'
    end
  end
end
