#out_DIR is the directory where it has the results of chromosome 
outDIR="/ddn/home2/r2725/projects/jeannette/data/"
email="phillevn@gmail.com"

for i in {1..22};
        do
                cd ${outDIR}chr${i}_data/subset_chro${i}_AA_filtered
                        for string in *.R;
                                do
					if [ -f "${string:0:${#string}-2}.pbs" ]; then rm -r ${string:0:${#string}-2}.pbs; fi
					echo "#!/bin/bash" >> ${string:0:${#string}-2}.pbs
					echo "#PBS -N chr"${i}"A"${string:$((${#string}-8)):$((${#string}-6))} >> ${string:0:${#string}-2}.pbs
					echo "#PBS -j oe" >> ${string:0:${#string}-2}.pbs
					echo "#PBS -l select=1:ncpus=6:mem=24gb -l place=free" >> ${string:0:${#string}-2}.pbs

					echo "#PBS -m abe" >> ${string:0:${#string}-2}.pbs
					echo "#PBS -M "${email} >> ${string:0:${#string}-2}.pbs
					echo "cd ${PBS_O_WORKDIR}" >> ${string:0:${#string}-2}.pbs
					echo "module load gcc/9.2.0" >> ${string:0:${#string}-2}.pbs
					echo R --file=${outDIR}chr${i}_data/subset_chro${i}_AA_filtered/${string} >> ${string:0:${#string}-2}.pbs
                        done;
                cd ${outDIR}chr${i}_data/subset_chro${i}_EA_filtered
                        for string in *.R;
                                do
					if [ -f "${string:0:${#string}-2}.pbs" ]; then rm -r ${string:0:${#string}-2}.pbs; fi
                                        echo "#!/bin/bash" >> ${string:0:${#string}-2}.pbs
                                        echo "#PBS -N chr"$i"E"${string:$((${#string}-8)):$((${#string}-6))} >> ${string:0:${#string}-2}.pbs
                                        echo "#PBS -j oe" >> ${string:0:${#string}-2}.pbs
                                        echo "#PBS -l select=1:ncpus=6:mem=32gb -l place=free" >> ${string:0:${#string}-2}.pbs

                                        echo "#PBS -m abe" >> ${string:0:${#string}-2}.pbs
                                        echo "#PBS -M "${email} >> ${string:0:${#string}-2}.pbs
                                        echo "cd ${PBS_O_WORKDIR}" >> ${string:0:${#string}-2}.pbs
                                        echo "module load gcc/9.2.0" >> ${string:0:${#string}-2}.pbs
                                        echo R --file=${outDIR}chr${i}_data/subset_chro${i}_EA_filtered/${string} >> ${string:0:${#string}-2}.pbs
                        done;
done
