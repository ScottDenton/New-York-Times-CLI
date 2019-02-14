
class View
  def self.banner
    system("clear")
    banner = <<-BANNER

          #     #                  #     #
          ##    # ###### #    #     #   #   ####  #####  #    #
          # #   # #      #    #      # #   #    # #    # #   #
          #  #  # #####  #    #       #    #    # #    # ####
          #   # # #      # ## #       #    #    # #####  #  #
          #    ## #      ##  ##       #    #    # #   #  #   #
          #     # ###### #    #       #     ####  #    # #    #

                     #######
                        #    # #    # ######  ####
                        #    # ##  ## #      #
                        #    # # ## # #####   ####
                        #    # #    # #           #
                        #    # #    # #      #    #
                        #    # #    # ######  ####

    BANNER
    puts banner.light_green
  end

  def self.new_page
    puts self.banner
    puts ""
  end

  def self.header
    puts "Welcome to the NYT CLI Search!"
    puts "Type 'quit' at any time to exit."
  end
end
