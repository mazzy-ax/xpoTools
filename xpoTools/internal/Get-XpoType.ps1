#Requires -Version 5
Set-StrictMode -Version Latest

$script:xpoTypeInfo = @(
    [xpoType]@{AOTpath = @('Classes'); OneLevelAOTPath ='Classes'; UtilType = 45; NodeType = 329; Tag = 'CLS'; FilePrefix = 'Class'; SubTag = ''}
    [xpoType]@{AOTpath = @('Data Dictionary', 'Base Enums'); OneLevelAOTPath ='Base Enums'; UtilType = 40; NodeType = 209; Tag = 'DBE'; FilePrefix = 'Enum'; SubTag = ''}
    [xpoType]@{AOTpath = @('Data Dictionary', 'Extended Data Types'); OneLevelAOTPath ='Extended Data Types'; UtilType = 41; NodeType = 228; Tag = 'UTE'; FilePrefix = 'ExtendedType'; SubTag = ''}
    [xpoType]@{AOTpath = @('Data Dictionary', 'Tables'); OneLevelAOTPath ='Tables'; UtilType = 44; NodeType = 204; Tag = 'DBT'; FilePrefix = 'Table'; SubTag = ''}
    [xpoType]@{AOTpath = @('Data Dictionary', 'Views'); OneLevelAOTPath ='Views'; UtilType = 44; NodeType = 243; Tag = 'VIE'; FilePrefix = 'ViewQuery'; SubTag = ''}
    [xpoType]@{AOTpath = @('Data Dictionary', 'Maps'); OneLevelAOTPath ='Maps'; UtilType = 44; NodeType = 236; Tag = 'MAP'; FilePrefix = 'TableMap'; SubTag = ''}
    [xpoType]@{AOTpath = @('Forms'); OneLevelAOTPath ='Forms'; UtilType = 11; NodeType = 201; Tag = 'FRM'; FilePrefix = 'Form'; SubTag = ''}
    [xpoType]@{AOTpath = @('Jobs'); OneLevelAOTPath ='Jobs'; UtilType = 5; NodeType = 215; Tag = 'JOB'; FilePrefix = 'Job'; SubTag = ''}
    [xpoType]@{AOTpath = @('Menu Items', 'Display'); OneLevelAOTPath ='Display Menu Items'; UtilType = 1; NodeType = 296; Tag = 'FTM'; FilePrefix = 'DisplayTool'; SubTag = '1'}
    [xpoType]@{AOTpath = @('Menu Items', 'Output'); OneLevelAOTPath ='Output Menu Items'; UtilType = 2; NodeType = 296; Tag = 'FTM'; FilePrefix = 'OutputTool'; SubTag = '2'}
    [xpoType]@{AOTpath = @('Menu Items', 'Action'); OneLevelAOTPath ='Action Menu Items'; UtilType = 3; NodeType = 296; Tag = 'FTM'; FilePrefix = 'ActionTool'; SubTag = '3'}
    [xpoType]@{AOTpath = @('Macros'); OneLevelAOTPath ='Macros'; UtilType = 4; NodeType = 218; Tag = 'MCR'; FilePrefix = 'Macro'; SubTag = ''}
    [xpoType]@{AOTpath = @('Menus'); OneLevelAOTPath ='Menus'; UtilType = 16; NodeType = 205; Tag = 'MNU'; FilePrefix = 'Menu'; SubTag = ''}
    [xpoType]@{AOTpath = @('Data Dictionary', 'Table Collections'); OneLevelAOTPath ='Table Collections'; UtilType = 48; NodeType = 211; Tag = 'TCL'; FilePrefix = 'TableCollection'; SubTag = ''}
    [xpoType]@{AOTpath = @('Queries'); OneLevelAOTPath ='Queries'; UtilType = 20; NodeType = 330; Tag = 'QUE'; FilePrefix = 'Query'; SubTag = ''}
    [xpoType]@{AOTpath = @('Shared Projects'); OneLevelAOTPath ='Shared Projects'; UtilType = 37; NodeType = 0; Tag = 'PRN'; FilePrefix = 'SharedProject'; SubTag = 'SHARED'}
    [xpoType]@{AOTpath = @('Private Projects'); OneLevelAOTPath ='Private Projects'; UtilType = 38; NodeType = 0; Tag = 'PRN'; FilePrefix = 'Private'; SubTag = 'PRIVATE'}
    [xpoType]@{AOTpath = @('References'); OneLevelAOTPath ='References'; UtilType = 53; NodeType = 822; Tag = 'REF'; FilePrefix = 'Reference'; SubTag = ''}
    [xpoType]@{AOTpath = @('Reports'); OneLevelAOTPath ='Reports'; UtilType = 18; NodeType = 202; Tag = 'RG' ; FilePrefix = 'Report'; SubTag = ''}
    [xpoType]@{AOTpath = @('Report Libraries'); OneLevelAOTPath ='Report Libraries'; UtilType = 79; NodeType = 1426; Tag = 'RLB' ; FilePrefix = 'ReportLibrary'; SubTag = ''}
    [xpoType]@{AOTpath = @('Reports', 'Section Templates'); OneLevelAOTPath ='Report Section Templates'; UtilType = 27; NodeType = 86; Tag = 'RST'; FilePrefix = 'ReportSectionTemplate'; SubTag = ''}
    [xpoType]@{AOTpath = @('Reports', 'Report Templates'); OneLevelAOTPath ='Report Templates'; UtilType = 19; NodeType = 90; Tag = 'RGT'; FilePrefix = 'ReportTemplate'; SubTag = ''}
    [xpoType]@{AOTpath = @('Resources'); OneLevelAOTPath ='Resources'; UtilType = 21; NodeType = 820; Tag = 'RES'; FilePrefix = 'Resource'; SubTag = ''}
    [xpoType]@{AOTpath = @('Data Dictionary', 'Configuration Keys'); OneLevelAOTPath ='Configuration Keys'; UtilType = 39; NodeType = 312; Tag = 'CON'; FilePrefix = 'ConfigurationKey'; SubTag = ''}
    [xpoType]@{AOTpath = @('Data Dictionary', 'Security Keys'); OneLevelAOTPath ='Security Keys'; UtilType = 36; NodeType = 313; Tag = 'SEC'; FilePrefix = 'SecurityKey'; SubTag = ''}
    [xpoType]@{AOTpath = @('Data Sets'); OneLevelAOTPath ='Data Sets'; UtilType = 72; NodeType = 207; Tag = 'DST'; FilePrefix = 'DataSet'; SubTag = ''}
    [xpoType]@{AOTpath = @('Data Dictionary', 'License Codes'); OneLevelAOTPath ='License Codes'; UtilType = 15; NodeType = 311; Tag = 'LIC'; FilePrefix = 'LicenseCode'; SubTag = ''}
    [xpoType]@{AOTpath = @('Data Dictionary', 'Perspectives'); OneLevelAOTPath ='Perspectives'; UtilType = 66; NodeType = 1311; Tag = 'PRS'; FilePrefix = 'Perspective'; SubTag = ''}
    [xpoType]@{AOTpath = @('Services'); OneLevelAOTPath ='Services'; UtilType = 76; NodeType = 1321; Tag = 'SVC'; FilePrefix = 'Service'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Menu Items', 'URL'); OneLevelAOTPath ='Web URL Items'; UtilType = 55; NodeType = 864; Tag = 'WMU'; FilePrefix = 'WebUrlItem'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Menu Items', 'Actions'); OneLevelAOTPath ='Web Action Menu Items'; UtilType = 56; NodeType = 866; Tag = 'WMA'; FilePrefix = 'WebActionItem'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Menus'); OneLevelAOTPath ='Web Menus'; UtilType = 30; NodeType = 806; Tag = 'WME'; FilePrefix = 'WebMenu'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Forms'); OneLevelAOTPath ='Web Forms'; UtilType = 34; NodeType = 800; Tag = 'WFM'; FilePrefix = 'WebForm'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Weblets'); OneLevelAOTPath ='Weblets'; UtilType = 59; NodeType = 873; Tag = 'WIT'; FilePrefix = 'WebletItem'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Modules'); OneLevelAOTPath ='Web Modules'; UtilType = 67; NodeType = 885; Tag = 'WML'; FilePrefix = 'WebModule'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Reports'); OneLevelAOTPath ='Web Reports'; UtilType = 52; NodeType = 203; Tag = 'WRG'; FilePrefix = 'WebReport'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Files', 'List Definitions'); OneLevelAOTPath ='Web List Definitions'; UtilType = 78; NodeType = 892; Tag = 'WLD'; FilePrefix = 'WebListDef'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Files', 'List Definitions'); OneLevelAOTPath ='Web Site Definitions'; UtilType = 61; NodeType = 877; Tag = 'WSD'; FilePrefix = 'WebSiteDef'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Files', 'Web Controls'); OneLevelAOTPath ='Web Controls'; UtilType = 73; NodeType = 887; Tag = 'WCL'; FilePrefix = 'WebControl'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Files', 'Page Definitions'); OneLevelAOTPath ='Web Page Definitions'; UtilType = 63; NodeType = 881; Tag = 'WPD'; FilePrefix = 'WebPageDef'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Files', 'Site templates'); OneLevelAOTPath ='Web Site Templates'; UtilType = 62; NodeType = 879; Tag = 'WPD'; FilePrefix = 'WebSiteTemp'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Web Content', 'Dispaly'); OneLevelAOTPath ='Web Display Content Items'; UtilType = 57; NodeType = 869; Tag = 'WCD'; FilePrefix = 'WebDisplayContentItem'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Web Content', 'Output'); OneLevelAOTPath ='Web Output Content Items'; UtilType = 58; NodeType = 871; Tag = 'WCO'; FilePrefix = 'WebOutputContentItem'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Web Content', 'Managed'); OneLevelAOTPath ='Web Managed Сontent Items'; UtilType = 75; NodeType = 890; Tag = 'WCM'; FilePrefix = 'WebManagedContentItem'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Web Content', 'Static Files'); OneLevelAOTPath ='Web Static Files'; UtilType = 64; NodeType = 883; Tag = 'WRF'; FilePrefix = 'WebStaticFile'; SubTag = ''}
    [xpoType]@{AOTpath = @('Web', 'Web Content', 'Web Parts'); OneLevelAOTPath ='Web Parts'; UtilType = 60; NodeType = 875; Tag = 'WWP'; FilePrefix = 'WebPart'; SubTag = ''}
    [xpoType]@{AOTpath = @('Workflow', 'Templates'); OneLevelAOTPath ='Workflow Templates'; UtilType = 68; NodeType = 1412; Tag = 'WFL'; FilePrefix = 'WorkflowTemplate'; SubTag = ''}
    [xpoType]@{AOTpath = @('Workflow', 'Tasks'); OneLevelAOTPath ='Workflow Tasks'; UtilType = 69; NodeType = 1417; Tag = 'WFT'; FilePrefix = 'WorkflowTask'; SubTag = ''}
    [xpoType]@{AOTpath = @('Workflow', 'Approvals'); OneLevelAOTPath ='Workflow Approvals'; UtilType = 70; NodeType = 1421; Tag = 'WFA'; FilePrefix = 'WorkflowApproval'; SubTag = ''}
    [xpoType]@{AOTpath = @('Workflow', 'Categories'); OneLevelAOTPath ='Workflow Categories'; UtilType = 71; NodeType = 1423; Tag = 'WFC'; FilePrefix = 'WorkflowCategory'; SubTag = ''}
    [xpoType]@{AOTpath = @('Help Files'); OneLevelAOTPath ='Help Files'; UtilType = 65; NodeType = 1301; Tag = 'HPF'; FilePrefix = 'HelpFile'; SubTag = ''}

    #ax30
    [xpoType]@{AOTpath = @('Data Dictionary', 'Feature keys'); OneLevelAOTPath ='Feature keys'; UtilType = 39; NodeType = 237; Tag = 'FСС'; FilePrefix = 'FeatureKey'; SubTag = ''}
    
)

