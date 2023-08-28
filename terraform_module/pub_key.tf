# Create a new SSH key
resource "hcloud_ssh_key" "own_pubkey" {
  name       = "own_pubkey"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "hcloud_ssh_key" "doku_pubkey" {
  name       = "doku_pubkey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/7WVNHJg2ivaf5fah3WLlofZv7AS05472qgC5xirykVOs0ga3pQPLChiePpbYuztAVTc3J9RG7r5GuDLsag5GRXrTKjRomM+0sjGZRkymZOdF2jKACtiwWbA4adJYZ7zgAw0sh3TSuDlCxg8RDSjKaZkaBfkn6TRepT7XWrqBr9OiEFsN+DgW4eQqHxWLWCOZjjaEfQ3vrZ39XId/wgHSBKNv4YDM1Aag6FTVIkOQI2MLq/qCfvDGIRfECWZBIIngHx+AXJmEC/cwmHeRxgInvisRkfeuV6DlbHyXCgm5XCBzNaX4zZrN7NBcYgzFcHCqDgm3WO5/RhR513udEDZHb9UMyhtJQt8miJkcAZ8CLXmFB40R+PsKtdhD2AsHGN6xHKp5VH1BNJsiX4W4o3Y/nSytcnzF5NA0oOHmNNQbKDc+NKwAyhFIFX/701gRITIV2G7qWOQqKKryE+IGte8Bz+ehmPxA71dBRXHE2FFymeVTW8Z81QDBYTdapxXwvWnO4NHGGBlYwSa3phvkm53uOUTmBaFwKyR+8HSsfiJByTGDR2jqFUbvGygZmn8jgJc1V5MDssQud6Imxy3uV+eZN30H+MMQ704cjpGG+Pwak8J+2Ap3Fg4DC+nmTw2NwttL5UKLGcdB/N0Yly5tTOhAEV/XLLlfiyKuCEKWVE4Ibw=="
}