FROM python:3.11-slim-bookworm

# Torch first
RUN pip install -U pip
RUN pip install torch torchvision torchaudio torchtext

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

# Create dev user and allow sudo to all
RUN useradd -m dev -u 1001
RUN echo 'ALL ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers
RUN mkdir /home/dev/working -p
RUN chown dev:dev /home/dev/working

# EXTRA PATH AND COMMANDS
COPY extra.bashrc /tmp
RUN cat /tmp/extra.bashrc | tee -a /home/dev/.bashrc
RUN rm /tmp/extra.bashrc
RUN sed -i 's/#alias/alias/g' /home/dev/.bashrc
RUN chown dev:dev /home/dev/.bashrc

# ENTRYPOINT
WORKDIR /home/dev/working
COPY ./entrypoint.sh /opt/entrypoint.sh
ENV TERM=xterm-256color
ENTRYPOINT /opt/entrypoint.sh
