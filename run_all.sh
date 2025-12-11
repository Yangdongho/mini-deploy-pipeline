#!/bin/bash


LOG="./pipeline.log"

echo "pipeline start" >> $LOG

if ./deploy.sh >> $LOG 2>&1; then
	
	echo "[`date`] deploy success" >> $LOG
	if ./health_check.sh; then

		echo "[`date`] health_check  success" >> $LOG
		echo "[`date`] pipeline all success" | tee -a >> $LOG
	else
		echo "[`date`] healch_check failed" | tee -a >> $LOG
		exit 1	
	fi

else
	
	echo "[`date`] deploy failed" | tee -a >> $LOG
	exit 1

fi

