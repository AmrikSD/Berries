resource "cloudflare_r2_bucket" "amrik-co-uk" {
  account_id = data.sops_file.cloudflare-secret.data["cloudflare.account_id"]
  name       = "amrik-co-uk"
  location   = "WEUR"
}

resource "cloudflare_ruleset" "transform_url_rewrite" {
  zone_id     = data.sops_file.cloudflare-secret.data["cloudflare.amrik.co.uk.zone_id"]
  name        = "Transform Rule performing a static URL rewrite"
  description = ""
  kind        = "zone"
  phase       = "http_request_transform"

  rules {
    action = "rewrite"
    action_parameters {
      uri {
        path {
          value = "/index.html"
        }
      }
    }
    expression  = "((http.host eq \"amrik.co.uk\" or http.host eq \"www.amrik.co.uk\" ) and http.request.uri.path eq \"/\")"
    description = "Rewrite / to index.html"
    enabled     = true
  }
}
