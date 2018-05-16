filter Test-NotEmpty {
    if ( $_ -and ($_ -isnot [string] -or $_ -notmatch '^\s*$') ) { $_ }
}