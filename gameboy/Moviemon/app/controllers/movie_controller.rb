class MovieController < ApplicationController
  $view = []
  $game = {"player_power" => 42, "player_hit" => 2}
  $player = {"x" => 130, "y" => 90, "move" => 0, "ball" => 0}
  $selected = []

  #----------------------------------------------------------------------------------------
  # tiltle map 안에서의 액션 

  def makemovielist
    $view = []
    File.foreach('app/assets/movie.json').each_with_index do |line, number|
      hash = line if rand * 2 > 1.0 
      if hash.class == String
        $view << JSON.parse(hash)
      end
    end
    redirect_to :controller => 'movie', :action => 'worldmap'
  end

  def title_screen
  end

  def worldmap
    if $view.size == 0
      redirect_to :controller => 'movie', :action => 'ending'
    end
  end

  def reboots
    $view = []
    $game = {"player_power" => 42, "player_hit" => 2}
    $player = {"x" => 130, "y" => 90, "move" => 0, "ball" => 0}
    $selected = []
    redirect_to :controller => 'movie', :action => 'title_screen'
  end

  #----------------------------------------------------------------------------------------


  #----------------------------------------------------------------------------------------
  # save 액션
  def save_slot_save
    slot = params[:slot]
    targetline = []
    str = ""
    File.foreach("app/assets/save.json").with_index do |line, line_number|
      if line.include? "\"slot\":\"#{params[:slot]}\""
       targetline << line_number
     end
    end
    File.foreach("app/assets/save.json").with_index do |line, line_number|
      unless targetline.include? line_number
        str += line
      end
    end
    File.open("app/assets/save.json", "w") do |f|
      f.write(str)
    end
    f = File.open("app/assets/save.json", "a")
    $view.each do |hash|
      hash["Vname"] = "view"
      hash["slot"] = slot
      hash = hash.to_json
      f.puts(hash)
    end
    $game["Vname"] = "game"
    $game["slot"] = slot
    $player["Vname"] = "player"
    $player["slot"] = slot
    hash = $game.to_json
    f.puts(hash)
    hash = $player.to_json
    f.puts(hash)
    $selected.each do |hash|
      hash["Vname"] = "selected"
      hash["slot"] = slot
      hash = hash.to_json
      f.puts(hash)
    end
    f.close()
    redirect_to :controller => 'movie', :action => 'save_slot_save_success'
  end

  def save_slot_load
    slot = params[:slot]
    $view = []
    $game = {"player_power" => 42, "player_hit" => 2}
    $player = {"x" => 130, "y" => 90, "move" => 0, "ball" => 0}
    $selected = []
    check = 0
    f = File.open("app/assets/save.json", "r")
    f.each_line do |line|
      a = JSON.parse(line)
      if a["slot"] == "#{slot}"
        check = 1
        if a["Vname"] == "view"
          $view << a
        elsif a["Vname"] == "game"
          $game = a
        elsif a["Vname"] == "player"
          $player = a
        elsif a["Vname"] == "selected"
          $selected << a
        else
        end
      end
    end
    if check == 1
      redirect_to :controller => 'movie', :action => 'save_slot_load_success'
    else
      redirect_to :controller => 'movie', :action => 'title_screen'
    end
  end

  def save_slot_init_title
    $game["index"] = 1
    redirect_to :controller => 'movie', :action => 'save_slot_title', :slot => $game["index"]
  end

  def save_slot_init_worldmap
    $game["index"] = 1
    redirect_to :controller => 'movie', :action => 'save_slot_worldmap', :slot => $game["index"]
  end

  def save_slot_title
    if File.file?("app/assets/save.json") != true
      f = File.open("app/assets/save.json", "w")
      f.close
    end
  end

  def save_slot_worldmap
    if File.file?("app/assets/save.json") != true
      f = File.open("app/assets/save.json", "w")
      f.close
    end
  end

  def save_slot_up_worldmap
    if $game["index"] == 1
      $game["index"] = 3
    else 
      $game["index"] -= 1
    end
    redirect_to :controller => 'movie', :action => 'save_slot_worldmap', :slot => $game["index"]
  end

  def save_slot_down_worldmap
    if $game["index"] == 3
      $game["index"] = 1
    else 
      $game["index"] += 1
    end
    redirect_to :controller => 'movie', :action => 'save_slot_worldmap', :slot => $game["index"]
  end

  def save_slot_up_title
    if $game["index"] == 1
      $game["index"] = 3
    else 
      $game["index"] -= 1
    end
    redirect_to :controller => 'movie', :action => 'save_slot_title', :slot => $game["index"]
  end

  def save_slot_down_title
    if $game["index"] == 3
      $game["index"] = 1
    else 
      $game["index"] += 1
    end
    redirect_to :controller => 'movie', :action => 'save_slot_title', :slot => $game["index"]
  end


  def save_slot_save_success
  end

  def save_slot_load_success
  end

  #----------------------------------------------------------------------------------------


  #----------------------------------------------------------------------------------------
  # 배틀 안에서의 액션
  def battle
  end

  def ready
    $game["index"] = rand(0...$view.size)
    $game["Title"] = $view[$game["index"]]["Title"]
    $game["Director"] = $view[$game["index"]]["Director"]
    $game["Poster"] = $view[$game["index"]]["Poster"]
    if $view[$game["index"]]["imdbRating"].to_f < 6.0
      $game["monster_power"] = 10
      $game["monster_hit"] = 1
    elsif $view[$game["index"]]["imdbRating"].to_f < 7.0
      $game["monster_power"] = 20
      $game["monster_hit"] = 1
    elsif $view[$game["index"]]["imdbRating"].to_f < 8.0
      $game["monster_power"] = 25
      $game["monster_hit"] = 1
    elsif $view[$game["index"]]["imdbRating"].to_f < 9.0
      $game["monster_power"] = 25
      $game["monster_hit"] = 2
    elsif $view[$game["index"]]["imdbRating"].to_f < 9.5
      $game["monster_power"] = 30
      $game["monster_hit"] = 2
    else
      $game["monster_power"] = 42
      $game["monster_hit"] = 3
    end
    redirect_to :controller => 'movie', :action => 'battle'
  end

  def fight
    $game["monster_power"] -= $game["player_hit"]
    if $game["monster_power"] <= 0
      return redirect_to :controller => 'movie', :action => 'win'
    else
      $game["player_power"] -= $game["monster_hit"]
      if $game["player_power"] <= 0
        return redirect_to :controller => 'movie', :action => 'lose'
      end
    end
    return redirect_to :controller => 'movie', :action => 'battle'
  end

  def run
    $game["player_power"] = 42
  end

  def lose
    $view.delete_at($game["index"])
    $game["player_power"] = 42
  end

  def win
    $selected << $view[$game["index"]]
    $view.delete_at($game["index"])
    $player["ball"] -= 1
    $game["player_power"] = 42
    $game["player_hit"] += 1
  end
  #----------------------------------------------------------------------------------------


  #----------------------------------------------------------------------------------------
  # moviedex 안에서의 액션
  def moviedex_init
    $game["index"] = 0
    if $selected.size == 0
      return redirect_to :controller => 'movie', :action => 'moviedex_no'  
    end
    redirect_to :controller => 'movie', :action => 'moviedex'
  end

  def moviedex
  end

  def moviedex_left
    $game["index"] -= 1
    if $game["index"] < 0
      $game["index"] = $selected.size - 1
    end
    redirect_to :controller => 'movie', :action => 'moviedex'
  end

  def moviedex_right
    $game["index"] += 1
    if $game["index"] > $selected.size - 1
      $game["index"] = 0
    end
    redirect_to :controller => 'movie', :action => 'moviedex'
  end
  #----------------------------------------------------------------------------------------


  #----------------------------------------------------------------------------------------
  # 월드맵 안에서의 액션
  def worldmap_up
    if $player["y"] > 0
      $player["y"] -= 10
      $player["move"] += 1
    end
    num = rand * 10 + 1
    if $player["move"] > num
      $player["move"] = 0
      if $player["ball"] != 0
        redirect_to :controller => 'movie', :action => "ready"
      else
        $player["ball"] += 1
        redirect_to :controller => 'movie', :action => "worldmap"
      end
    elsif
      redirect_to :controller => 'movie', :action => "worldmap"
    end
  end

  def worldmap_down
    if $player["y"] < 190
      $player["y"] += 10
      $player["move"] += 1
    end
    num = rand * 10 + 1
    if $player["move"] > num
      $player["move"] = 0
      if $player["ball"] != 0
        redirect_to :controller => 'movie', :action => "ready"
      else
        $player["ball"] += 1
        redirect_to :controller => 'movie', :action => "worldmap"
      end
    elsif
      redirect_to :controller => 'movie', :action => "worldmap"
    end
  end

  def worldmap_left
    if $player["x"] > 0
      $player["x"] -= 10
      $player["move"] += 1
    end
    num = rand * 10 + 1
    if $player["move"] > num
      $player["move"] = 0
      if $player["ball"] != 0
        redirect_to :controller => 'movie', :action => "ready"
      else
        $player["ball"] += 1
        redirect_to :controller => 'movie', :action => "worldmap"
      end
    elsif
      redirect_to :controller => 'movie', :action => "worldmap"
    end
  end

  def worldmap_right
    if $player["x"] < 260
      $player["x"] += 10
      $player["move"] += 1
    end
    num = rand * 10 + 1
    if $player["move"] > num
      $player["move"] = 0
      if $player["ball"] != 0
        redirect_to :controller => 'movie', :action => "ready"
      else
        $player["ball"] += 1
        redirect_to :controller => 'movie', :action => "worldmap"
      end
    elsif
      redirect_to :controller => 'movie', :action => "worldmap"
    end
  end
end
#----------------------------------------------------------------------------------------