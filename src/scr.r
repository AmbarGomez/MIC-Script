#Importing data
MIC <- read.delim("../Dataset-MIC.txt")

#Observing data
# View(MIC)
str(MIC)
head(MIC)

#Mean and SD
require("dplyr")

summary.MIC <- na.omit(MIC) %>%
               group_by(Cepa, Ant, Vol) %>%
               summarize(mean = mean(Rad), 
               sd = sd(Rad),
               n = n(),
               se = sd(Rad)
               ); summary.MIC


#Anova Radio
aov.MIC <- aov(Rad ~ Ant * Cepa, 
                  data = MIC); summary(aov.MIC)
#Sig data in all parameters and in combination of parameters

shapiro.test(aov.MIC$residuals) # p > 0.05 Residual distribution is normal

# Tukey Radio ####
T.aov.MIC <- TukeyHSD(aov.MIC); TukeyHSD(aov.MIC); plot(T.aov.MIC)

#ANOVA Vol
aov.MIC <- aov(Rad ~ Vol * Ant, 
               data = MIC); summary(aov.MIC)
#Sig data in all parameters and in combination of parameters

shapiro.test(aov.MIC$residuals) # p > 0.05 Residual distribution is normal

# Tukey Vol ####
T.aov.MIC <- TukeyHSD(aov.MIC); TukeyHSD(aov.MIC); plot(T.aov.MIC)


# GGplot MIC ####
require("tidyverse")
require("ggplot2")
library(ggplot2)

# Box plot for all MIC data set 
#MIC.plot <- ggplot(MIC, aes(x = Vol, y = Rad, fill = Cepa)) +
 # geom_boxplot() +
  #scale_x_discrete(name = "Cepa") +
  #scale_y_continuous(name = "Antibiotico") +
  #ggtitle("Khestapasanda") ; MIC.plot


# Sub-setting data by strain

HF8B <- MIC[MIC$Cepa == "HF8B",]
K115 <- MIC[MIC$Cepa == "K115",]
RA1B <- MIC[MIC$Cepa == "RA1B",]
INP22B <- MIC[MIC$Cepa == "INP22B",]
AeR106.3 <- MIC[MIC$Cepa == "AeR106-3",]
AeR96.2 <- MIC[MIC$Cepa == "AeR96-2",]
AeR97.1 <- MIC[MIC$Cepa == "AeR97-1",]
AL3A <- MIC[MIC$Cepa == "AL3A",]
INP12A <- MIC[MIC$Cepa == "INP12A",]


# Box plot by strain 
library(ggpubr)
 
ggarrange(HF8B.plot, K115.plot, RA1B.plot, INP22B.plot, AeR106.3.plot, AeR96.2.plot,
          AeR97.1.plot, AL3A.plot, INP12A.plot, 
          ncol = 3, nrow = 3,  align = "hv", 
          #widths = c(2, 1), heights = c(1, 2),
          common.legend = TRUE)

HF8B.plot <- ggplot(HF8B, aes(x = Vol, y = Rad, fill = Ant)) + theme(legend.position = "none")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio MIC (mm)") +
  ggtitle("HF8B") ; HF8B.plot

K115.plot <- ggplot(K115, aes(x = Vol, y = Rad, fill = Ant)) +  theme(legend.position = "none") +
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio MIC (mm)") +
  ggtitle("K115") ; K115.plot

RA1B.plot <- ggplot(RA1B, aes(x = Vol, y = Rad, fill = Ant)) +  theme(legend.position = "none")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio MIC (mm)") +
  ggtitle("RA1B")  ; RA1B.plot

INP22B.plot <- ggplot(INP22B, aes(x = Vol, y = Rad, fill = Ant)) +  theme(legend.position = "none")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio MIC (mm)") +
  ggtitle("INP22B")

AeR106.3.plot <- ggplot(AeR106.3, aes(x = Vol, y = Rad, fill = Ant)) +  theme(legend.position = "none")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio MIC (mm)") +
  ggtitle("AeR106-3")

AeR96.2.plot <- ggplot(AeR96.2, aes(x = Vol, y = Rad, fill = Ant)) +  theme(legend.position = "none")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio MIC (mm)") +
  ggtitle("AeR96-2")

AeR97.1.plot <- ggplot(AeR97.1, aes(x = Vol, y = Rad, fill = Ant)) +  theme(legend.position = "none")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio MIC (mm)") +
  ggtitle("AeR97-1")

AL3A.plot <- ggplot(AL3A, aes(x = Vol, y = Rad, fill = Ant)) +  theme(legend.position = "none")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio MIC (mm)") +
  ggtitle("AL3A")

INP12A.plot <- ggplot(INP12A, aes(x = Vol, y = Rad, fill = Ant)) +  theme(legend.position = "none")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio MIC (mm)") +
  ggtitle("INP12A") ; INP12A.plot
        

## Filtering data by antibiotic 
Car <- filter(MIC, MIC$Ant == "Carbenicilina (Car)"); Car

summary.Car <- na.omit(Car) %>%
  group_by(Cepa, Ant, Vol) %>%
  summarize(mean = mean(Rad), 
            sd = sd(Rad),
            n = n(),
            se = sd(Rad)
  ); summary.Car


Car.plot <- ggplot(Car, aes(x = Vol, y = Rad, fill = Cepa)) +  theme(legend.position = "bottom")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio MIC (mm)") +
  ggtitle("Carbenicilina") ; Car.plot

##### Data by antibiotic

MIC2 <- read.delim("../Dataset-MIC.txt")

