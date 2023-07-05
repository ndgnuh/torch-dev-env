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
groupmod -g $HOSTGID dev
usermod dev -u $HOSTUID
exec sudo -u dev bash
