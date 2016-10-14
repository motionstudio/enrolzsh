# EnrolZSH - ZSH-Plugin
#
version="0.1";

enrol() {
	# When there's no argument
	if [[ $# == 0 ]]; then
		echo 'Thanks for using EnrolZSH';
	fi

	# Help screen
	if [[ $1 == "--help" || $1 == "help" || $1 == "-h" ]]; then
		echo "EnrolZSH Help: Please read our readme at github.com/";
	fi

	# Show version
	if [[ $1 == "--version" || $1 == "version" || $1 == "-v" ]]; then
		echo "EnrolZSH - $version";
	fi

	# Check and maybe run update
	if [[ $1 == "--update" || $1 == "update" ]]; then
		echo "Update EnrolZSH";
		#git pull
	fi

}

# Constant
ER=${0:a:h}
ER_CACHE=$ER/cache

# Includes
source $ER/.enrolzsh_global

#source $ER/helper.zsh
source $ER/init.zsh
source $ER/vagrant.zsh

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