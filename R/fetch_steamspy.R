#' parse steam spy API json
#' @param json A json produced by the Steam Spy API
#' @return A tibble of steam spy values, usually ~ 100 games, unless
#' allgames() was usedue
#' @export
parse_sspy <- function(json){
  gamel <- data.frame(do.call("rbind", json))
  gamedf <- gamel %>% purrr::map_dfc(~unlist(.))
  gamedf$price <- dplyr::case_when(
    nchar(gamedf$price) == 4 ~ as.numeric(paste0(substr(gamedf$price,1,2), ".", substr(gamedf$price,3,4))),
    nchar(gamedf$price) == 3 ~ as.numeric(paste0(substr(gamedf$price,1,1), ".", substr(gamedf$price,2,3))),
    nchar(gamedf$price) == 2 ~ as.numeric(paste0(".",gamedf$price)),
    TRUE ~ 0
  )
  gamedf$initialprice <- dplyr::case_when(
    nchar(gamedf$initialprice) == 4 ~ as.numeric(paste0(substr(gamedf$initialprice,1,2), ".", substr(gamedf$initialprice,3,4))),
    nchar(gamedf$initialprice) == 3 ~ as.numeric(paste0(substr(gamedf$initialprice,1,1), ".", substr(gamedf$initialprice,2,3))),
    nchar(gamedf$initialprice) == 2 ~ as.numeric(paste0(".",gamedf$initialprice)),
    TRUE ~ 0
  )
  gamedf$discount <- as.integer(gamedf$discount)
  return(gamedf)
}


#' returns all games and data currently in the steamspy database
#' @return A tibble with all games and data currently in the Steamspy database
#' @export
all_games <- function(){
  json <- jsonlite::fromJSON("http://steamspy.com/api.php?request=all")
  parse_sspy(json)
}

#' Return a tibble with games corresponding to a specific genre.
#' Replace spaces with +
#' @param genre a string
#' @return A tibble with games corresponding to a specific genre.
#' @example \dontrun{
#' genregames("Early+Access")
#' }
#' @export
genre_games <- function(genre){
  json <- jsonlite::fromJSON(paste0("http://steamspy.com/api.php?request=genre&genre=",genre))
  parse_sspy(json)
}


#' Return a tibble with games corresponding to a specific tag.
#' Replace spaces with +
#' @param tag a string
#' @return A tibble with games corresponding to a specific tag.
#' @example \dontrun{
#' genregames("Sci-fi")
#' }
tag_games <- function(tag){
  json <- jsonlite::fromJSON(paste0("http://steamspy.com/api.php?request=tag&tag=",tag))
  parse_sspy(json)
}





#' return a tibble with the top 100 games since March 2009.
#' @return A tibble with the top 100 games since March 2009.
#' @export
top_forever <- function(){
  json <- jsonlite::fromJSON("http://steamspy.com/api.php?request=top100forever")
  parse_sspy(json)
}


#' return a tibble with the top 100 games from the last 2 weeks.
#' @return A tibble with the top 100 games from the last 2 weeks.
#' @export
top_2wk <- function(){
  json <- jsonlite::fromJSON("http://steamspy.com/api.php?request=top100in2weeks")
  parse_sspy(json)
}





#' Return more detailed information on one specific game, given appid
#' currently need to figure out how to parse the json, has a list column
#' of tags !!!WARNING!!! Unlike most of the other functions, this could
#' conceivably run up against the API limits, which is 4 calls / second
#' if you just blindly run it in a loop. Don't be a jerk!
#' @param appid An integer corresponding to the steam game, look up via
#' the summary top... or other ways
#' @export
game_detail <- function(appid=730){
  json <- jsonlite::fromJSON(paste0("http://steamspy.com/api.php?request=appdetails&appid=",
                                    appid))
}


