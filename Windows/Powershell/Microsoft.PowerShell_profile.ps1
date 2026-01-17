Import-Module posh-git
Set-PSReadLineOption -PredictionSource History
Set-PSReadlineKeyHandler -Key "Tab" -Function MenuComplete
Set-PSReadlineKeyHandler -Key "UpArrow" -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key "DownArrow" -Function HistorySearchForward
Set-PSReadLineOption -Colors @{ InlinePrediction = '#898c5b'}
Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PSReadLineKeyHandler -Key "RightArrow" -ScriptBlock {
       param($key, $arg)

       $line = $null
       $cursor = $null
       [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

       if ($cursor -lt $line.Length) {
           [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
       } else {
           [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord($key, $arg)
       }
}

Set-PSReadLineKeyHandler -Key End -ScriptBlock {
       param($key, $arg)

       $line = $null
       $cursor = $null
       [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

       if ($cursor -lt $line.Length) {
           [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine($key, $arg)
       } else {
           [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion($key, $arg)
       }
}

Register-ArgumentCompleter -Native -CommandName aws -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
        $env:COMP_LINE=$wordToComplete
        if ($env:COMP_LINE.Length -lt $cursorPosition){
            $env:COMP_LINE=$env:COMP_LINE + " "
        }
        $env:COMP_POINT=$cursorPosition
        aws_completer.exe | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
        Remove-Item Env:\COMP_LINE     
        Remove-Item Env:\COMP_POINT  
}

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\robbyrussell.omp.json" | iex
iex (& { (zoxide init powershell | Out-String) })

Remove-Alias -Name cd -Scope Global
Set-Alias -Name cd -Value z -Scope Global