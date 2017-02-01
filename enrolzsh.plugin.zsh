# EnrolZSH - ZSH-Plugin
#
version="0.2";

enrol() {
	# When there's no argument
	if [[ $# == 0 ]]; then
		echo 'Thanks for using EnrolZSH';
	fi

	# Help screen
	if [[ $1 == "--help" || $1 == "help" || $1 == "-h" ]]; then
		echo "EnrolZSH Help: Read our readme at https://github.com/motionstudio/enrolzsh";
	fi

	# Show version
	if [[ $1 == "--version" || $1 == "version" || $1 == "-v" ]]; then
		echo "EnrolZSH - $version";
	fi

	# Check and maybe run update
	if [[ $1 == "--update" || $1 == "update" ]]; then
		echo "Update EnrolZSH via Git";
		cd $ER
	 	git pull
	 	eval cd $ER_PROJECT_DIR
	fi

}

# Store current dir
CURRENT_DIR=$(pwd)

# Constant
ER=${0:a:h}
ER_CACHE=$ER/cache

# Includes
source $ER/.enrolzsh_global

source $ER/helper.zsh
source $ER/init.zsh
source $ER/vagrant.zsh
source $ER/config.zsh

# Init
_enrol_autoload >& /dev/null # don't return anything

# Load shortcode of every dir and add custom config
# Lazyload projects and don't add alias because of better overview
enrol.projects() {
	projects=(~/Projects/public/*/) # Hardcoded - variable doesn't work yet
	#projects=($ER_PROJECT_DIR/*/)
	echo "The following aliases are created (enrol.PROJECT):"
	for project in "${projects[@]}"; do
		project=${project%/} # Remove slash (/)
		project_alias=${project%.*} # Remove TTD (.xx)
		echo "- "${project_alias##*/}
		alias "enrol."${project_alias##*/}="cd '${project//\'/\'\\\'\'}' && _enrol_load ${project_alias##*/} ${project//\'/\'\\\'\'}"
	done
}

# Restore current dir
cd $CURRENT_DIR