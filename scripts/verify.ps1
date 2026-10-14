param([switch]$CaptureScreenshots)
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path -Parent $PSScriptRoot
Push-Location -LiteralPath $projectRoot
try {
    if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
        throw 'Flutter bulunamadı. Flutter SDK bin klasörünü PATH içine ekleyin.'
    }
    function Invoke-FlutterCheck {
        param([string[]]$FlutterArguments)
        & flutter @FlutterArguments
        if ($LASTEXITCODE -ne 0) {
            throw ('Flutter komutu başarısız: flutter ' + ($FlutterArguments -join ' '))
        }
    }
    Invoke-FlutterCheck -FlutterArguments @('--version')
    Invoke-FlutterCheck -FlutterArguments @('pub', 'get')
    Invoke-FlutterCheck -FlutterArguments @('analyze')
    Invoke-FlutterCheck -FlutterArguments @('test')
    if ($CaptureScreenshots) {
        Invoke-FlutterCheck -FlutterArguments @('test', '--update-goldens', '--dart-define=CAPTURE_SCREENSHOTS=true', 'test/store_flow_test.dart')
        foreach ($screen in @('home', 'catalog', 'detail', 'cart')) {
            $imagePath = Join-Path $projectRoot ('docs/screenshots/' + $screen + '.png')
            if (-not (Test-Path -LiteralPath $imagePath)) {
                throw ('Ekran görüntüsü üretilemedi: ' + $imagePath)
            }
        }
        Write-Host 'Dört ekran görüntüsü docs/screenshots klasörüne kaydedildi.'
    }
    Write-Host 'Analiz ve testler başarılı.'
} finally {
    Pop-Location
}