function Get-XpoType {
    [CmdletBinding(DefaultParameterSetName = "NodeType")]
    [OutputType([xpoType])]
    param (
        [Parameter(Position = 0, ParameterSetName = "xpoItem", ValueFromPipeline)]
        [xpoItem]$xpoItem,

        [Parameter(Position = 0, ParameterSetName = "xpoNode", ValueFromPipeline)]
        [xpoNode]$xpoNode,

        [Parameter(Position = 0, ParameterSetName = "NodeType", ValueFromPipeline)]
        [int]$NodeType,

        [Parameter(Position = 0, ParameterSetName = "UtilType", ValueFromPipeline)]
        [int]$UtilType,

        [Parameter(Position = 0, ParameterSetName = "Tag", ValueFromPipeline)]
        [Parameter(Position = 0, ParameterSetName = "SubTag")]
        [string]$Tag,

        [Parameter(Position = 1, ParameterSetName = "SubTag")]
        [string]$SubTag
    )

    process {
        switch ($PSCmdlet.ParameterSetName) {
            'xpoItem' { $script:xpoTypeInfo | Where-Object { $_ -eq $xpoItem } | Select-Object -First 1 }
            'xpoNode' { $script:xpoTypeInfo | Where-Object { $_ -eq $xpoNode } | Select-Object -First 1 }
            'SubTag' { $script:xpoTypeInfo | Where-Object { ($_.Tag -EQ $Tag) -and ($_.SubTag -EQ $SubTag) } | Select-Object -First 1 }
            'Tag' { $script:xpoTypeInfo | Where-Object { $_.Tag -EQ $Tag } }
            'NodeType' { $script:xpoTypeInfo | Where-Object { $_.NodeType -EQ $NodeType } }
            'UtilType' { $script:xpoTypeInfo | Where-Object { $_.UtilType -EQ $UtilType } }
        }
    }
}
