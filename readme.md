# NYU Shanghai GPU-enabled Jupyter Notebook Environment User Manual

**Author: Hongyi Li (hl2752@nyu.edu)**


---
## Part One: Installation

***Caveat: Before installation, make sure that you have at least 7 GB of disk quota in your home directory.***

1. connect to the server via ssh

    ```bash
    $ ssh [your netID]@hpc.shanghai.nyu.edu
    ```

2. create a new directory in your home directory using the following command:

    ```bash
    $ mkdir ~/jupyter
    ```

3. acquire the installation script using this command:

    ```bash
    $ cp ~/../hl2752/hongyi/install_env.sh ~/jupyter/
    ```

4. run the installation script using this command:

    ```bash
    $ ~/jupyter/install_env.sh
    ```

---
## Part Two: Using the Virutal Environment

1. connect to the server via ssh and go to the jupyter directory

    ```bash
    $ ssh [your netID]@hpc.shanghai.nyu.edu
    $ cd ~/jupyter
    ```

2. use `sbatch` to submit your script to the HPC
	
	1. If you have access to the aquila partition, you can use the GPU environment

        ```bash
        $ sbatch jupyter-gpu.sh
        ```

    2. If you do not need GPU

        ```bash
        $ sbatch jupyter-cpu.sh
        ```

        Keep record of the job ID it returns, e.g.

        ```bash
        [hl2752@login2 jupyter]$ sbatch jupyter-gpu.sh 
        Submitted batch job 2126151 <—— ***this is your jobID***
        ```

3. Keep running the following command:
   
    ```bash
    $ cat output-*.txt
    ```

    Until you see something like this:

    ```
    /var/spool/slurmd/job2126151/slurm_script: line 17: nvidia-smi: command not found


    Paste ssh command in a terminal on local host (i.e., laptop)
    ------------------------------------------------------------
    ssh -N -L 9365:10.214.97.19:9365 hl2752@hpc.shanghai.nyu.edu <—— ***run this command***

    Open this address in a browser on local host; see token below
    ------------------------------------------------------------
    localhost:9365                                      


    [I 11:21:52.373 NotebookApp] Writing notebook server cookie secret to /gpfsnyu/home/zl3870/.local/share/jupyter/runtime/notebook_cookie_secret
    [I 11:22:14.347 NotebookApp] JupyterLab extension loaded from /gpfsnyu/packages/anaconda3/5.2.0/lib/python3.6/site-packages/jupyterlab
    [I 11:22:14.347 NotebookApp] JupyterLab application directory is /gpfsnyu/packages/anaconda3/5.2.0/share/jupyter/lab
    [I 11:22:14.351 NotebookApp] Serving notebooks from local directory: /gpfsnyu/home/zl3870/jupyter
    [I 11:22:14.351 NotebookApp] The Jupyter Notebook is running at:
    [I 11:22:14.351 NotebookApp] http://10.214.97.19:9365/?token=980c01948d8f76bb56943d24d0c8c897c957f1b142961768
    [I 11:22:14.351 NotebookApp]  or http://127.0.0.1:9365/?token=980c01948d8f76bb56943d24d0c8c897c957f1b142961768
    [I 11:22:14.351 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
    [C 11:22:14.377 NotebookApp] 
        
        To access the notebook, open this file in a browser:
            file:///gpfsnyu/home/zl3870/.local/share/jupyter/runtime/nbserver-3349-open.html
        Or copy and paste one of these URLs:
            http://10.214.97.19:9365/?token=980c01948d8f76bb56943d24d0c8c897c957f1b142961768
        or http://127.0.0.1:9365/?token=980c01948d8f76bb56943d24d0c8c897c957f1b142961768 <—— ***this is your token!***
    ```

4. open a new terminal, and run the command given in 3.

5. open a browser and go to localhost:xxxx (which is the port number given in the command)

6. enter the token given in 3.

7. now you may play with your notebooks.

8. When you are done, run this following command

    ```bash
    $ ~/jupyter/cleanup.sh [yourJobID] #given in 2.
    ```

---
## Part Three: Installing New Packages to your Environment

1. connect to the server via ssh and go to the jupyter directory
   
    ```bash
    $ ssh [your netID]@hpc.shanghai.nyu.edu
    $ cd ~/jupyter
    ```
2. run the following command to activate your virtual environment
   
    ```bash
    $ module load anaconda3
    $ source activate ./torch_env
    ```

3. Now you may use pip/conda to install packages to your environment. **Note that the changes you make to the environment are permanent**.

---
## Part Four: If Your Notebook Require Network Request

Some python script requires network requests to load dataset and etc. However, the computation node in HPC do not necessarily provide Internet connection. Therefore, you have to do the networking part in your access node. Here is how:

1. connect to the server via ssh and go to the jupyter directory
   
    ```bash
    $ ssh [your netID]@hpc.shanghai.nyu.edu
    $ cd ~/jupyter
    ```

2. run the following command to start a jupyter server on your access node

    ```bash
    $ bash jupyter-cpu.sh &> output.txt &
    ```

3. Keep running the following command:

    ```bash
    $ cat output.txt
    ```

    Until you see something like this:

    ```
    /var/spool/slurmd/job2126151/slurm_script: line 17: nvidia-smi: command not found


    Paste ssh command in a terminal on local host (i.e., laptop)
    ------------------------------------------------------------
    ssh -N -L 9365:10.214.97.19:9365 hl2752@hpc.shanghai.nyu.edu <—— ***run this command***

    Open this address in a browser on local host; see token below
    ------------------------------------------------------------
    localhost:9365                                      


    [I 11:21:52.373 NotebookApp] Writing notebook server cookie secret to /gpfsnyu/home/zl3870/.local/share/jupyter/runtime/notebook_cookie_secret
    [I 11:22:14.347 NotebookApp] JupyterLab extension loaded from /gpfsnyu/packages/anaconda3/5.2.0/lib/python3.6/site-packages/jupyterlab
    [I 11:22:14.347 NotebookApp] JupyterLab application directory is /gpfsnyu/packages/anaconda3/5.2.0/share/jupyter/lab
    [I 11:22:14.351 NotebookApp] Serving notebooks from local directory: /gpfsnyu/home/zl3870/jupyter
    [I 11:22:14.351 NotebookApp] The Jupyter Notebook is running at:
    [I 11:22:14.351 NotebookApp] http://10.214.97.19:9365/?token=980c01948d8f76bb56943d24d0c8c897c957f1b142961768
    [I 11:22:14.351 NotebookApp]  or http://127.0.0.1:9365/?token=980c01948d8f76bb56943d24d0c8c897c957f1b142961768
    [I 11:22:14.351 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
    [C 11:22:14.377 NotebookApp] 
        
        To access the notebook, open this file in a browser:
            file:///gpfsnyu/home/zl3870/.local/share/jupyter/runtime/nbserver-3349-open.html
        Or copy and paste one of these URLs:
            http://10.214.97.19:9365/?token=980c01948d8f76bb56943d24d0c8c897c957f1b142961768
        or http://127.0.0.1:9365/?token=980c01948d8f76bb56943d24d0c8c897c957f1b142961768 <—— ***this is your token!***
    ```


4. open a new terminal, and run the command given in 3.

5. open a browser and go to localhost:xxxx (which is the port number given in the command)

6. enter the token given in 3.

7. now you may do the networking codes in your notebooks.

8. When you are done, run this following command

    ```bash
    $ fg
    ^C
    ```
