﻿####################################################################################################
# Install prerequisites:
####################################################################################################
winget install -s winget -e --id "Microsoft.PowerShell"
winget install -s winget -e --id "Microsoft.Bicep"

Install-Module -Name 'Az' -Repository PSGallery -Force
Install-Module -Name 'PSRule.Rules.Azure' -Repository PSGallery -Scope CurrentUser

# The file ps-rule.yaml contains the configuration that will be used by PSRule
# By default, PSRule will automatically look for a default YAML options file in the current working directory.
# Alternatively, you can specify a specific file path with `-Option'

# report summary of all PsRule.Rules.Azure checks
Invoke-PSRule -Format 'File' -InputPath './infra/' -Outcome 'Processed' -As 'Summary' -Option './infra/ps-rule.yaml'

# report detail of all PsRule.Rules.Azure checks
Invoke-PSRule -Format 'File' -InputPath './infra/' -Outcome 'Fail, Error' -As 'Detail' -Option './infra/ps-rule.yaml'

# report detail of all PsRule.Rules.Azure checks with formatting
Assert-PSRule -Format 'File' -InputPath './infra/' -Outcome 'Fail, Error' -Option './infra/ps-rule.yaml'

# Note: Invoke-PSRule and Assert-PSRule are the same except for the output format
# * Invoke-PSRule writes results as structured objects
# * Assert-PSRule writes results as a formatted string