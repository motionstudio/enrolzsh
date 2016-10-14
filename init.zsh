# Init Helper Functions
#

# https://github.com/robbyrussell/oh-my-zsh/wiki/Coding-style-guide

_enrol_current-path() {
	result=${PWD##*/}
	echo $result
}

# Load shell script for project
# Param: $1 = prefix
# Param: $2 = absolute dir
#
# Will be introduced later:
# For more security add encrypted file to VCS with .enc ending, remove deploy.zsh or config.yml from VCS
# Add encrypt and decrypt command to shell
_enrol_load() {
	# Get shorthand from config
	# CONFIG_FILE=deploy/deploy.zsh

	# Check if cache exist
	if [ -f $ER_CACHE/$1.zsh ]; then
		echo "$1 loaded"
		source $ER_CACHE/$1.zsh
	# Caching will be introduced later
	# Create cache when not existing and project path given
	#elif [ -n "$2" ]; then
	#	echo "Create cache $1"
	# Can't load global functions - just load project scripts
	else
		echo "It's not possible to load the functionality of the ZSH-Plugin"
		echo "Instead, we just load the project functionalities."
	fi

	# Load zsh config from current project
	_enrol_inherit_script $2

}

# Load script in project folder when existing
# Param: $1 = absolute dir
_enrol_inherit_script() {

	# Make sure to be in right project
	if [ -n "$1" ]; then
		eval cd $1

		if [ $? -eq 0 ]; then
		    echo "Directory changed"
		else
		    return
		fi
	fi

	# Look inside deploy folder
	DEPLOY_FILE=enrol/deploy.zsh

	# Check if file is available
	if [ -f $DEPLOY_FILE ]; then
		# Main script at the time
		# Should be just for overrides or extensions later
		source $DEPLOY_FILE
	    echo "File found in PROJECT/enrol/deploy.zsh"
		echo "Project script is loaded and availble in the shell"
	else
		echo "No file found in PROJECT/enrol/deploy.zsh"
		#echo "Use the default script"
	fi
	echo "Current project: $(_enrol_current-path)"

}

# Autoload projects defined in global settings
_enrol_autoload() {

	# Load all projects that are defined in $ER/.enrolzsh_global
	for prefix ($ER_AUTOLOAD); do

		eval _enrol_load $prefix \$$prefix

	done

	# Go back to project dir and not inside last loaded project
	eval cd $ER_PROJECT_DIR
}

# Not tested yet - cache isn't used at all
# Create local cache
# Param: $1 = current project prefix
_enrol_create_cache() {

	# Check if argument exist
	if [[ $# == 0 ]]; then
		echo 'Please add a the project prefix as first argument';
	fi

	# When file already exists - ask what to do
	if [ -f $ER_CACHE/$1.zsh ]; then

		echo "Cache already exists for current project."
		read "?Press ↵ to generate new one, abort with ⌃C"

		# Delete current cache
		rm $ER_CACHE/$1.zsh
	fi

	# Copy template
	cat $ER/template/tools.zsh > $ER_CACHE/$1.zsh
	echo 'File copied from template'

	# Replace PREFIX values with actual project prefix
	sed -i '' 's/\PREFIX/'"$1"'/g' $ER_CACHE/$1.zsh
	echo 'Content replaced with correct prefix'

}