for i in {21..22}; 
	do
		cd /ddn/home2/r2725/projects/jeannette/data/chr${i}_data/subset_chro${i}_AA_filtered
			for string in *.bed; 
				do 
				echo "library(fGWAS)" >> ${string:0:${#string}-4}.R
				echo "library(tidyverse)" >> ${string:0:${#string}-4}.R
				echo file.plink.bed_AA = \"/ddn/home2/r2725/projects/jeannette/data/chr${i}_data/subset_chro${i}_AA_filtered/${string}\" >> ${string:0:${#string}-4}.R
				echo file.plink.bim_AA = \"/ddn/home2/r2725/projects/jeannette/data/chr${i}_data/subset_chro${i}_AA_filtered/${string:0:${#string}-4}.bim\" >> ${string:0:${#string}-4}.R
				echo file.plink.fam_AA = \"/ddn/home2/r2725/projects/jeannette/data/chr${i}_data/subset_chro${i}_AA_filtered/${string:0:${#string}-4}.fam\" >> ${string:0:${#string}-4}.R
				echo 'obj.gen_AA <- fg.load.plink( file.plink.bed_AA, file.plink.bim_AA, file.plink.fam_AA, plink.command="/ddn/home2/r2725/apps/plink/plink1.9/plink")' >> ${string:0:${#string}-4}.R
				echo 'file.phe.long_AA <- "/ddn/home2/r2725/projects/jeannette/data/file.phe.long_early_AA.csv"' >> ${string:0:${#string}-4}.R
				echo 'file.phe.time_AA <- "/ddn/home2/r2725/projects/jeannette/data/file.phe.time_early_AA.csv"' >> ${string:0:${#string}-4}.R
				echo 'file.phe.cov_AA <- "/ddn/home2/r2725/projects/jeannette/data/file.phe.cov_early_AA.csv"' >> ${string:0:${#string}-4}.R
				echo '# Loading phenotype data with the specific curve type and covariance type'
				echo 'obj.phe_AA <- fg.load.phenotype( file.phe.long_AA, file.phe.cov_AA, file.phe.time_AA,, curve.type="Legendre2", covariance.type="AR1")' >> ${string:0:${#string}-4}.R

				echo "saveRDS(obj.gen_AA, file=\"/ddn/home2/r2725/projects/jeannette/results/object.gen_${string:0:${#string}-4}.rds\")" >> ${string:0:${#string}-4}.R
				echo "saveRDS(obj.phe_AA, file=\"/ddn/home2/r2725/projects/jeannette/results/object.phe_${string:0:${#string}-4}.rds\")" >> ${string:0:${#string}-4}.R
			done;
		cd /ddn/home2/r2725/projects/jeannette/data/chr${i}_data/subset_chro${i}_EA_filtered
                        for string in *.bed;
                                do
                                echo "library(fGWAS)" >> ${string:0:${#string}-4}.R
                                echo "library(tidyverse)" >> ${string:0:${#string}-4}.R
                                echo file.plink.bed_EA = \"/ddn/home2/r2725/projects/jeannette/data/chr${i}_data/subset_chro${i}_EA_filtered/${string}\" >> ${string:0:${#string}-4}.R
                                echo file.plink.bim_EA = \"/ddn/home2/r2725/projects/jeannette/data/chr${i}_data/subset_chro${i}_EA_filtered/${string:0:${#string}-4}.bim\" >> ${string:0:${#string}-4}.R
                                echo file.plink.fam_EA = \"/ddn/home2/r2725/projects/jeannette/data/chr${i}_data/subset_chro${i}_EA_filtered/${string:0:${#string}-4}.fam\" >> ${string:0:${#string}-4}.R
                                echo 'obj.gen_EA <- fg.load.plink( file.plink.bed_EA, file.plink.bim_EA, file.plink.fam_EA, plink.command="/ddn/home2/r2725/apps/plink/plink1.9/plink")' >> ${string:0:${#string}-4}.R
                                echo 'file.phe.long_EA <- "/ddn/home2/r2725/projects/jeannette/data/file.phe.long_early_EA.csv"' >> ${string:0:${#string}-4}.R
                                echo 'file.phe.time_EA <- "/ddn/home2/r2725/projects/jeannette/data/file.phe.time_early_EA.csv"' >> ${string:0:${#string}-4}.R
                                echo 'file.phe.cov_EA <- "/ddn/home2/r2725/projects/jeannette/data/file.phe.cov_early_EA.csv"' >> ${string:0:${#string}-4}.R
                                echo '# Loading phenotype data with the specific curve type and covariance type'
                                echo 'obj.phe_EA <- fg.load.phenotype( file.phe.long_EA, file.phe.cov_EA, file.phe.time_EA,, curve.type="Legendre2", covariance.type="AR1")' >> ${string:0:${#string}-4}.R

                                echo "saveRDS(obj.gen_EA, file=\"/ddn/home2/r2725/projects/jeannette/results/object.gen_${string:0:${#string}-4}.rds\")" >> ${string:0:${#string}-4}.R
                                echo "saveRDS(obj.phe_EA, file=\"/ddn/home2/r2725/projects/jeannette/results/object.phe_${string:0:${#string}-4}.rds\")" >> ${string:0:${#string}-4}.R
                        done;
done
