resource "cloudflare_record" "www" {
  zone_id = data.sops_file.cloudflare-secret.data["cloudflare.amrik.co.uk.zone_id"]
  name    = "www"
  value   = data.sops_file.cloudflare-secret.data["cloudflare.amrik.co.uk.ip"]
  type    = "A"
  proxied = true
}

resource "cloudflare_r2_bucket" "amrik-co-uk" {
  account_id = data.sops_file.cloudflare-secret.data["cloudflare.account_id"]
  name = "amrik-co-uk"
  location = "WEUR"
}
