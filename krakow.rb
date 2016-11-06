# encoding: UTF-8
require_relative '../bicycle_report-gem/lib/bicycle_report.rb'

#Kraków - http://www.openstreetmap.org/relation/2768921
lat_min = 50.00
lat_max = 50.12
lon_min = 19.78
lon_max = 20.09
main_generator = ReportGenerator.new(lat_min, lat_max, lon_min, lon_max)
main_generator.set_language(:pl)
main_generator.register_linkable_source("https://zikit.cartodb.com")
main_generator.register_linkable_source("http://www.ankietarowerowa.pl/")
main_generator.register_linkable_source("https://www.facebook.com/KrakowMiastemRowerow/")
main_generator.register_linkable_source("http://ibikekrakow.com/")
main_generator.register_linkable_source("https://twitter.com/oficerKRK")
main_generator.register_linkable_source("https://www.facebook.com/ZIKiT.Krakow/")
main_generator.register_linkable_source("http://www.skyscrapercity.com/showthread.php?t=642754")
main_generator.start_writing_summary_pages()

bicycle_ways = BicycleWayRaportGenerator.new(lat_min, lat_max, lon_min, lon_max)
contraflow_exceptions_by_names = [
#jednokierunkowość powinna zostać:
"Przegorzalska",

#de facto nie jest jednokierunkowa lub jest dojazdem/wyjazdem z dwupasmówki
"Aleja Żubrowa",
"Mieczysława Medweckiego",
"Prądnicka",
"Ofiar Dąbia",
"Plac Braci Dudzińskich",
"Słotna",
"Cystersów",
"Józefa Dietla",
"Aleja Kasy Oszczędności Miasta Krakowa",
"Biskupa Jana Prandoty",
"Rzemieślnicza",
"Bieżanowska",
"Wielicka",
"Franciszka Bujaka",
"Józefa Marcika",
"Doktora Judyma"
]
bicycle_ways.process(contraflow_exceptions_by_names)

krakow_crossing = CrossingReportGenerator.new(lat_min, lat_max, lon_min, lon_max)
krakow_crossing.generate_html_files_about_crossings

krakow_bicycle_parking = BicycleParkingRaportGenerator.new(lat_min, lat_max, lon_min, lon_max)
krakow_bicycle_parking.generate_statistics_about_bicycle_parkings

main_generator.copy_css()
main_generator.finish_writing_summary_pages()
