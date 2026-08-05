$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$skillsRoot = if (Test-Path -LiteralPath (Join-Path $projectRoot 'skills')) {
    Join-Path $projectRoot 'skills'
} else {
    Join-Path $projectRoot 'distilled-skills'
}
$writerRoot = Join-Path $skillsRoot 'jk-ai-director-writer'
$directorRoot = Join-Path $skillsRoot 'jk-ai-director'

function Read-All([string]$root) {
    return (Get-ChildItem -LiteralPath $root -Recurse -File -Filter '*.md' |
        ForEach-Object { Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8 }) -join "`n"
}

function Assert-Contains([string]$name, [string]$text, [string[]]$patterns) {
    $missing = @($patterns | Where-Object { $text -notmatch [regex]::Escape($_) })
    if ($missing.Count -gt 0) {
        Write-Output "FAIL`t$name`tMissing: $($missing -join ', ')"
        $script:failed = $true
    } else {
        Write-Output "PASS`t$name"
    }
}

function Assert-NoMatch([string]$name, [string]$text, [string]$pattern) {
    if ($text -match $pattern) {
        Write-Output "FAIL`t$name`tForbidden match: $pattern"
        $script:failed = $true
    } else {
        Write-Output "PASS`t$name"
    }
}

function Assert-ReferencesExist([string]$root) {
    $skill = Get-Content -LiteralPath (Join-Path $root 'SKILL.md') -Raw -Encoding UTF8
    $matches = [regex]::Matches($skill, '\]\((references/[^)]+\.md)\)')
    $missing = @()
    foreach ($match in $matches) {
        $relative = $match.Groups[1].Value -replace '/', '\'
        if (-not (Test-Path -LiteralPath (Join-Path $root $relative))) { $missing += $relative }
    }
    if ($missing.Count -gt 0) {
        Write-Output "FAIL`tReferences: $root`tMissing: $($missing -join ', ')"
        $script:failed = $true
    } else {
        Write-Output "PASS`tReferences: $root"
    }
}

$failed = $false
$writer = Read-All $writerRoot
$director = Read-All $directorRoot

Assert-Contains 'Commercial ad writer contract' $writer @('品牌目标', '目标受众', '单一主张', '可证实', 'CTA', '合规')
Assert-Contains 'Genre writing library' $writer @('家庭/现实剧情', '喜剧/黑色幽默', '犯罪/悬疑', '科幻', '文学/作者表达', '商业传播')
Assert-Contains '30-90 and long-form calibration' $writer @('30–60 分钟', '60–90 分钟', '90–120 分钟', '三线账本', '中段重定向', '未结清清单')
Assert-Contains 'Long-series assets' $writer @('人物圣经', '世界与设定库', '时间线与关系状态', '信息与伏笔账本', '变更日志', '状态差异')
Assert-Contains 'Creator profile and first-view model' $writer @('positive_taste', '首次观看体验图', '观众知道', '当前预测', '重新理解', '对白轨', '场景文本轨')
Assert-Contains 'Three-track rhythm calibration' $writer @('三轨节奏校准', '对白轨', '动作轨', '场景文本轨', '不可并行部分相加', '可并行部分取较长者')
Assert-Contains 'Web movie route' $writer @('网大 / 网络电影', '周期性给予', '6–9 个序列')

Assert-Contains 'Director four axes' $director @('IMAGE / 画面', 'CAMERA / SPACE', 'INFORMATION / EMOTION', 'ACTION / WORLD')
Assert-Contains 'Information and world contracts' $director @('信息—情绪合同', '揭示前观众判断', '行动—世界合同', '世界阻力', '四轴互锁')
Assert-Contains 'Director style library' $director @('冷观察', '主观贴身', '精密秩序', '空间悬疑', '动作地理', '商业证明', '竖屏近场')
Assert-Contains 'Style fusion conflicts and weights' $director @('主方法 60–80%', '辅方法 20–40%', '强调方法 0–10%', '冲突矩阵', '不取中间值')
Assert-Contains 'Production route contracts' $director @('叙事短片', '竖屏剧情短剧', '商业广告 / 品牌片', '网大 / 中长片 / 长片', '系列 / 长剧集')
Assert-Contains 'Same-scene 4-15 second packaging' $director @('每条允许 4–15 秒', '目标 12–15 秒', '场景一变必须结束当前段', '交集为空')
Assert-Contains 'Execution handoff and retry loop' $director @('task_id', 'planned / ready / generated / approved / failed / retired', '八道文字交接闸门', '相同根因失败三次')
Assert-Contains 'Text-only director boundary' $director @('全部交付为文字', '不操作画布或生成平台', '不创建画布节点', '不消费算力', '不声称任务已提交或媒体已生成')

Assert-NoMatch 'No KL borrowing in writer skill' $writer 'KL-script-Visualizer'
Assert-NoMatch 'No KL borrowing in director skill' $director 'KL-script-Visualizer'
Assert-ReferencesExist $writerRoot
Assert-ReferencesExist $directorRoot

if ($failed) { exit 1 }
Write-Output 'ALL CONTRACT TESTS PASSED'

