
class View

  # clears CLI display and prints Banner
  # .banner : -> nil
  def self.banner
    system("clear")
    banner = <<-BANNER
    ooooo      ooo oooooo   oooo ooooooooooooo 
    `888b.     `8'  `888.   .8'  8'   888   `8 
     8 `88b.    8    `888. .8'        888      
     8   `88b.  8     `888.8'         888      
     8     `88b.8      `888'          888      
     8       `888       888           888      
    o8o        `8      o888o         o888o    
     
             New York Times CLI Search
    BANNER
    puts banner.light_green
  end

  # Used to clear page between screens
  # .new_page : -> nil
  def self.new_page
    puts self.banner
    puts ""
  end
end
