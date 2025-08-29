#!/bin/bash

#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
#SBATCH --partition=compute         # your default and only available partition - do not change
#SBATCH --ntasks=48 				# it will not run without this line -- make sure ntasks and 
									# number of cores in your run line below match!!!!!!!!!!!!!

module load openmpi
module load lammps

echo "Hello World"

pip install pandas
pip install ase

for i in {1..10}; do
	echo "This is repetition number $i"

	python3 python_automation.py Si_SiO2.in

	export OMP_NUM_THREADS=2
	mpiexec --oversubscribe -np 48 lmp -in Si_SiO2.in

done