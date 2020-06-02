#!/bin/bash
#SBATCH --mail-user=cole.zmurchok@vanderbilt.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=12
#SBATCH --time=3-00:00:00
#SBATCH --mem=16G

# Sets the anaconda3 package
module load Anaconda3

# Runs the program
python adaptive_parallel.py
