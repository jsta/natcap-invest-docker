FROM continuumio/miniconda3

RUN apt-get update \
    && apt-get install -y \
    libgdal-dev \
    build-essential \
    vim \
    unzip

# Create the environment:
COPY environment.yml .
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "r-invest", "/bin/bash", "-c"]

# Make sure the environment is activated:
RUN echo "Make sure natcap.invest is installed:"
RUN python -c "import natcap.invest"

# Add sample data
COPY setup.sh .
RUN \
  mkdir -p /data /workspace && \
  mkdir /data/NDR && \
  /bin/bash setup.sh

# The code to run when container is started:
ADD run-ndr.py /data
ENTRYPOINT ["conda", "run", "-n", "r-invest", "python", "data/run-ndr.py"]
# ENTRYPOINT ["conda", "run", "-n", "r-invest", "/bin/bash"]
