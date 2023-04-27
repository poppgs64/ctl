# ctl
Linux BASH command line util for displaying info about/managing processes
ctl can be used to show information about running processes such as the pid, number of open files, memory usage, etc.

# Examples
Here is an example showing VSCode running on my workstation

```
$ sudo ctl show code

---------- /usr/share/code/code ------
  PID       :   1392562
  MEM USAGE :   38584316 Kb (Virt) 173376 Kb (Phys)
  CREATED   :   27-Feb-23 04:38:56
  ACTIVATED :   Tue Apr 25 06:53:47 2023
Tue Apr 25 06:53:47 2023
Tue Apr 25 06:53:47 2023
Tue Apr 25 06:53:47 2023
Tue Apr 25 06:53:48 2023
Tue Apr 25 06:53:48 2023
Tue Apr 25 06:53:51 2023
Tue Apr 25 06:53:52 2023
Tue Apr 25 13:52:59 2023
Tue Apr 25 13:52:59 2023
Tue Apr 25 13:53:05 2023
Tue Apr 25 13:53:09 2023
Wed Apr 26 07:36:28 2023
Thu Apr 27 13:30:15 2023
  USER      :   gpopp
  OPEN FILES:   155
  THREADS   :   31
  STATE     :   Sleeping (SLsl)
```
Here's an example showing pulseaudio. Note that the open file count is not avail. This is because I didn't use `sudo` and had no access to that info.
```
$ ./ctl show pulseaudio

---------- /usr/bin/pulseaudio ------
  PID       :   1970
  MEM USAGE :   1238796 Kb (Virt) 4016 Kb (Phys)
  CREATED   :   21-Sep-20 23:30:20
  ACTIVATED :   Fri Feb 10 15:30:18 2023
Mon Apr 24 14:27:10 2023
  USER      :   gdm
  OPEN FILES:   Unavailable
  THREADS   :   3
  STATE     :   Sleeping (Ssl)
```
Here's the same command using sudo and alsow showing open files (by using the command line parameter 'f')
```
sudo ./ctl show pulseaudio f

---------- /usr/bin/pulseaudio ------
  PID       :   1970
  MEM USAGE :   1238796 Kb (Virt) 4016 Kb (Phys)
  CREATED   :   21-Sep-20 23:30:20
  ACTIVATED :   Fri Feb 10 15:30:18 2023
Mon Apr 24 14:27:10 2023
  USER      :   gdm
  OPEN FILES:   35
  THREADS   :   3
  STATE     :   Sleeping (Ssl)
total 0
lr-x------ 1 64 Apr 27 14:57 0 -> /dev/null
lrwx------ 1 64 Apr 27 14:57 1 -> 'socket:[34660]'
lrwx------ 1 64 Apr 27 14:57 10 -> 'socket:[35879]'
lrwx------ 1 64 Apr 27 14:57 11 -> 'socket:[35882]'
lrwx------ 1 64 Apr 27 14:57 12 -> /var/lib/gdm3/.config/pulse/a5e3cc945409425bae71cd63c1c7b2d3-device-volumes.tdb
lrwx------ 1 64 Apr 27 14:57 13 -> /var/lib/gdm3/.config/pulse/a5e3cc945409425bae71cd63c1c7b2d3-stream-volumes.tdb
lrwx------ 1 64 Apr 27 14:57 14 -> /var/lib/gdm3/.config/pulse/a5e3cc945409425bae71cd63c1c7b2d3-card-database.tdb
lr-x------ 1 64 Apr 27 14:57 15 -> anon_inode:inotify
lrwx------ 1 64 Apr 27 14:57 16 -> 'socket:[35077]'
lrwx------ 1 64 Apr 27 14:57 17 -> 'socket:[36150]'
lr-x------ 1 64 Apr 27 14:57 18 -> 'pipe:[35080]'
lrwx------ 1 64 Apr 27 14:57 19 -> 'anon_inode:[eventfd]'
lrwx------ 1 64 Apr 27 14:57 2 -> 'socket:[34660]'
lrwx------ 1 64 Apr 27 14:57 20 -> 'anon_inode:[eventfd]'
lrwx------ 1 64 Apr 27 14:57 21 -> 'anon_inode:[eventfd]'
lrwx------ 1 64 Apr 27 14:57 22 -> 'anon_inode:[eventfd]'
lr-x------ 1 64 Apr 27 14:57 23 -> anon_inode:inotify
lrwx------ 1 64 Apr 27 14:57 24 -> 'anon_inode:[eventfd]'
lrwx------ 1 64 Apr 27 14:57 25 -> 'anon_inode:[eventfd]'
lrwx------ 1 64 Apr 27 14:57 26 -> 'anon_inode:[eventfd]'
lrwx------ 1 64 Apr 27 14:57 27 -> 'anon_inode:[eventfd]'
lrwx------ 1 64 Apr 27 14:57 28 -> 'anon_inode:[eventfd]'
lrwx------ 1 64 Apr 27 14:57 29 -> 'anon_inode:[eventfd]'
lrwx------ 1 64 Apr 27 14:57 3 -> 'socket:[32104]'
lrwx------ 1 64 Apr 27 14:57 30 -> 'socket:[36571]'
lrwx------ 1 64 Apr 27 14:57 32 -> 'anon_inode:[eventfd]'
lrwx------ 1 64 Apr 27 14:57 33 -> 'anon_inode:[eventfd]'
lrwx------ 1 64 Apr 27 14:57 34 -> 'anon_inode:[eventfd]'
lrwx------ 1 64 Apr 27 14:57 35 -> 'anon_inode:[eventfd]'
lr-x------ 1 64 Apr 27 14:57 4 -> 'pipe:[35072]'
l-wx------ 1 64 Apr 27 14:57 5 -> 'pipe:[35072]'
lrwx------ 1 64 Apr 27 14:57 6 -> '/memfd:pulseaudio (deleted)'
lr-x------ 1 64 Apr 27 14:57 7 -> anon_inode:inotify
lr-x------ 1 64 Apr 27 14:57 8 -> 'pipe:[35074]'
l-wx------ 1 64 Apr 27 14:57 9 -> 'pipe:[35074]'
```
