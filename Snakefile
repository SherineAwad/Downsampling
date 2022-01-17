configfile: "config.yaml"

with open(config['SAMPLES']) as fp:
    SAMPLES= fp.read().splitlines()
print(SAMPLES)


rule all:
      input:
          expand("{sample}.chained.bam", sample=SAMPLES),
          expand("{sample}.highaccuracy.bam", sample=SAMPLES)

rule downsampled:
     input:
        bam = expand("{sample}.bam", sample=SAMPLES)
     output:
        expand("{sample}.downsampled.bam", sample=SAMPLES)
     params:
       percent = config['PERCENT'],
     shell:
         """
         java -jar picard.jar DownsampleSam  I={input} O={output} STRATEGY=Chained P={params.percent}
         """

rule chained: 
     input: 
        bam = expand("{sample}.bam", sample=SAMPLES)
     output: 
        expand("{sample}.chained.bam", sample=SAMPLES)
     params: 
       percent = config['PERCENT'], 
       accuracy = config['ACCURACY']
     shell:
         """
         java -jar picard.jar DownsampleSam  I={input} O={output} STRATEGY=Chained P={params.percent} ACCURACY={params.accuracy}
         """

rule highAccuracy: 
     input:
        bam = expand("{sample}.bam", sample=SAMPLES)
     output:
        expand("{sample}.highaccuracy.bam", sample=SAMPLES)
     params:
       percent = config['PERCENT'],
       accuracy = config['ACCURACY']
     shell:
       """
       java -jar picard.jar DownsampleSam I={input} O={output} STRATEGY=HighAccuracy P={params.percent} ACCURACY={params.accuracy}  
       """ 

