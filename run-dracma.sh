config=./path.config
pathDracma=""
if test -f "$config"; then
    echo "Getting from..."
    pathDracma=$(cat $config)
else
    read -p "Enter with Dracma path:" configString
    echo $configString >> $config
    pathDracma=$(cat $config)
fi

if [ "" == "$pathDracma" ]; then
    echo "Dracma path not defined, exiting program..."
    exit 1
fi

projects=""
branch=""
runAll=false

while getopts "p:b:al" option; do
      case $option in
        l)
          cd $pathDracma
          echo $(ls)
          exit 0
          ;;
        a)
          runAll=true
          ;;
        p)
          projects="$OPTARG, $projects"
          ;;
        b)
          branch="$OPTARG"
          ;;
        *)
          echo "Usage: $0 [-p project_name] [-b branch]"
          exit 1
        ;;
    esac
done

echo "Running projects: $projects on branch $branch"

export IFS=", "

if [ "" == "$projects" ]; then
  if [ $runAll == true ]; then
    if test -f "./all.config"; then
      echo "Loading projects from all.config"
    else
      echo "You should configure a all.config file to run with -a flag"
      exit 1
    fi 
    projects=$(cat ./all.config);
  else
    if test -f "./default.config"; then
      echo "Loading projects from default.config"
    else
      echo "You should configure a default.config file to run without args"
      exit 1
    fi
    projects=$(cat ./default.config);
  fi
fi

for project in $projects; do
  currProjectPath=$pathDracma\\$project\\$project
  if [ "Financial.GUI" == $project ]; then
    currProjectPath=$pathDracma\\$project
  fi
  cd $currProjectPath;
  if [ "" != "$branch" ]; then
    git fetch;
    git checkout $branch;
    git pull origin $branch;
  fi
  ext=".csproj"
  if test -f $currProjectPath\\$project.fsproj; then
    ext=".fsproj"
  fi
  if [ "Financial.GUI" == $project ]; then
    wt -w 0 nt --title ${project#"Financial."} PowerShell npm start --prefix $currProjectPath
  else
    dotnet build;
    wt -w 0 nt --title ${project#"Financial."} PowerShell dotnet  run --project $currProjectPath\\$project$ext;
  fi
done

exit 0