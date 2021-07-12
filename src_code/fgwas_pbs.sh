dat_DIR="/ddn/home2/r2725/projects/jeannette/data/"

for i in {1..1};
        do
                cd ${dat_DIR}chr${i}_data/subset_chro${i}_AA_filtered
                        for string in *.pbs;
                                do
					qsub $string
                        done;
                cd ${dat_DIR}chr${i}_data/subset_chro${i}_EA_filtered
                        for string in *.pbs;
                                do
					qsub $string

                        done;
done
