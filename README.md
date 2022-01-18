[![Snakemake](https://img.shields.io/badge/snakemake-≥6.0.2-brightgreen.svg)](https://snakemake.github.io)
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

Author: Sherine Awad 

A snakemake pipeline for Downsampling Strategies 
=======================================================================================

Dropping reads is not as simple as discarding lines in a SAM file at random using unix commands. 
As in the paired short-read sequencing technology, reads come in pairs. If we drop reads line by line, we risk dropping a read and keeping its mate, and vice versa.
In addition to the issues of supplementary and secondary alignments. 
I here are different strategies of downsampling. 


Change the config.yaml file appropriately according to your data. 
Update samples.tsv to include your samples. You can edit config file to change this name.  


Then run: snakemake -jnumber_of_cores, for example for 5 cores use:

    snakemake -j5 

and for a dry run use: 

    snakemake -j1 -n 


and to print the commands in a dry run use:

    snakemake -j1 -n -p 

For the sake reproducibility, use conda to pull same versions of tools. Snakemake and conda have to be installed in your system:

    snakemake --cores --use-conda
