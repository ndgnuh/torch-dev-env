if [ -z $HOSTUID ]; then
	HOSTUID=$1
fi
if [ -z $HOSTUID ]; then
	HOSTUID=$UID
fi
if [ -z $HOSTUID ]; then
	HOSTUID=1000
fi
if [ -z $HOSTGID ]; then
	HOSTGID=$2
fi
if [ -z $HOSTGID ]; then
	HOSTGID=$GID
fi
if [ -z $HOSTGID ]; then
	HOSTGID=1000
fi

# Create dev user
groupadd -g $HOSTGID dev
useradd -u $HOSTUID -g $HOSTGID dev
for f in /etc/skel/.*; do
	bn=$(basename $f)
	if [ -f $f ]; then
		cp $f /home/dev/$bn
		chown dev:dev /home/dev/$bn
	fi
done
chown dev:dev /home/dev/

# EXTRA PATH AND COMMANDS
cat /opt/extra.bashrc | tee -a /home/dev/.bashrc > /dev/null
sed -i 's/#alias/alias/g' /home/dev/.bashrc > /dev/null

# ENTRYPOINT
cd /home/dev/working
exec sudo -u dev bash
