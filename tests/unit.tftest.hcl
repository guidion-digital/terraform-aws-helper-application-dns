run "application_dns" {
  module {
    source = "./examples/test_app"
  }

  command = plan

  variables {
    test_zones = {
      web = {
        zones = [
          "web.dev.guidion.io",
          "web.dev.guidion.com",
          "web.dev.afsprk.nl",
          "web.dev.afsprk.io"
        ]
        accounts = ["123456789012"]
      }
    }

  }

  # Nothing useful is knowable without an apply, and we don't want to test
  # an apply
  # assert {
  #   condition     =
  #   error_message =
  # }
}
