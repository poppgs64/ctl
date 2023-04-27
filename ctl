#!/bin/bash
#
# CTL - control and display info about applications on a Linux machine
#

function showHelp() {
      echo "usage: ctl <operation> <application> <options>"
      echo "where <operation> can be:"
      echo "    start          Start (run) the application"
      echo "    stop           Stop the application"
      echo "    restart        restart the application."
      echo "    kill           Terminate the application ungracefully"
      echo "    show           Display status of operation"
      echo "    status         Same as show"
      echo "    help           Display this help"
}

function showProcess() {
      # First, get the pid,thread count, virtmem, phsymem, user, status and cmd of the process
      pidcmd=($(ps -C "$app" -o pid=,nlwp=,vsz=,rss=,user=,stat=,cmd= ))
      # Now get the start-up time in long format
      starttime=$(ps -C "$app" -o lstart=)
      # Grab salient pieces of the ps output
      PID=${pidcmd[0]}
      thr=${pidcmd[1]}
      virtmem=${pidcmd[2]}
      physmem=${pidcmd[3]}
      usr=${pidcmd[4]}
      state=${pidcmd[5]}
      tsk=${pidcmd[6]}
      # Do we have a pid? If not, process is down
      if [ -n "$PID" ] ; then
         finfo=($(ls -go  --time-style="+%d-%b-%y %H:%M:%S" $tsk))
         CDATE=${finfo[3]}
         CTIME=${finfo[4]}
         echo ""
         echo "---------- $tsk ------"
         echo "  PID       :   $PID"
         echo "  MEM USAGE :   $virtmem Kb (Virt) $physmem Kb (Phys)"
         echo "  CREATED   :   $CDATE $CTIME "
         echo "  ACTIVATED :   $starttime"
         echo "  USER      :   $usr"
         fcount="Unavailable";
         if [ "$ctlusr" = "root" ];
         then
            flinks=(`ls /proc/$PID/fd`)
            fcount=${#flinks[*]}
         fi
         echo "  OPEN FILES:   $fcount"
         echo "  THREADS   :   $thr"
         s1=${state:0:1}
         case "$s1" in
            I) fstate="Idle" ;;
            S) fstate="Sleeping" ;;
            R) fstate="Run" ;;
            T) fstate="Stopped" ;;
            U) fstate="LWait" ;;
            Z) fstate="Zombie" ;;
         esac
         echo "  STATE     :   $fstate ($state)"
         # if third parameter is "f"  show open files:
         if [ "$opt" = "f" ];
         then
            if [ "$ctlusr" = "root" ];
            then
               ls -og /proc/$PID/fd
            else
               echo "Open file list unavailable"
            fi
         fi
         echo ""
      else
         echo "$app is not running"
      fi
}

# kill a process by name
function killProcess() {
   # Get the pid of the process
   PID=$(ps -C "$app" -o pid= )
   if [ -n "$PID" ];
   then
      echo "kill -9 $PID"
      if [ $ctlusr = "root" ];
      then
         kill -9 $PID
      else
         sudo kill -9 $PID
      fi
   else
      echo "$app is not running"
   fi
}

#
# Main
#
cmd=$1
app=$2
opt=$3
ctlusr=$(whoami)
case "$cmd" in
   "" | help)
      # Try and give help to the poor user
      showHelp
      ;;

   sho*)
      # The 'show' command
      # Display info on a running process
      showProcess
      ;;

   kill)
      killProcess
      ;;
   *)
      systemctl ${cmd} ${app}
      ;;
esac
