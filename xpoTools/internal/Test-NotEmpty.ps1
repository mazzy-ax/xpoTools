#Requires -Version 5
Set-StrictMode -Version Latest

filter Test-NotEmpty {
    if ( $_ -and $_ -notmatch '^\s*$' ) { $_ }
}