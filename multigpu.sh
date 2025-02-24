#!/bin/bash
#SBATCH --job-name=llama_inference_multiGPU
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gres=gpu:2                # Request 2 GPUs on one node
#SBATCH --cpus-per-task=4           # CPU cores to support GPU tasks
#SBATCH --mem=32G                   # System RAM
#SBATCH --time=01:00:00             # hh:mm:ss
#SBATCH --output=llama_output_%j.txt

# 1. Load necessary modules (adjust for your cluster)
module load gcc/10.2.0
module load cmake/3.18.4
module load cuda/11.7                # or whatever CUDA version you need

# 2. Move into the llama-cli directory
cd $HOME/llama-cli

# 3. Run llama-cli with multi-GPU parameters
#    -m: Path to your model
#    --gpu-layers / --gpu-split: optional multi-GPU usage flags (example)
./build/bin/llama-cli \
    -m "$HOME/littlekeivon_Llama-3.2-1B-Q5_K_M-GGUF_llama-3.2-1b-q5_k_m.gguf" \
    -p "Hi, tell me a story" \
    --gpu-layers 30 \
    --gpu-split 1,1
