#!/bin/bash
#SBATCH --job-name=llama_inference_h200     # Job name
#SBATCH --partition=glu-h200                # Partition that has H200 GPUs (example name)
#SBATCH --nodes=1                           # Number of nodes
#SBATCH --ntasks=1                          # Number of tasks (processes)
#SBATCH --gres=gpu:1                        # Request 1 GPU (H200)
#SBATCH --cpus-per-task=4                   # CPU cores to support GPU tasks
#SBATCH --mem=32G                           # System RAM
#SBATCH --time=01:00:00                     # hh:mm:ss
#SBATCH --output=llama_output_%j.txt        # Output file (%j expands to jobID)

# 1. Load necessary modules (adjust for your cluster)
module load gcc/10.2.0
module load cmake/3.18.4
module load cuda/11.7                     # Example: Load CUDA for GPU support

# 2. Move into the llama-cli directory
cd $HOME/llama-cli

# 3. Run llama-cli (single GPU usage, so no multi-GPU flags)
./build/bin/llama-cli \
    -m "$HOME/littlekeivon_Llama-3.2-1B-Q5_K_M-GGUF_llama-3.2-1b-q5_k_m.gguf" \
    -p "Hello, how are you?"
