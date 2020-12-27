FROM continuumio/miniconda3

# Create the environment:
COPY environment.yml .
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "r-invest", "/bin/bash", "-c"]

# Make sure the environment is activated:
# RUN echo "Make sure natcap.invest is installed:"
# RUN python -c "import natcap.invest"

# Add sample data
ADD setup.sh .
RUN \
  mkdir -p /data /workspace && \
  /bin/bash setup.sh

# The code to run when container is started:
ADD run-ndr.py /data
# ENTRYPOINT ["conda", "run", "-n", "r-invest", "python", "run-ndr.py"]
ENTRYPOINT ["conda", "run", "-n", "r-invest", "/bin/bash"]
