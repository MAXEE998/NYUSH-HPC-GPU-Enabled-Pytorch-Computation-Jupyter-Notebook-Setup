echo -e '\e[35;1m NYU Shanghai HPC Jupyter Installer Script\e[0m'
echo -e '\e[35;1m Author: Hongyi Li (hl2752@nyu.edu)\e[0m'

echo -e '\e[35;1m-----------------------------------------------------\e[0m'

echo -e '\e[37;1m Copying necessary files...\e[0m'
cp ~/../hl2752/hongyi/spec-list.txt .
cp ~/../hl2752/hongyi/pytorch_*_test.ipynb .
cp ~/../hl2752/hongyi/jupyter-*.sh .
cp ~/../hl2752/hongyi/cleanup.sh .

echo -e '\e[37;1m Loading anaconda3...\e[0m'
module load anaconda3

echo -e '\e[37;1m Creating virtual environment...\e[0m'
conda create --prefix ./torch_env --file spec-list.txt
