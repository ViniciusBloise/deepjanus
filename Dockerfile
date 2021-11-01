FROM python:2

LABEL maintainer vinicius.bloise@gmail.com

RUN	echo python 2 vbloise
RUN mkdir -p /venvs
RUN mkdir -p /usr/src/deepjanus

COPY ./requirements.txt ./venvs
WORKDIR /venvs

RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip install virtualenv
RUN python -m pip install flask
RUN virtualenv djenv

RUN . djenv/bin/activate

RUN apt-get update -y
RUN apt-cache madison gobject-introspection
RUN apt-get install -y libgirepository1.0-dev
RUN apt-get install -y gobject-introspection
RUN pip install --no-cache-dir -r /venvs/requirements.txt

WORKDIR /usr/src/deepjanus
COPY . .

CMD [". .djenv/bin/activate"]
WORKDIR ..
CMD ["bash"]