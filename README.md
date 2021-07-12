# longitudinalGWAS

This is a pipline for running longitudinal GWAS study. The analysis is based one fGWAS method by Wang at https://github.com/wzhy2000/fGWAS

You need to install the following tools besides fGWAS program at the above website. 
+ plink2.0
+ bcftools
I used pbs for running on HPC.
Your vcf file names may be different than mine, so you need to make some change accordingly.

You may do the following steps to run the program:
1) Run the phenotype_genotype_id program to get the genotype data corresponding to your phenotype data.
2) Run the split_all_chr.pbs to filtered the vcf files to the samples you want for each AA or EA and split the SNPs into smaller subset having atmost 1M for AA and 500K for EA (since our AA sample size is 3K and EA sample size is 10K)
3) Run the curve fitting program to find the best covariance structure and the best fgwas functional type for your data. 
4) Run the create_Rscript_var.sh to create Rscripts for all the splitted files for each chromosome to run the fGWAS
5) Run the create_pbs.pbs to create pbs for each chromosome and splitted SNP files for each AA and EA, so we don't have to create for many files
6) Run the program to submit the jobs from each Rscript for each splitted files of each chromosome by running fgwas_pbs.sh which submits all the needed jobs for all chromosomes and splitted files for AA and EA.
