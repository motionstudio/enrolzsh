# Some useful Helper Commands
#

enrol.helper.finder() { eval open . }

# Reload zsh config - important after adjusting global config
enrol.reload() {
	source ~/.zshrc
}

# Return to base path - set in global config (ER_PROJECT_DIR)
enrol.base() {
	eval cd $ER_PROJECT_DIR
}