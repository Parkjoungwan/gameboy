Rails.application.routes.draw do
  get "/" => 'movie#title_screen'
  get "title_screen" => 'movie#title_screen'
  get 'reboots' => 'movie#reboots'

  get 'save_slot_init_title' => 'movie#save_slot_init_title'
  get 'save_slot_init_worldmap' => 'movie#save_slot_init_worldmap'

  get 'save_slot_worldmap/:slot' => 'movie#save_slot_worldmap'
  get 'save_slot_title/:slot' => 'movie#save_slot_title'
  get 'save_slot_save/:slot' => 'movie#save_slot_save'
  get 'save_slot_load/:slot' => 'movie#save_slot_load'
  get 'save_slot_up_title' => 'movie#save_slot_up_title'
  get 'save_slot_down_title' => 'movie#save_slot_down_title'
  get 'save_slot_up_worldmap' => 'movie#save_slot_up_worldmap'
  get 'save_slot_down_worldmap' => 'movie#save_slot_down_worldmap'
  get 'save_slot_load_success' => 'movie#save_slot_load_success'
  get 'save_slot_save_success' => 'movie#save_slot_save_success'
  


  get 'worldmap' => 'movie#worldmap'
  get 'makemovielist' => 'movie#makemovielist'
  get 'ending' => 'movie#ending'


  get 'ready' => 'movie#ready'
  get 'battle' => 'movie#battle'
  get 'run' => 'movie#run'
  get 'battle/fight' => 'movie#fight'
  get 'lose' => 'movie#lose'
  get 'win' => 'movie#win'
  

  get 'moviedex_init' => 'movie#moviedex_init'
  get 'moviedex_no' => 'movie#moviedex_no'
  get 'moviedex' => 'movie#moviedex'
  get 'moviedex_right' => 'movie#moviedex_right'
  get 'moviedex_left' => 'movie#moviedex_left'
  

  get 'worldmap/up' => 'movie#worldmap_up'
  get 'worldmap/down' => 'movie#worldmap_down'
  get 'worldmap/left' => 'movie#worldmap_left'
  get 'worldmap/right' => 'movie#worldmap_right'
end
