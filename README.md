# [xpoTools](https://github.com/mazzy-ax/xpoTools)

![version](https://img.shields.io/badge/version-1.0.0-green.svg) ![license](https://img.shields.io/badge/license-MIT-blue.svg)

**xpoTools** is a Powershell module contains cmdlets that splits one XPO file into separate XPO files and combines a set of set of interdependent XPO files into a single XPO file.

XPO file is a text file contains Microsoft Dynamics AX (Axapta) objects. See [tests/assets](tests/assets) folder for example.

*xpoTooles* features:

* convert jobs and classes `xpo` to `xpp` files (similar to `ax7`)
* create target folders by groups in developer projects, AOT objects path, object prefix, project names
* choose target folders structure by switch `pathStyle`
* define own target folders structure
* include and exclude files based on a file name. For example, to exclude `DEL_` objects
* filter AOT objects based on a text within XPO elements
* uses Encoding parameter
* It have designed for parallel processing. See [examples/parallel-split.ps1](examples/parallel-split.ps1) folder.

## Thanks

*xpoTools* inspired by:

* [Combine XPO Tool](https://msdn.microsoft.com/ru-ru/library/jj225589.aspx)
* [AOTExportSeparated](https://github.com/DAXaholic/AOTExportSeparated) by [DAXaholic](https://github.com/DAXaholic)

## Installation

Automatic install *xpoTools* module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/xpoTools):

```powershell
Install-Module -Name xpoTools
Import-Module xpoTools
```

Automatic install Write-ProgressEx module from the [NuGet.org](https://www.nuget.org/packages/xpoTools):

```powershell
Install-Package -Name xpoTools
Import-Module xpoTools
```

or manual:

* Download and unblock the latest .zip file.
* Extract the .zip into your $PSModulePath, e.g. ~\Documents\WindowsPowerShell\Modules.
* Ensure the extracted folder is named `xpoTools`.
* Set an execution policy to RemoteSigned or Unrestricted to execute not signed modules `Set-ExecutionPolicy RemoteSigned`.
* Run `Import-Module Write-ProgressEx`.

## Changelog

* [CHANGELOG.md](CHANGELOG.md)
* [https://github.com/mazzy-ax/xpoTools/releases](https://github.com/mazzy-ax/xpoTools/releases).

## Disclaimer

*xpoTools* use regexp to parse XPO files. It have no validation of XPO elements.

## License

This project is [licensed under the MIT License](LICENSE).

mazzy@mazzy.ru