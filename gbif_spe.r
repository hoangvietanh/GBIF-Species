if (!require("rgbif")) install.packages("rgbif")
if (!require("dismo")) install.packages("dismo")
if (!require("maptools")) install.packages("maptools")
if (!require("plyr")) install.packages("plyr")
if (!require("raster")) install.packages("raster")
if (!require("rgdal")) install.packages("rgdal")
if (!require("rJava")) install.packages("rJava")

###############

### get data from GADM dataset

# vnm0 <- getData('GADM' , country="VNM", level=0)
# vnm1 <- getData('GADM' , country="VNM", level=1)

#Plot
# par(mfrow(2,1))
# plot(vnm0, main="Adm. Boundaries Vietnam Level 0")
# plot(vnm1, main="Adm. Boundaries Vietnam Level 1")

#get climate data from World Clim
climate <- getData('worldclim', var='bio', res=10)
plot(climate$bio1/10, main="Nhiet do trung binh nam")


#get GBIF data for Rua ho guom - Pelochelys bibroni
nn <- name_lookup("Pelochelys bibroni*", rank = "species")
nn <- unique(nn$data$nubKey)
nn <- na.omit(nn)
df <- occ_search(taxonKey = nn, hasCoordinate = TRUE, limit = 500, return = "data")
df <- df[sapply(df, class) %in% "data.frame"]  # remove those w/o data
df <- ldply(df)
df2 <- df[, c("decimalLongitude", "decimalLatitude")]

#plot

plot(wrld_simpl, add = TRUE)
points(df2, col = "red")
