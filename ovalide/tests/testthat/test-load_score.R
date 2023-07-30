fs::dir_create("data/mco_dgf/")
fs::dir_create("data/psy_oqn/")
# withr::defer(fs::dir_delete("data"))

read_score_csv_file <- purrr::quietly(read_score_csv_file)
load_score          <- purrr::quietly(load_score)

test_that("charge fichier score champ mco", {
  nature <- nature("mco", "dgf")
  read_score_csv_file(testthat::test_path("test_data/mco_dgf.csv"),
                      nature)
  load_score(nature)
  expect_equal(ncol(the$mco_dgf_scores), 21)
})

test_that("charge fichier score champ psy", {
  nature <- nature("psy", "oqn")
  read_score_csv_file(testthat::test_path("test_data/psy_oqn.csv"),
                      nature)
  load_score(nature)
  expect_equal(ncol(the$psy_oqn_scores), 27)
})
