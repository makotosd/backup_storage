#!/bin/bash
#
#
# fstab
#UUID="CEF8630AF862F05F" /mnt/HD-LXU3  ntfs-3g defaults,nofail 0       0
#UUID="023CFDD53CFDC427" /mnt/HD-LCU3  ntfs-3g defaults,nofail 0       0
#UUID="7C7A5CA47A5C5D48" /mnt/HD-LBFU2 ntfs-3g defaults,noauto,nofail 0       0
#UUID="8C00633E00632F00" /mnt/HD-CLU2  ntfs-3g defaults,noauto,nofail 0       0
#UUID="0C444D68444D559C" /mnt/IO-DATA  ntfs-3g defaults,noauto,nofail 0       0

# all log go to log file.
logfilename=/home/pi/script/backup_storage/log.`date +"%Y%m%d"`
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>$logfilename 2>&1

#RSYNC='/usr/bin/rsync -avh --dry-run '
RSYNC='/usr/bin/rsync -avh'

src_tst="/mnt/HD-LXU3/storage/My Pictures_test/"
src_pic="/mnt/HD-LXU3/storage/My Pictures/"
src_vid="/mnt/HD-LXU3/storage/My Video/"
src_M="/mnt/HD-LXU3/storage/Makoto/"
src_a="/mnt/HD-LXU3/storage/Ayaka/"
src_dvd="/mnt/HD-LBFU2/storage/DVD/"
src_dvd2="/mnt/HD-LBFU2/storage/DVD2/"
src_mus="/mnt/HD-LBFU2/storage/Music/"
src_mov="/mnt/HD-LBFU2/storage/MOV/"

dst_tst="/mnt/HD-LCU3/backup/My Pictures_test/"
dst_pic="/mnt/HD-LCU3/backup/My Pictures/"
dst_vid="/mnt/HD-LCU3/backup/My Video/"
dst_M="/mnt/HD-LCU3/backup/Makoto/"
dst_a="/mnt/HD-LCU3/backup/Ayaka/" 
dst_dvd="/mnt/HD-CLU2/backup/DVD/"
dst_dvd2="/mnt/HD-CLU2/backup/DVD2/"
dst_mus="/mnt/HD-CLU2/backup/Music/"
dst_mov="/mnt/IO-DATA/backup/MOV/"

function do_backup () {
  src=$1
  dst=$2
  echo "############################################"
  echo ";; src: $src"
  echo ";; dst: $dst"
  cmd="$RSYNC \"$src\" \"$dst\""
  echo ";; cmd: $cmd"

  if [ ! -d "$src" ] ; then echo "no src"; return; fi
  if [ ! -d "$dst" ] ; then echo "no dst"; return; fi 

  eval ${cmd}
}

#do_backup "$src_tst"  "$dst_tst"
do_backup "$src_pic"  "$dst_pic"
do_backup "$src_vid"  "$dst_vid"
do_backup "$src_M"    "$dst_M"
do_backup "$src_a"    "$dst_a"
do_backup "$src_dvd"  "$dst_dvd"
do_backup "$src_dvd2" "$dst_dvd2"
do_backup "$src_mus"  "$dst_mus"
do_backup "$src_mov"  "$dst_mov"
