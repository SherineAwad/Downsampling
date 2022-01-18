configfile: "config.yaml"

with open(config['SAMPLES']) as fp:
    SAMPLES= fp.read().splitlines()
print(SAMPLES)


rule all:
      input:
          expand("{sample}.downsampled.bam", sample=SAMPLES),
          expand("{sample}.chained.bam", sample=SAMPLES),
          expand("{sample}.highaccuracy.bam", sample=SAMPLES),
          expand("{sample}.posbased.bam", sample=SAMPLES)

rule downsampled:
     input:
        bam = expand("{sample}.bam", sample=SAMPLES)
     output:
        expand("{sample}.downsampled.bam", sample=SAMPLES)
     params:
       percent = config['PERCENT'],
     shell:
         """
         picard DownsampleSam  I={input} O={output} STRATEGY=Chained P={params.percent}
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
         picard DownsampleSam  I={input} O={output} STRATEGY=Chained P={params.percent} ACCURACY={params.accuracy}
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
       picard DownsampleSam I={input} O={output} STRATEGY=HighAccuracy P={params.percent} ACCURACY={params.accuracy}  
       """ 

rule PosBased:
     input:
        bam = expand("{sample}.bam", sample=SAMPLES)
     output:
        expand("{sample}.posbased.bam", sample=SAMPLES)
     params:
       fraction = config['FRACTION']
     shell: 
        """
        picard PositionBasedDownsampleSam I={input} O={output} FRACTION={params.fraction}
        """ 