summary.MIC <- na.omit(MIC2) %>%
  group_by(Cepa, Ant, Vol) %>%
  summarize(meanInhib = mean(Rad), 
            sd = sd(Rad),
            n = n(),
            se = sd(Rad)
  ); summary.MIC

summary.MIC[summary.MIC$meanInhib>10,] 

# Filtar que volumen me da un halo con valor a 10, y si ningun volumen 
# da un halo con valor igual o mayor que 10, que arroje el volumen m�ximo


VolInhibMinAlo <- summary.MIC %>%
  group_by(Cepa, Ant) %>%
  mutate( Vol=case_when( max(meanInhib)<10 ~ max(Vol), max(meanInhib)>=10 ~ Vol)) %>%
  mutate( meanInhib_F=case_when( max(meanInhib)<10 ~ 10, max(meanInhib)>=10 ~ meanInhib )) %>%
  filter(meanInhib_F >= 10 ) %>% # Filter by mean radious
  mutate( minVol=min(Vol)) %>%
  mutate( meanInhib_F2= min(min(meanInhib_F),max(meanInhib)) )%>%
  select(Cepa, Ant, minVol,meanInhib_F2)%>%
  group_by(Cepa, Ant)%>%summarize(minVol = mean(minVol),Alo=mean(meanInhib_F2)) 
  
 # filter(Vol == minVol) # Filter to keep the minimum volume

  
  
  View(VolInhibMinAlo)






### pendiente hasta que salga el filtro 
Amp <- filter(MIC2, MIC2$Ant == "Ampicilina (Amp)"); Amp

summary.Amp <- na.omit(Amp) %>%
  group_by(Cepa, Ant, Vol) %>%
  summarize(mean = mean(Rad), 
            sd = sd(Rad),
            n = n(),
            se = sd(Rad)
  ); summary.Amp
view(summary.Amp)

Car <- filter(MIC2, MIC2$Ant == "Carbenicilina (Car)"); Car

summary.Car <- na.omit(Car) %>%
  group_by(Cepa, Ant, Vol) %>%
  summarize(mean = mean(Rad), 
            sd = sd(Rad),
            n = n(),
            se = sd(Rad)
  ); summary.Car

Apra <- filter(MIC2, MIC2$Ant == "Apramicina (Apra)"); Apra

summary.Apra <- na.omit(Apra) %>%
  group_by(Cepa, Ant, Vol) %>%
  summarize(mean = mean(Rad), 
            sd = sd(Rad),
            n = n(),
            se = sd(Rad)
  ); summary.Apra

Nm <- filter(MIC2, MIC2$Ant == "Neomicina (Nm)"); Nm

summary.Nm <- na.omit(Nm) %>%
  group_by(Cepa, Ant, Vol) %>%
  summarize(mean = mean(Rad), 
            sd = sd(Rad),
            n = n(),
            se = sd(Rad)
  ); summary.Nm

Gm <- filter(MIC2, MIC2$Ant == "Gentamicina (Gm)"); Gm

summary.Gm <- na.omit(Gm) %>%
  group_by(Cepa, Ant, Vol) %>%
  summarize(mean = mean(Rad), 
            sd = sd(Rad),
            n = n(),
            se = sd(Rad)
  ); summary.Gm

Cm <- filter(MIC2, MIC2$Ant == "Cloramfenicol (Cm)"); Cm

summary.Cm <- na.omit(Cm) %>%
  group_by(Cepa, Ant, Vol) %>%
  summarize(mean = mean(Rad), 
            sd = sd(Rad),
            n = n(),
            se = sd(Rad)
  ); summary.Cm


#ploting the summary (mean of the diameter)
library(ggplot2)
library(ggpubr)

ggarrange(Amp.plot, Apra.plot, Car.plot, Nm.plot, Gm.plot, Cm.plot,
          ncol = 3, nrow = 2,  align = "hv", 
          #widths = c(2, 1), heights = c(1, 2),
          legend = "top")
         


Amp.plot <- ggplot(summary.Amp, aes(x = Vol, y = summary.Amp$mean, fill = Cepa)) +  theme(legend.position = "none")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio (mm)") +
  ggtitle("Ampicilina") ; Amp.plot

Apra.plot <- ggplot(summary.Apra, aes(x = Vol, y = summary.Apra$mean, fill = Cepa)) +  theme(legend.position = "none")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio (mm)") +
  ggtitle("Apramicina") ; Apra.plot

Car.plot <- ggplot(summary.Car, aes(x = Vol, y = summary.Car$mean, fill = Cepa)) +  theme(legend.position = "none")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio (mm)") +
  ggtitle("Carbenicilina") ; Car.plot

Nm.plot <- ggplot(summary.Nm, aes(x = Vol, y = summary.Nm$mean, fill = Cepa)) +  theme(legend.position = "none")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio (mm)") +
  ggtitle("Neomicina") ; Nm.plot

Gm.plot <- ggplot(summary.Gm, aes(x = Vol, y = summary.Gm$mean, fill = Cepa)) +  theme(legend.position = "none")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio (mm)") +
  ggtitle("Gentamicina") ; Gm.plot

Cm.plot <- ggplot(summary.Cm, aes(x = Vol, y = summary.Cm$mean, fill = Cepa)) +  theme(legend.position = "none")+
  geom_boxplot() +
  scale_x_discrete(name = "Antibiotico") +
  scale_y_continuous(name = "Radio (mm)") +
  ggtitle("Cloranfenicol") ; Cm.plot


