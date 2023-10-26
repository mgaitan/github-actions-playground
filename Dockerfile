FROM python:3.11-slim as base


FROM base as requirements-download
ARG REQUIREMENTS="requirements.txt"
# Install python requirements
COPY ${REQUIREMENTS} /tmp/
# this will generate the cache at /root/.cache/pip
RUN pip install -r /tmp/${REQUIREMENTS} && pip cache info && pip cache list

# before to build the final image we'll copy to an external volume 

FROM base as requirements-cached
ARG REQUIREMENTS="requirements.txt"
# Install python requirements
COPY ${REQUIREMENTS} /tmp/
RUN --mount=type=bind,source=./.pip_cache,target=/root/.cache/pip pip cache info && pip cache list && pip install -r /tmp/${REQUIREMENTS} 


FROM requirements-cached as final
EXPOSE 8080 4444
