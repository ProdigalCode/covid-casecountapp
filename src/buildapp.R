suppressPackageStartupMessages(library(casecountapp))

sources_country <- list(
  list(source_id = "JHU", admin_level = 0,
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-jhu/master/output/admin0/all.csv"),
  list(source_id = "WHO", admin_level = 0,
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-who/master/output/admin0/all.csv"),
  list(source_id = "ECDC", admin_level = 0,
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-ecdc/master/output/admin0/all.csv"),
  list(source_id = "WOM", admin_level = 0,
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-wom/master/output/admin0/all.csv")
)

sources_continent <- list(
  list(source_id = "JHU", admin_level = "continent",
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-jhu/master/output/continents.csv"),
  list(source_id = "WHO", admin_level = "continent",
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-who/master/output/continents.csv"),
  list(source_id = "ECDC", admin_level = "continent",
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-ecdc/master/output/continents.csv"),
  list(source_id = "WOM", admin_level = "continent",
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-wom/master/output/continents.csv")
)

sources_who_region <- list(
  list(source_id = "JHU", admin_level = "who_region",
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-jhu/master/output/who_regions.csv"),
  list(source_id = "WHO", admin_level = "who_region",
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-who/master/output/who_regions.csv"),
  list(source_id = "ECDC", admin_level = "who_region",
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-ecdc/master/output/who_regions.csv"),
  list(source_id = "WOM", admin_level = "who_region",
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-wom/master/output/who_regions.csv")
)

sources_global <- list(
  list(source_id = "JHU", admin_level = "global",
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-jhu/master/output/global.csv"),
  list(source_id = "WHO", admin_level = "global",
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-who/master/output/global.csv"),
  list(source_id = "ECDC", admin_level = "global",
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-ecdc/master/output/global.csv"),
  list(source_id = "WOM", admin_level = "global",
    file = "https://raw.githubusercontent.com/covid-open-data/xform-casecount-wom/master/output/global.csv")
)

timestamp <- Sys.time()
time_str <- format(timestamp, "%Y-%m-%d %H:%M %Z", tz = "UTC")

app <- register_app("Global-Covid19", path = "docs")

global_display <- build_casecount_display(
  app,
  sources = sources_global,
  ref_source = "WHO",
  name = "Global",
  desc = paste0("Covid-19 cases and deaths globally - updated ", time_str),
  state = list(
    labels = list("view_who_regions", "view_continents")),
  geo_links = list(
    list(
      display = "WHO_Regions",
      cog_type = "cog_href",
      ref_level = "who_regions",
      type = "href"
    ),
    list(
      display = "Continents",
      variable = "continent_code",
      cog_type = "cog_href",
      ref_level = "continents",
      type = "href"
    )
  ),
  order = 1,
  nrow = 1,
  ncol = 1,
  case_fatality_max = 12,
  thumb = system.file("thumbs/global/global.png", package = "casecountapp")
)

continent_display <- build_casecount_display(
  app,
  sources = sources_continent,
  ref_source = "WHO",
  name = "Continents",
  desc = paste0("Covid-19 cases and deaths by continent - updated ", time_str),
  state = list(
    sort = list(trelliscopejs::sort_spec("cur_case_who", dir = "desc")),
    labels = list("view_countries")),
  geo_links = list(list(
    display = "Countries_and_Territories",
    variable = "continent_code",
    cog_type = "cog_disp_filter",
    ref_level = "countries",
    type = "href"
  )),
  order = 2,
  case_fatality_max = 12,
  thumb = system.file("thumbs/global/continents.png", package = "casecountapp")
)

who_region_display <- build_casecount_display(
  app,
  sources = sources_who_region,
  ref_source = "WHO",
  name = "WHO Regions",
  desc = paste0("Covid-19 cases and deaths by WHO Region - updated ",
    time_str),
  state = list(
    sort = list(trelliscopejs::sort_spec("cur_case_who", dir = "desc")),
    labels = list("view_countries")),
  geo_links = list(list(
    display = "Countries_and_Territories",
    variable = "continent_code",
    cog_type = "cog_disp_filter",
    ref_level = "countries",
    type = "href"
  )),
  order = 3,
  case_fatality_max = 12,
  thumb = system.file("thumbs/global/who_regions.png", package = "casecountapp")
)

country_display <- build_casecount_display(
  app,
  sources = sources_country,
  ref_source = "WHO",
  name = "Countries and Territories",
  desc = paste0("Covid-19 cases and deaths by country - updated ", time_str),
  views = default_views(
    ref_source = "WHO",
    comp_sources = c("JHU", "ECDC"),
    entity_pl = "countries"),
  state = list(
    sort = list(trelliscopejs::sort_spec("cur_case_who", dir = "desc")),
    labels = list(), sidebar = 4),
  order = 4,
  case_fatality_max = 12,
  thumb = system.file("thumbs/global/countries.png", package = "casecountapp"),
  disclaimer = list(
    cols = 2,
    text = "<p>By using this dashboard, you are agreeing to its <a href='EIOS_COVID_Case_Count_Dashboard_Disclaimer.pdf' target='_blank'>Disclaimer and Terms of Use.</a></p><p>The Epidemic Intelligence from Open Sources (EIOS) is a collaborative effort across public health organisations to facilitate the early detection of and response to potential health threats using publicly available information. You can read more about EIOS <a href='https://www.who.int/eios' target='_blank' rel='noopener noreferrer'>here</a>.</p><p>This dashboard is not a comprehensive representation of all of the content that WHO and the EIOS community are aware of and assessing and is for general information only.</p>"
  )
)

# deploy_netlify(app, Sys.getenv("NETLIFY_APP_ID"))
