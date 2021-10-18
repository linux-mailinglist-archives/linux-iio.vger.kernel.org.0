Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FF443255E
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 19:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhJRRu2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 13:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233374AbhJRRuY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 13:50:24 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22C9B60F11;
        Mon, 18 Oct 2021 17:48:10 +0000 (UTC)
Date:   Mon, 18 Oct 2021 18:52:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Roan van Dijk <roan@protonic.nl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v5 0/4] iio: chemical: Add support for Sensirion SCD4x
 CO2 sensor
Message-ID: <20211018185225.11396bb0@jic23-huawei>
In-Reply-To: <2c7f8b7c-3070-5763-7b74-3811cdbfcabc@protonic.nl>
References: <20211008101706.755942-1-roan@protonic.nl>
        <20211010165919.51f06938@jic23-huawei>
        <20211013183828.521f043f@jic23-huawei>
        <3ecfe246-b942-0c1e-08e6-17eff4c5cc16@protonic.nl>
        <20211014181932.5f70d2e4@jic23-huawei>
        <2c7f8b7c-3070-5763-7b74-3811cdbfcabc@protonic.nl>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Oct 2021 10:19:42 +0200
Roan van Dijk <roan@protonic.nl> wrote:

> On 14-10-2021 19:19, Jonathan Cameron wrote:
> > On Thu, 14 Oct 2021 10:24:54 +0200
> > Roan van Dijk <roan@protonic.nl> wrote:
> >   
> >> On 13-10-2021 19:38, Jonathan Cameron wrote:  
> >>> On Sun, 10 Oct 2021 16:59:19 +0100
> >>> Jonathan Cameron <jic23@kernel.org> wrote:
> >>>      
> >>>> On Fri,  8 Oct 2021 12:17:02 +0200
> >>>> Roan van Dijk <roan@protonic.nl> wrote:
> >>>>     
> >>>>> This series adds support for the Sensirion SCD4x sensor.
> >>>>>
> >>>>> The driver supports continuous reads of temperature, relative humdity and CO2
> >>>>> concentration. There is an interval of 5 seconds between readings. During
> >>>>> this interval the drivers checks if the sensor has new data available.
> >>>>>
> >>>>> The driver is based on the scd30 driver. However, The scd4x has become too
> >>>>> different to just expand the scd30 driver. I made a new driver instead of
> >>>>> expanding the scd30 driver. I hope I made the right choice by doing so?  
> >>>>
> >>>> Applied to the togreg branch of iio.git with the issues Randy mentioned tidied
> >>>> up. Pushed out as testing for 0-day to see if it can find anything we missed  
> >>>
> >>> And indeed - I missed a bunch of places where explicit __be16 types should have
> >>> been used.
> >>>
> >>> I've applied the following fixup, shout if it's wrong.
> >>>     
> >> Thank you Jonathan for applying this fixup. No need to shout :) Your
> >> changes should fix the issue.
> >>
> >> However, I have a question about something else. The co2 concentration
> >> is an IIO_CHAN_INFO_RAW, but doesn't have a scale or offset at this
> >> moment. Is an _scale always required for an _raw in the ABI? I could not
> >> find anything in the documentation if there is a rule for this. Someone
> >> mentioned this to me, so I want to check if I did this right.
> >>
> >> The sensor returns the actual co2 value upon reading, like 450 ppm. We
> >> can set an offset of this co2 value with the calibration_forced_value
> >> through the ABI, but this offset is handled internally by the sensor. So
> >> there isn't anything with scaling or an offset needed at the driver side.  
> > 
> > Ah. We could have mapped this to calibbias, though here it's made more
> > complex by other calibrations existing that don't use the value so let's
> > leave it as it is.
> >   
> >>
> >> Was I right by making it of type RAW? If needed we could make it more
> >> like the scd30 driver, keeping it of type RAW but with scale = 1. What
> >> should I do or is it fine as it is?  
> > 
> > Hmm. Interesting corner case in the ABI.  A _raw value without a scale
> > normally means we don't know it for some reason.  The most common case
> > of this is light sensors where several _raw intensity values are combined
> > in some (typically non linear) transform to form a single measure of illuminance.
> > Those intensity_raw channels don't have an meaningful units, but devices
> > often have threshold events on them so we have to expose them.
> > 
> > I would say make it a processed value, but there is a quirk.
> > concentrations in IIO are expressed in percent not per million, so you need
> > a scale anyway, I guess 10000?  See Documentation/ABI/testing/sysfs-bus-iio
> > 
> > 
> > No need to do a new driver version, just send a patch tidying up this corner.
> >   
> 
> Hi Jonathan,
> 
> As you suggested, these are my fixes for the concentration reading.
> 
> The co2 reading is now a processed value and has a scale. I also added 
> the information in sysfs-bus-iio documentation, because this type of 
> processed value is new in the ABI.
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio 
> b/Documentation/ABI/testing/sysfs-bus-iio
> index c27347d3608e..66a17f4c831e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1716,6 +1716,7 @@ Description:
> 
>   What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_raw
>   What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_raw
> +What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_co2_input
>   What:          /sys/bus/iio/devices/iio:deviceX/in_concentration_co2_raw
>   What:          /sys/bus/iio/devices/iio:deviceX/in_concentrationX_co2_raw
>   What: 
> /sys/bus/iio/devices/iio:deviceX/in_concentration_ethanol_raw
> diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
> index 09b34201c42b..bc1c6676029d 100644
> --- a/drivers/iio/chemical/scd4x.c
> +++ b/drivers/iio/chemical/scd4x.c
> @@ -337,6 +337,7 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
> 
>          switch (mask) {
>          case IIO_CHAN_INFO_RAW:
> +       case IIO_CHAN_INFO_PROCESSED:
>                  ret = iio_device_claim_direct_mode(indio_dev);
>                  if (ret)
>                          return ret;
> @@ -352,7 +353,11 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
>                  *val = ret;
>                  return IIO_VAL_INT;
>          case IIO_CHAN_INFO_SCALE:
> -               if (chan->type == IIO_TEMP) {
> +               if (chan->type == IIO_CONCENTRATION) {
> +                       *val = 0;
> +                       *val2 = 100;
> +                       return IIO_VAL_INT_PLUS_MICRO;
> +               } else if (chan->type == IIO_TEMP) {
>                          *val = 175000;
>                          *val2 = 65536;
>                          return IIO_VAL_FRACTIONAL;
> @@ -501,7 +506,8 @@ static const struct iio_chan_spec scd4x_channels[] = {
>                  .type = IIO_CONCENTRATION,
>                  .channel2 = IIO_MOD_CO2,
>                  .modified = 1,
> -               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +                                       BIT(IIO_CHAN_INFO_SCALE),
You shouldn't have scale and processed.  If we need a scale, then it should
be _RAW.

Jonathan

>                  .address = SCD4X_CO2,
>                  .scan_index = SCD4X_CO2,
>                  .scan_type = {
> 
> Thanks,
> 
> Roan
> 
> > Thanks,
> > 
> > Jonathan
> > 
> >   
> >> Sorry for not asking this earlier.
> >>
> >> Thanks,
> >>
> >> Roan
> >>  
> >>> diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
> >>> index 09b34201c42b..ebebcb117ba2 100644
> >>> --- a/drivers/iio/chemical/scd4x.c
> >>> +++ b/drivers/iio/chemical/scd4x.c
> >>> @@ -263,7 +263,7 @@ static int scd4x_write_and_fetch(struct scd4x_state *state, enum scd4x_cmd cmd,
> >>>    static int scd4x_read_meas(struct scd4x_state *state, uint16_t *meas)
> >>>    {
> >>>    	int i, ret;
> >>> -	uint16_t buf[3];
> >>> +	__be16 buf[3];
> >>>    
> >>>    	ret = scd4x_read(state, CMD_READ_MEAS, buf, sizeof(buf));
> >>>    	if (ret)
> >>> @@ -282,12 +282,13 @@ static int scd4x_wait_meas_poll(struct scd4x_state *state)
> >>>    	int ret;
> >>>    
> >>>    	do {
> >>> +		__be16 bval;
> >>>    		uint16_t val;
> >>>    
> >>> -		ret = scd4x_read(state, CMD_GET_DATA_READY, &val, sizeof(val));
> >>> +		ret = scd4x_read(state, CMD_GET_DATA_READY, &bval, sizeof(bval));
> >>>    		if (ret)
> >>>    			return -EIO;
> >>> -		val = be16_to_cpu(val);
> >>> +		val = be16_to_cpu(bval);
> >>>    
> >>>    		/* new measurement available */
> >>>    		if (val & 0x7FF)
> >>> @@ -333,7 +334,7 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
> >>>    {
> >>>    	struct scd4x_state *state = iio_priv(indio_dev);
> >>>    	int ret;
> >>> -	uint16_t tmp;
> >>> +	__be16 tmp;
> >>>    
> >>>    	switch (mask) {
> >>>    	case IIO_CHAN_INFO_RAW:
> >>> @@ -405,17 +406,18 @@ static ssize_t calibration_auto_enable_show(struct device *dev,
> >>>    	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >>>    	struct scd4x_state *state = iio_priv(indio_dev);
> >>>    	int ret;
> >>> -	uint16_t val;
> >>> +	__be16 bval;
> >>> +	u16 val;
> >>>    
> >>>    	mutex_lock(&state->lock);
> >>> -	ret = scd4x_read(state, CMD_GET_ASC, &val, sizeof(val));
> >>> +	ret = scd4x_read(state, CMD_GET_ASC, &bval, sizeof(bval));
> >>>    	mutex_unlock(&state->lock);
> >>>    	if (ret) {
> >>>    		dev_err(dev, "failed to read automatic calibration");
> >>>    		return ret;
> >>>    	}
> >>>    
> >>> -	val = (be16_to_cpu(val) & SCD4X_READY_MASK) ? 1 : 0;
> >>> +	val = (be16_to_cpu(bval) & SCD4X_READY_MASK) ? 1 : 0;
> >>>    
> >>>    	return sprintf(buf, "%d\n", val);
> >>>    }
> >>>
> >>>      
> >>>>
> >>>> Thanks,
> >>>>
> >>>> Jonathan
> >>>>     
> >>>>>
> >>>>> Changes since v5:
> >>>>> scd4x.c:
> >>>>>     - Fix bug in trigger_handler
> >>>>>
> >>>>> Changes since v4:
> >>>>> scd4x.c:
> >>>>>     - Minor fixes in documentation
> >>>>>     - Reorder trigger_handler so memcpy is not needed anymore
> >>>>> Documentation:
> >>>>>     - Change information about the KernelVersion for the
> >>>>>       calibration_forced_value_available
> >>>>>
> >>>>> Changes since v3:
> >>>>> scd4x.c
> >>>>>     - Change read and write_and_fetch function parameter. CRC byte is now
> >>>>>       hidden inside the function.
> >>>>>     - Fix minor style issues
> >>>>>     - Add calibration_forced_value_available attribute to the driver
> >>>>>     - Remove including BUFFER_TRIGGERED
> >>>>>     - Change calibbias to raw ADC readings rather than converting it to
> >>>>>       milli degrees C.
> >>>>> Documentation:
> >>>>>     - Change description of driver attributes
> >>>>>     - Add calibration_forced_value_available documentation
> >>>>>
> >>>>> Changes since v2:
> >>>>> scd4x.c:
> >>>>>     - Change boolean operations
> >>>>>     - Document scope of lock
> >>>>>     - Remove device *dev from struct
> >>>>>     - Add goto block for errror handling
> >>>>>     - Add function to read value per channel in read_raw
> >>>>>     - Fix bug with lock in error paths
> >>>>>     - Remove conversion of humidity and temperature values
> >>>>>     - Add scale and offset to temperature channel
> >>>>>     - Add scale to humidity channel
> >>>>>     - Move memset out of locked section
> >>>>>     - Remove unused irq functions
> >>>>>     - Move device register at end of probe function
> >>>>> Documentation:
> >>>>>     - Copy content of sysfs-bus-iio-scd30 to sysfs-bus-iio
> >>>>>     - Remove Documentation/ABI/testing/sysfs-bus-iio-scd30
> >>>>>
> >>>>> Changes since v1:
> >>>>> dt-bindings:
> >>>>>     - Separated compatible string for each sensor type
> >>>>> scd4x.c:
> >>>>>     - Changed probe, resume and suspend functions to static
> >>>>>     - Added SIMPLE_DEV_PM_OPS function call for power management
> >>>>>       operations.
> >>>>>
> >>>>> Roan van Dijk (4):
> >>>>>     dt-bindings: iio: chemical: sensirion,scd4x: Add yaml description
> >>>>>     MAINTAINERS: Add myself as maintainer of the scd4x driver
> >>>>>     drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor
> >>>>>     iio: documentation: Document scd4x calibration use
> >>>>>
> >>>>>    Documentation/ABI/testing/sysfs-bus-iio       |  41 ++
> >>>>>    Documentation/ABI/testing/sysfs-bus-iio-scd30 |  34 -
> >>>>>    .../iio/chemical/sensirion,scd4x.yaml         |  46 ++
> >>>>>    MAINTAINERS                                   |   6 +
> >>>>>    drivers/iio/chemical/Kconfig                  |  13 +
> >>>>>    drivers/iio/chemical/Makefile                 |   1 +
> >>>>>    drivers/iio/chemical/scd4x.c                  | 689 ++++++++++++++++++
> >>>>>    7 files changed, 796 insertions(+), 34 deletions(-)
> >>>>>    delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
> >>>>>    create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
> >>>>>    create mode 100644 drivers/iio/chemical/scd4x.c
> >>>>>         
> >>>>     
> >>>      
> >   

