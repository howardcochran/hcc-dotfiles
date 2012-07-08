#!/bin/bash

opt_dest_dir=/d/bak/sys/digit
opt_date=`date +%F`   # YYYY-MM-DD
opt_dry_run=0
start_time=`date +%s` # Seconds since the epoch

if [ "$1" == "--dry-run" -o "$1" == "-n" ] ; then
    opt_dry_run=1
    echo "Dry-run.  Dar commands will be skipped"
    shift
fi

# If argv[1] set, then use it. Otherwise use default
if [ -n "$1" ] ; then
    opt_dest_dir=$1
fi

if [ ! \( -d "$opt_dest_dir" -a -w "$opt_dest_dir" \)  ] ; then
    echo "Not a writeable directory: $opt_dest_dir" 1>&2
    exit 1
fi

[[ `df /` =~ /dev/mapper/(.*)-([^[:space:]]*) ]]
if [ $? -ne 0 ] ; then
    echo "Cannot determine mountpoint of root filesystem /." 1>&2
    exit 1
fi
root_vg=${BASH_REMATCH[1]}
root_lv=${BASH_REMATCH[2]}
echo $Using Root volgroup: $root_vg  logical volume: "${root_lv}"

[[ `df /home` =~ /dev/mapper/(.*)-([[:alnum:]_-]*) ]]
if [ $? -ne 0 ] ; then
    echo "Cannot determine mountpoint of home filesystem /." 1>&2
    exit 1
fi
home_vg=${BASH_REMATCH[1]}
home_lv=${BASH_REMATCH[2]}
echo $Using Home volgroup: $home_vg  logical volume: "${home_lv}"

sudo echo Sudo OK 
if [ $? -ne 0 ] ; then
    echo Cannot sudo
    exit 1
fi

sudo lvdisplay $root_vg/${root_lv}_snapbak 2>/dev/null
if [ $? -ne 5 ] ; then
    echo "Error: Backup snapshot already exists: $root_vg/${root_lv}_snapbak"
    exit 1
fi

sudo lvdisplay $home_vg/${home_lv}_snapbak 2>/dev/null
if [ $? -ne 5 ] ; then
    echo "Error: Backup snapshot already exists: $home_vg/${home_lv}_snapbak"
    exit 1
fi

# Backup LVM configuration.  Must go through temp file because root does
# not have permission to write to NFS volume (typical destination)
sudo rm /tmp/vgcfgbackup
sudo vgcfgbackup -f /tmp/vgcfgbackup
sudo chown hcochran:hcochran /tmp/vgcfgbackup
cp /tmp/vgcfgbackup $opt_dest_dir/${opt_date}-vgcfgbackup

echo sudo lvcreate --size 200m --snapshot --name ${root_lv}_snapbak $root_vg/$root_lv
sudo lvcreate --size 200m --snapshot --name ${root_lv}_snapbak $root_vg/$root_lv
if [ $? -ne 0 ] ; then
    echo "Cannot create snapshot $root_vg/$root_lv"
    exit 1
fi

sudo lvcreate --size 200m --snapshot --name ${home_lv}_snapbak $home_vg/$home_lv
if [ $? -ne 0 ] ; then
    echo "Cannot create snapshot $home_vg/$home_lv"
    exit 1
fi

sudo mkdir -p /media/root_snapbak
sudo mkdir -p /media/home_snapbak
sudo mount -o ro /dev/$root_vg/${root_lv}_snapbak /media/root_snapbak
sudo mount -o ro /dev/$root_vg/${home_lv}_snapbak /media/home_snapbak

# Note: We have to make dar write to stdout then pipe it to a cat owned
# by hcochran to write to the real file because the NFS server through
# when we make backups squashes root, preventing dar from writing directly.

echo "[Backing up boot]"
sudo mount -o remount,ro /boot
if [ $opt_dry_run -eq 0 ]; then
    sudo dar --create - --fs-root /boot -z3 | \
	cat > $opt_dest_dir/${opt_date}-boot-full.1.dar
fi
sudo mount -o remount,rw /boot

echo "[Backing up root]"
if [ $opt_dry_run -eq 0 ]; then
    sudo dar --create - --fs-root /media/root_snapbak -z3 |
        cat > $opt_dest_dir/${opt_date}-${root_vg}-${root_lv}-full.1.dar
fi
echo "[Backing up home]"
if [ $opt_dry_run -eq 0 ]; then
    sudo dar --create - --fs-root /media/home_snapbak -z3 |
        cat > $opt_dest_dir/${opt_date}-${home_vg}-${home_lv}-full.1.dar
fi

sudo umount /media/root_snapbak
sudo umount /media/home_snapbak

# Note: --force really means "don't ask for confirmation"
sudo lvremove --force $root_vg/${root_lv}_snapbak
sudo lvremove --force $root_vg/${home_lv}_snapbak

elapsed=$(( `date +%s` - $start_time ))
echo ${opt_date} > $opt_dest_dir/last_full_date_${root_vg}-${root_lv}_${home_vg}-${home_lv}.txt
echo Finished Full Backup.  Elapsed time: $elapsed sec
touch $opt_dest_dir/backups_log.txt
echo Full Backup Complete $opt_date. Elapsed time: $elapsed sec \
    >> $opt_dest_dir/backup_log.txt


