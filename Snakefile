configfile: "config.yaml"

with open(config['SAMPLES']) as fp:
    SAMPLES= fp.read().splitlines()
print(SAMPLES)


rule all:
      input:
          expand("{sample}.downasampled.bam", sample=SAMPLES)

rule downsampling1: 
     input: 
        bam = expand("{sample}.bam", sample=SAMPLES)
     output: 
        expand("{sample}.downasampled.bam", sample=SAMPLES)
     params: 
       percent = config['PERCENT'], 
       accuracy = config['ACCURACY']
     shell:
         """
         java -jar picard.jar DownsampleSam  I={input} O={output} STRATEGY=Chained P={params.percent} ACCURACY={params.accuracy}
         """


