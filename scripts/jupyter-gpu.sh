#!/bin/bash
#SBATCH -p aquila
#SBATCH -n1
#SBATCH -N1
#SBATCH -t 10:00:00
#SBATCH --mem=16GB
#SBATCH --job-name jupyter_gpu
#SBATCH --output output-%J.txt
#SBATCH -e output-%J.txt
#SBATCH --mail-type=ALL
#SBATCH --gres=gpu:1

module purge

module load anaconda3
source activate ./torch_env

nvidia-smi

XDG_RUNTIME_DIR=""
ipnport=$(shuf -i8000-9999 -n1)
ipnip=$(hostname -i)



echo -e "\n"
echo    "  Paste ssh command in a terminal on local host (i.e., laptop)"
echo    "  ------------------------------------------------------------"
echo -e "  ssh -N -L $ipnport:$ipnip:$ipnport $USER@hpc.shanghai.nyu.edu\n"
echo    "  Open this address in a browser on local host; see token below"
echo    "  ------------------------------------------------------------"
echo -e "  localhost:$ipnport                                      \n\n"

./torch_env/bin/jupyter-notebook --no-browser --port=$ipnport --ip=$ipnip
