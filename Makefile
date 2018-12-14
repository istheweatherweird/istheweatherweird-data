YEAR_MIN=1946
YEAR_MAX=2018

STATION=725300-94846

include default_profile
export

# sequence of all years
YEARS=$(shell seq $(YEAR_MIN) $(YEAR_MAX))
# sequence of all gz files
GZS = $(YEARS:%=www/$(STATION)-%.op.gz)

# sequence of all day-of-year csv files
MONTHS = $(shell seq -f '%02g' 1 12)
DAYS = $(shell seq -f '%02g' 1 31)
#MONTHDAYS=1210
#MONTHDAYS = $(foreach M,$(MONTHS),$(foreach D,$(DAYS),$M$D))
MONTHDAYS = $(shell python monthdays.py)
CSVS = $(MONTHDAYS:%=csv/%.csv)

all: $(GZS) $(CSVS)

$(GZS):
	mkdir -p `dirname $@`
	wget -nv -O www/`basename $@` ftp://ftp.ncdc.noaa.gov/pub/data/gsod/$(@:www/$(STATION)-%.op.gz=%)/$(@:www/%=%)

$(CSVS): $(GZS)
	# get all files (-type f) not empty (-not -empty) in www
	./gsod2csv.sh `basename $@ .csv` > $@
