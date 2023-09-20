<div align="center">

<img src="https://camo.githubusercontent.com/5b298bf6b0596795602bd771c5bddbb963e83e0f/68747470733a2f2f692e696d6775722e636f6d2f7031527a586a512e706e67" align="center" width="144px" height="144px"/>

### My home operations repository :octocat:

_... managed with Flux, Renovate and GitHub Actions_ 🤖

</div>

## 🫐 Overview

This is a mono repository for my home infrastructure and Kubernetes cluster.
I try to adhere to Infrastructure as Code (IaC) and GitOps practices using the tools like [Ansible](https://www.ansible.com/), [Terraform](https://www.terraform.io/), [Kubernetes](https://kubernetes.io/), [Flux](https://github.com/fluxcd/flux2), [Renovate](https://github.com/renovatebot/renovate) and [GitHub Actions](https://github.com/features/actions).

---


If you're stumbled upon this somehow looking for inspiration for your own home lab, check out https://github.com/onedr0p/home-ops/tree/main or https://discord.com/invite/k8s-at-home first, those guys know a LOT more than me ;)


## 💩 Amrik.co.uk & 🥴 Amrik.de

Amrik.de and Amrik.co.uk are two of my websites, they're both statically generated and hosted in some kind of object store, more details below in their specific sections.

### 💩 Amrik.co.uk 

[Amrik.co.uk](https://github.com/AmrikSD/amrik.co.uk/) is my personal blog, it's currently under construction but the plan is to host it similarly to amrik.de, as static html/css/js. I want to experiment with using more IaC for this website so I will aim to have everything in code using Terraform (or OpenTofu :joy:). I also want to experiment with using R2 and cloudflare rather than only aws products.


### 🥴 Amrik.de

[Amrik.de](https://github.com/AmrikSD/Amrik.de/) is the blog I created before I could get the .co.uk TLD domain name.

I've written about the architecture for amrik.de in the past, you can read that [here](https://amrik.de/projects/meta/2021/03/03/amrik-dot-de.html). The TL;DR is that it's a Jekyll website that's hosted in s3 behind CloudFront & Route53, updated by Github actions.
