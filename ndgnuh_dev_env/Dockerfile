FROM python:3.11-slim-bookworm

# Torch first
RUN pip install -U pip
RUN pip install torch==2.1.1 torchvision torchaudio torchtext

# Fix TZData Hang
# RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get update && apt-get -y install tzdata

# Intall debian packages
RUN <<EOR
	apt-get update
	# For privilledged command
	apt-get install -y sudo xclip
	# for video /image stuffs
	apt-get install -y ffmpeg python3-opencv v4l2loopback-dkms
	# system utilities
	apt-get install -y htop tree curl wget git entr tmux
	# clean up
	apt-get clean
    rm /var/lib/apt/lists/ -rf
EOR

# Install python packages
COPY requirements.txt /tmp/requirements.txt
RUN pip install -U -r /tmp/requirements.txt
RUN rm /tmp/requirements.txt
RUN pip cache purge

# Create user and allow sudo to all
RUN mkdir /tmp/bootstrap
COPY extra.bashrc /opt/extra.bashrc
RUN echo 'ALL ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers
COPY ./entrypoint.sh /opt/entrypoint.sh
ENV TERM=xterm-256color
ENTRYPOINT /opt/entrypoint.sh
