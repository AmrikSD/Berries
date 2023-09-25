resource "cloudflare_r2_bucket" "amrik-co-uk" {
  account_id = data.sops_file.cloudflare-secret.data["cloudflare.account_id"]
  name = "amrik-co-uk"
  location = "WEUR"
}
