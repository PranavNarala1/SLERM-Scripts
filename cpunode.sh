#!/bin/bash
#SBATCH --job-name=llama_inference       # Job name
#SBATCH --nodes=1                        # Number of nodes
#SBATCH --ntasks=1                       # Number of tasks (processes)
#SBATCH --cpus-per-task=4                # Number of CPUs per task
#SBATCH --mem=8GB                        # Memory per node
#SBATCH --time=00:15:00                  # Walltime (hh:mm:ss)
#SBATCH --output=cpu_output_%j.txt     # Output file (%j expands to jobID)

# Load necessary modules
module load gcc/10.2.0                   # Load GCC compiler module
module load cmake/3.18.4                 # Load CMake module

# Set working directory
cd $HOME/llama_inference

lscpu | grep "Model name"


# Navigate to the llama.cpp directory
cd llama.cpp

# Build the llama.cpp project
make clean
make

# Create a directory for models if it doesn't exist
mkdir -p models
cd models

# Download the Llama-3.2-1B-Q5_K_M-GGUF model
MODEL_URL="https://huggingface.co/littlekeivon/Llama-3.2-1B-Q5_K_M-GGUF/resolve/main/llama-3.2-1b-q5_k_m.gguf"
MODEL_NAME="littlekeivon_Llama-3.2-1B-Q5_K_M-GGUF_llama-3.2-1b-q5_k_m.gguf"
if [ ! -f "$MODEL_NAME" ]; then
    wget $MODEL_URL -O $MODEL_NAME
fi

# Navigate back to the llama.cpp directory
cd ..

# Run the model with a specified prompt
./main -m models/$MODEL_NAME -p "Hello, how are you?"
