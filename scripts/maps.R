# Produce in depth maps of Arequipa 
library(mapview)
library(leaflet)
library(wesanderson)
library(sf)


df <- read.csv("data/metadata/Pedregal_tree_metadata_corrected.csv")

#arequipa district layer
 aqp <- read_sf("/Users/kirstyn.brunker/Library/CloudStorage/OneDrive-UniversityofGlasgow/Documents/GitHub/Rabies/Shapefiles AQP/other shps/regional_shp.new.shp")
 
#river
 mainRiver <- read_sf("~/Documents/GitHub/Rabies/Shapefiles AQP/outputs/chiliriver_shp_new.shp")

#water channels 
 channels <- read_sf("~/Documents/GitHub/Rabies/Shapefiles AQP/outputs/waterchannels_shp.new.shp")
 
#houses 
   houses <- read_sf("~/Documents/GitHub/Rabies/Shapefiles AQP/outputs/houses_shp_proj.new.shp")

#col palette
 pal <- colorFactor(
   palette = as.character(wes_palette("FantasticFox1")),
   domain = df$year)

#mapping
# mappedWGS=
   leaflet(df)  %>% 
   addTiles() %>% 
   addProviderTiles("Thunderforest.Neighbourhood") %>%
  setView(-71.54, -16.42, zoom = 12)%>%
  addPolygons(data=aqp,weight=3,col = 'gray',highlightOptions = highlightOptions(color = "gray", weight = 2,bringToFront = F), popup = aqp$NAME_3)%>% 
   #addCircles(data = houses, opacity=0.4,radius = 1, fillOpacity=0.5, col="beige")%>%
   addPolylines(data=mainRiver,weight=5,col = 'blue')%>% 
   addPolylines(data=channels,weight=2,col = 'purple')%>% 
  addCircleMarkers(
    data = df, lng = ~longitude, lat = ~latitude, opacity=0.7,radius = 5, fillOpacity=0.5,popup =paste("Sample id", df$seq_id, "<br>","Year:", df$year, "<br>"), fillColor=~pal(year), color=~pal(year)
  )%>%
  addLegend(
    "topright", pal = pal, values = ~df$year,
    title = "Sample year",
    opacity = 1
  )
   

#mapshot(mappedWGS, url = paste0(getwd(), "/output/maps/mappedWGS_v2.html"), file=paste0(getwd(), "/output/maps/mappedWGS_v2.png"))
  
