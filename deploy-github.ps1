# Eenmalig: gh auth login
# Daarna dit script uitvoeren in PowerShell vanuit deze map.

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

gh auth status | Out-Null

$repoName = "campus-spoor-kanban"
$existing = git remote get-url origin 2>$null
if (-not $existing) {
  gh repo create $repoName --public --source=. --remote=origin --description "Kanbanbord Waar knelt het schoentje - Campus Het Spoor"
  git push -u origin main
} else {
  git push -u origin main
}

$owner = (gh api user -q .login)
Write-Host "Repo: https://github.com/$owner/$repoName"

# GitHub Pages via Actions (workflow staat in .github/workflows/pages.yml)
gh api "repos/$owner/$repoName/pages" -X POST -f build_type=workflow 2>$null

Write-Host ""
Write-Host "Live preview (kan 1-2 minuten duren na eerste deploy):"
Write-Host "https://$owner.github.io/$repoName/"
