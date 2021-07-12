dat_DIR="/ddn/home2/r2725/projects/jeannette/data/"
plink19_path="/ddn/home2/r2725/apps/plink/plink1.9/plink"
resDIR="/ddn/home2/r2725/projects/jeannette/results/"
curveTypeAA="Exponential"
curveTypeEA="Power"
covarianceTypeAA="TOEPH"
covarianceTypeEA="TOEPH"
fgwas_method="optim-fgwas"
ncoreCPU=6

for i in {1..2}; 
	do
		cd ${dat_DIR}chr${i}_data/subset_chro${i}_AA_filtered
			for string in *.bed; 
				do 
				if [ -f "${string:0:${#string}-4}.R" ]; then rm -r ${string:0:${#string}-4}.R; fi
				echo "library(fGWAS)" >> ${string:0:${#string}-4}.R
				echo "library(tidyverse)" >> ${string:0:${#string}-4}.R
				echo file.plink.bed_AA = \"${dat_DIR}chr${i}_data/subset_chro${i}_AA_filtered/${string}\" >> ${string:0:${#string}-4}.R
				echo file.plink.bim_AA = \"${dat_DIR}chr${i}_data/subset_chro${i}_AA_filtered/${string:0:${#string}-4}.bim\" >> ${string:0:${#string}-4}.R
				echo file.plink.fam_AA = \"${dat_DIR}chr${i}_data/subset_chro${i}_AA_filtered/${string:0:${#string}-4}.fam\" >> ${string:0:${#string}-4}.R
				echo obj.gen_AA \<- fg.load.plink\( file.plink.bed_AA, file.plink.bim_AA, file.plink.fam_AA, plink.command=\"${plink19_path}\"\) >> ${string:0:${#string}-4}.R
				echo file.phe.long_AA \<- \"${dat_DIR}file.phe.long_early_AA.csv\" >> ${string:0:${#string}-4}.R
				echo file.phe.time_AA \<- \"${dat_DIR}file.phe.time_early_AA.csv\" >> ${string:0:${#string}-4}.R
				echo file.phe.cov_AA \<- \"${dat_DIR}file.phe.cov_early_AA.csv\" >> ${string:0:${#string}-4}.R
				echo '# Loading phenotype data with the specific curve type and covariance type' >> ${string:0:${#string}-4}.R
				echo obj.phe_AA \<- fg.load.phenotype\( file.phe.long_AA, file.phe.cov_AA, file.phe.time_AA, curve.type=\"${curveTypeAA}\", covariance.type=\"${covarianceTypeAA}\"\) >> ${string:0:${#string}-4}.R 

				echo saveRDS\(obj.gen_AA, file=\"${resDIR}object.gen_${string:0:${#string}-4}.rds\"\) >> ${string:0:${#string}-4}.R
				echo saveRDS\(obj.phe_AA, file=\"${resDIR}object.phe_${string:0:${#string}-4}.rds\"\) >> ${string:0:${#string}-4}.R
				echo r.${string:0:${#string}-4} \<- fg.snpscan\(obj.gen_AA, obj.phe_AA, method=\"${fgwas_method}\", options=list\(ncores=${ncoreCPU}\)\) >> ${string:0:${#string}-4}.R
				echo r.sigsnps \<\- fg.select.sigsnp\(r.${string:0:${#string}-4}\)  >> ${string:0:${#string}-4}.R
				echo saveRDS\(r.${string:0:${#string}-4}, file=\"${resDIR}_scan_r.${string:0:${#string}-4}.rds\"\) >> ${string:0:${#string}-4}.R
				echo write.csv\(r.sigsnps, file=\"${resDIR}signsnp${string:0:${#string}-4}.csv\"\) >> ${string:0:${#string}-4}.R
				echo "# draw Manhattan plot for all SNPs" >> ${string:0:${#string}-4}.R
				echo plot\(r.${string:0:${#string}-4}, file.pdf=\"${resDIR}r.${string:0:${#string}-4}.manhattan.pdf\"\) >> ${string:0:${#string}-4}.R
				echo "# draw genetic effects of each genotype for the significant SNPs " >> ${string:0:${#string}-4}.R
				echo if \(length\(r.sigsnps\$INDEX\) \> 0\)  plot.fgwas.curve\(r.${string:0:${#string}-4}, snp.sub= r.sigsnps\$INDEX, file.pdf=\"${resDIR}r.${string:0:${#string}-4}.sigeffect.pdf\"\) >> ${string:0:${#string}-4}.R;
				echo save.image\(\"${resDIR}r.${string:0:${#string}-4}.workspace.RData\"\) >> ${string:0:${#string}-4}.R;
			done;
		cd ${dat_DIR}chr${i}_data/subset_chro${i}_EA_filtered
                        for string in *.bed;
                                do
				if [ -f "${string:0:${#string}-4}.R" ]; then rm -r ${string:0:${#string}-4}.R; fi
				echo "library(fGWAS)" >> ${string:0:${#string}-4}.R
                                echo "library(tidyverse)" >> ${string:0:${#string}-4}.R
                                echo file.plink.bed_EA = \"${dat_DIR}chr${i}_data/subset_chro${i}_EA_filtered/${string}\" >> ${string:0:${#string}-4}.R
                                echo file.plink.bim_EA = \"${dat_DIR}chr${i}_data/subset_chro${i}_EA_filtered/${string:0:${#string}-4}.bim\" >> ${string:0:${#string}-4}.R
                                echo file.plink.fam_EA = \"${dat_DIR}chr${i}_data/subset_chro${i}_EA_filtered/${string:0:${#string}-4}.fam\" >> ${string:0:${#string}-4}.R
                                echo obj.gen_EA \<- fg.load.plink\( file.plink.bed_EA, file.plink.bim_EA, file.plink.fam_EA, plink.command=\"${plink19_path}\"\) >> ${string:0:${#string}-4}.R
                                echo file.phe.long_EA \<- \"${dat_DIR}file.phe.long_early_EA.csv\" >> ${string:0:${#string}-4}.R
                                echo file.phe.time_EA \<- \"${dat_DIR}file.phe.time_early_EA.csv\" >> ${string:0:${#string}-4}.R
                                echo file.phe.cov_EA \<- \"${dat_DIR}file.phe.cov_early_EA.csv\" >> ${string:0:${#string}-4}.R
                                echo '# Loading phenotype data with the specific curve type and covariance type' >> ${string:0:${#string}-4}.R
                                echo obj.phe_EA \<- fg.load.phenotype\(file.phe.long_EA, file.phe.cov_EA, file.phe.time_EA,, curve.type=\"${curveTypeEA}\", covariance.type=\"${covarianceTypeEA}\"\) >> ${string:0:${#string}-4}.R

                                echo saveRDS\(obj.gen_EA, file=\"${resDIR}object.gen_${string:0:${#string}-4}.rds\"\) >> ${string:0:${#string}-4}.R
                                echo saveRDS\(obj.phe_EA, file=\"${resDIR}object.phe_${string:0:${#string}-4}.rds\"\) >> ${string:0:${#string}-4}.R
                                echo r.${string:0:${#string}-4} \<- fg.snpscan\(obj.gen_EA, obj.phe_EA, method=\"${fgwas_method}\", options=list\(ncores=${ncoreCPU}\)\) >> ${string:0:${#string}-4}.R
                                echo r.sigsnps \<\- fg.select.sigsnp\(r.${string:0:${#string}-4}\)  >> ${string:0:${#string}-4}.R
				echo saveRDS\(r.${string:0:${#string}-4}, file=\"${resDIR}r.sigsnps_${string:0:${#string}-4}.rds\"\) >> ${string:0:${#string}-4}.R
                                echo write.csv\(r.sigsnps${string:0:${#string}-4}, file=\"${resDIR}signsnp${string:0:${#string}-4}.csv\"\) >> ${string:0:${#string}-4}.R
                                echo "# draw Manhattan plot for all SNPs" >> ${string:0:${#string}-4}.R
                                echo plot\(r.${string:0:${#string}-4}, file.pdf=\"${resDIR}r.${string:0:${#string}-4}.manhattan.pdf\"\) >> ${string:0:${#string}-4}.R
                                echo "# draw genetic effects of each genotype for the significant SNPs " >> ${string:0:${#string}-4}.R
                                echo if \(length\(r.sigsnps\$INDEX\) \> 0\) plot.fgwas.curve\(r.${string:0:${#string}-4}, snp.sub= r.sigsnps\$INDEX, file.pdf=\"${resDIR}r.${string:0:${#string}-4}.sigeffect.pdf\"\) >> ${string:0:${#string}-4}.R;
				echo save.image\(\"${resDIR}r.${string:0:${#string}-4}.workspace.RData\"\) >> ${string:0:${#string}-4}.R;

			done;
done
