$ErrorActionPreference = "Stop"

$repo = "saboorsarem/saboorsarem.github.io"
$rows = gh api "repos/$repo/releases?per_page=100" --jq '.[] | [.tag_name, .published_at, ((.assets | map(.download_count) | add) // 0)] | @tsv'

$total = 0
foreach ($row in $rows) {
    $tag, $date, $count = $row -split "`t"
    $total += [int]$count
    "{0,-14} {1,-12} {2,6} downloads" -f $tag, ($date -replace "T.*", ""), $count
}

""
"total: $total"
