# Define base image
# FROM continuumio/miniconda3
FROM python:3.9-slim
 
# Set working directory for the project
WORKDIR /src/app
# WORKDIR /

# Make RUN commands use `bash --login`:
# SHELL ["/bin/bash", "--login", "-c"]
 
# Create Conda environment from the YAML file
# COPY environment.yml .
# RUN conda env create -f environment.yml
 
# Activate Conda environment and check if it is working properly
# RUN conda activate myenv

RUN pip3 install --upgrade pip

COPY /requirements.txt ./

COPY /.env ./

RUN pip install python-dotenv

RUN pip install --no-cache-dir -r  requirements.txt 

EXPOSE 8501

COPY /pages ./pages
COPY /user_utils.py ./
COPY /constants.py ./
COPY /modelsvm.pk1 ./
COPY /app.py ./

CMD streamlit run app.py --browser.serverAddress="0.0.0.0"
# CMD streamlit run /src/app.py