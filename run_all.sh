
#!/bin/bash

LOG="./pipeline.log"

fail(){
	local code="$1"
	local step="$2"
	echo "[$(date)] step=$step status=FAIL action=rollback" | tee -a "$LOG"
	./rollback.sh
	exit "$code"
}


success(){

	echo "[$(date)] step=pipeline status=OK" | tee -a "$LOG"
	cat version.txt > active_version.txt
	echo $(( $(cat version.txt) + 1 )) > version.txt
}


deploy(){

	echo "[$(date)] step=deploy status=START" >> "$LOG"

	if ./deploy.sh >> "$LOG" 2>&1; then
		echo "[$(date)] step=deploy status=OK" >> "$LOG"
	else
		fail 10 deploy
	fi
}

health_check(){

	echo "[$(date)] step=health_check status=START" >> "$LOG"
	if ./health_check.sh >> "$LOG" 2>&1; then
		echo "[$(date)] step=health_check status=OK" >> "$LOG"
	else
		fail 20 health_check
 	fi
  
}




	echo "[$(date)] step=pipeline status=START" >> "$LOG"
	deploy
	sleep 3
	health_check
	success

