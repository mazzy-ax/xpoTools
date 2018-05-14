# xpoTools

[project]:https://github.com/mazzy-ax/xpoTools
[license]:https://github.com/mazzy-ax/xpoTools/blob/master/LICENSE
[ps]:https://www.powershellgallery.com/packages/xpoTools
[nuget]:https://www.nuget.org/packages/xpoTools/
[appveyor]:https://ci.appveyor.com/project/mazzy-ax/xpotools

[![Build status](https://ci.appveyor.com/api/projects/status/d8b8q8v0co9vukbv?svg=true)][appveyor]
[![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/xpoTools.svg)][ps]
[![NuGet](https://buildstats.info/nuget/xpoTools)][nuget]
<img src="https://raw.githubusercontent.com/mazzy-ax/xpoTools/master/media/AxAppl.ico" align="right" alt="xpoTools">

[xpoTools][project] is a Powershell module contains cmdlets that splits one XPO file into separate XPO files and combines a set of interdependent XPO files into a single XPO file.

XPO file is a text file contains Microsoft Dynamics AX (Axapta) objects. See [tests/assets](tests/assets) folder for example.

*xpoTools* features:

* convert jobs and classes `xpo` to `xpp` files (similar to `ax7`)
* create target folders by groups in developer projects, AOT objects path, object prefix, project names
* choose target folders structure by switch `pathStyle`: `Default`, `AOT`, `Flat`, `FlatAOT`, `Project`, `FlatProject`, `All` and `mazzy`
* define own target folders structure
* include and exclude files based on a file name. For example, to exclude `DEL_` objects
* filter AOT objects based on a text within XPO elements
* uses Encoding parameter

## Credits

*xpoTools* inspired by:

* [Combine XPO Tool](https://msdn.microsoft.com/ru-ru/library/jj225589.aspx)
* [AOTExportSeparated](https://github.com/DAXaholic/AOTExportSeparated) by [DAXaholic](https://github.com/DAXaholic)

## Installation

Automatic install *xpoTools* module from the [PowerShell Gallery][ps]:

```powershell
Install-Module -Name xpoTools
Import-Module xpoTools
```

Automatic install Write-ProgressEx module from the [NuGet.org][nuget]:

```powershell
Install-Package -Name xpoTools
Import-Module xpoTools
```

or manual:

* Download and unblock the latest .zip file.
* Extract the .zip into your `$PSModulePath`, e.g. `~\Documents\WindowsPowerShell\Modules`.
* Ensure the extracted folder is named `xpoTools`.
* Set an execution policy to `RemoteSigned` or `Unrestricted` to execute not signed modules `Set-ExecutionPolicy RemoteSigned`.
* Run `Import-Module xpoTools`.

## Changelog

* [CHANGELOG.md](CHANGELOG.md)
* <https://github.com/mazzy-ax/xpoTools/releases>.

## Disclaimer

*xpoTools* use regexp to parse XPO files. It have no validation of XPO elements.

## License

This project is released under the [licensed under the MIT License][license].

mazzy@mazzy.ru