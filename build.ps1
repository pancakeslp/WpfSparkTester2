
## if this fails you may want to run AS ADMIN
## `  powershell Set-ExecutionPolicy RemoteSigned  `
## if that doesnt work try 
## `  powershell Set-ExecutionPolicy Unrestricted  `

## exit on first error
$ErrorActionPreference = "Stop"

## Path for MSBuild.exe
$env:Path += ";C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\amd64\"

################################
################################

function build-msbuild {

  echo "msbuild-ing"
      
  MSBuild.exe WpfSparkTester2\WpfSparkTester2.csproj -p:Configuration=Release    
    

  if ( $LASTEXITCODE -ne 0) {
    echo "msbuild failed"
    exit $LASTEXITCODE 
  }

  echo "msbuild done"
}


function cleanup {
  remove WpfSparkTester2\bin\
  remove WpfSparkTester2\obj\
}

function dependencies-nuget {
  nuget install WpfSparkTester2\packages.config -OutputDirectory packages
  error-on-bad-return-code	
}


function error-on-bad-return-code {
  if ( $LASTEXITCODE -ne 0) {
    echo "error-on-bad-return-code!"
    exit $LASTEXITCODE 
  }
}


function nuget {
  build-bin\nuget.exe $args
}

function remove {
  $FILE_NAME = $args[0]

  if (Test-Path $FILE_NAME) {
    Remove-Item -Recurse $FILE_NAME
  }
}


################################
################################


cleanup

dependencies-nuget

build-msbuild

