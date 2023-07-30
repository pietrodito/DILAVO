test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

n <- nature("mco", "dgf")
load_ovalide_tables(n)
format_quality_table(n, finess = "020000022")

#the$mco_dgf_ovalide$T1Q0QSYNTH_1
