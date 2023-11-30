#!/bin/sh
# Creates a .Net 7.0 Blazor project with TailwindCSS

# If creating a new Blazor project from scratch
if [ $# -gt 0 ]; then
    # If the directory exists, cd into it, otherwise create it
	if [ -e "$1" ]; then
		cd "$1"
		if [ ! -e "$1".csproj ] ; then
			dotnet new blazorwasm-empty
		fi
	else
        # Create the directory and cd into it
		mkdir "$1"
		cd "$1"
		dotnet new blazorwasm-empty
	fi
else
    # If the directory is empty, create a new Blazor project
    if [ -z "$(ls -A .)" ]; then
        dotnet new blazorwasm-empty
    fi
fi

# If the project is a Blazor project
if [  -e *.csproj  ]; then
    # Does the tailwind config exist, if not install tailwindcss
    if [ ! -e ./tailwind.config.js ] ; then
        echo "Installing tailwindcss"
        npm install -D tailwindcss
        npx tailwindcss init
        sed -i "s/content: \[\],/content: \['.\/\*\*\/\*{razor,html,cshtml}'],/" ./tailwind.config.js
    fi

    # Create the base classes
    if [ ! -e ./Styles/app.css ] ; then
        echo "Creating Styles/app.css"
        if [ ! -e ./Styles ] ; then
            mkdir ./Styles
        fi
        
        echo "@tailwind base;\n@tailwind components;\n@tailwind utilities;\n" > ./Styles/app.css
    fi

    # Modify index.html to include the tailwind css
    if [ -e ./wwwroot/index.html ] ; then
        echo "Modifying index.html"
        cd wwwroot
        #sed '/<link href="css\/app.css" rel="stylesheet" \/>/a <link rel="stylesheet" href="css\/tailwind.css" />' index.html > temp.html && mv temp.html index.html
        #sed '/<link rel="stylesheet" href="css\/app.css" \/>/a <link rel="stylesheet" href="css\/tailwind.css" />' index.html > temp.html && mv temp.html index.html
        sed -i 's/href="css\/app.css"/href="css\/tailwind.css"/' index.html
        sed -i 's/<div id="app">/<div id="app" class="h-screen w-screen flex item-center justify-center">/g' index.html
        cd ..
    fi

    # Create a small shell script that starts npx
    if [ ! -e ./starttwcss.sh ] ; then
        echo "Creating starttwcss.sh"
        echo "npx tailwindcss -i Styles/app.css -o wwwroot/css/tailwind.css --watch" > starttwcss.sh
        chmod +x starttwcss.sh
    fi
else
    echo "This is not a Blazor project"
fi