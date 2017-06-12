# Systemd stuff
alias scu='systemctl --user'
alias scut='systemctl --user start'
alias scustat='systemctl --user list-units -a --type=service'
alias sld='systemctl --user list-dependencies'
alias sysu='systemctl --user'

# General ROS helpers
alias rosenv='env | grep ROS'
alias dcfg='rosrun rqt_reconfigure rqt_reconfigure'
alias cb='catkin build'
alias rnl='rosnode list'
alias rtl='rostopic list'
alias rti='rostopic info'

# Application-specific helpers
alias repro='rosservice call /Control/reprocess_playbook'
alias nextplay='rosservice call /Control/next_play'

function rni() {
	rosnode info "$@" | sed -n -e '1,/^Pid:/p'
}
