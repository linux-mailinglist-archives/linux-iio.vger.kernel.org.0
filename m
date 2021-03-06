Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C8232FB45
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 16:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCFPAa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 10:00:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhCFPAG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Mar 2021 10:00:06 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0602F6501C;
        Sat,  6 Mar 2021 15:00:03 +0000 (UTC)
Date:   Sat, 6 Mar 2021 14:59:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 2/2] iio: adc: add ADC driver for the TI TSC2046
 controller
Message-ID: <20210306145959.4c51e8ae@archlinux>
In-Reply-To: <20210306132852.s2vzotnadanoo2na@pengutronix.de>
References: <20210305133813.27967-1-o.rempel@pengutronix.de>
        <20210305133813.27967-3-o.rempel@pengutronix.de>
        <20210305190239.000075fe@Huawei.com>
        <20210306132852.s2vzotnadanoo2na@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 6 Mar 2021 14:28:52 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Fri, Mar 05, 2021 at 07:02:39PM +0000, Jonathan Cameron wrote:
> > On Fri, 5 Mar 2021 14:38:13 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >   
> > > Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> > > the touchscreen use case. By implementing it as IIO ADC device, we can
> > > make use of resistive-adc-touch and iio-hwmon drivers.
> > > 
> > > So far, this driver was tested with custom version of resistive-adc-touch driver,
> > > since it need to be extended to make use of Z1 and Z2 channels. The X/Y
> > > are working without additional changes.
> > > 
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>  
> > 
> > Hi Oleksij,
> > 
> > To consider this as a possible long term route instead of just making this
> > a touchscreen driver, we'll want to see those mods to the resistive-adc-touch.
> > Of course that doesn't stop review of this in the meantime.  
> 
> ok.
> 
> I had following issues with the existing resistive-adc-touch driver:
> - the buffer layout is not configurable over DT or i didn't understood
>   how to properly configure it
> - the "pressure" channel provide pre processed data driver or
>   controller, this information cannot be extracted directly from the
>   touchscreen plates.
> 
> I did following changes to make it work for my use case:
> 
> --- a/drivers/input/touchscreen/resistive-adc-touch.c
> +++ b/drivers/input/touchscreen/resistive-adc-touch.c
> @@ -44,15 +44,34 @@ static int grts_cb(const void *data, void *private)
>  {
>  	const u16 *touch_info = data;
>  	struct grts_state *st = private;
> -	unsigned int x, y, press = 0x0;
> +	unsigned int x, y, press = 0x0, z1, z2;
> +	unsigned int Rt;
>  
>  	/* channel data coming in buffer in the order below */
> -	x = touch_info[0];
> -	y = touch_info[1];
> +	// TODO: make sure we get buffers in proper order

Ah.  So to figure this out we'll need to read some more info about the
channels.  The phandle order for the touchscreen binding
should probably be specified (if it's not already) and that should let
us establish the ordering of channels. 

> +	x = touch_info[3];
> +	z2 = touch_info[2];
> +	z1 = touch_info[1];
> +	y = touch_info[0];
> +
> +	if (z1) {
> +		Rt = z2;

So for this we are going to need to define it in a generic fashion - probably
via a mode + coefficients in DT?

> +		Rt -= z1;
> +		Rt *= 800;
> +		//Rt *= ts->x_plate_ohms;
> +		Rt = DIV_ROUND_CLOSEST(Rt, 16);
> +		Rt *= x;
> +		Rt /= z1;
> +		Rt = DIV_ROUND_CLOSEST(Rt, 256);
> +	} else
> +		Rt = 0x400;
> +
>  	if (st->pressure)
> -		press = touch_info[2];
> +		press = Rt;
>  
> -	if ((!x && !y) || (st->pressure && (press < st->pressure_min))) {
> +	//printk("%s:%i: x: %x, y %x, z1: %x, z2: %x, press: %x\n", __func__, __LINE__, x, y, z1, z2, press);
> +	//if ((!x && !y) || (st->pressure && (press < st->pressure_min))) {
> +	if ((!x && !y) || (st->pressure && (press > 0x350))) {
>  		/* report end of touch */
>  		input_report_key(st->input, BTN_TOUCH, 0);
>  		input_sync(st->input);
> @@ -116,7 +135,7 @@ static int grts_probe(struct platform_device *pdev)
>  	}
>  
>  	chan = &st->iio_chans[0];
> -	st->pressure = false;
> +	st->pressure = true;
>  	while (chan && chan->indio_dev) {
>  
> 
> 
> > There are quite a few things in here that feel pretty specific to the touchscreen
> > usecase. That makes me wonder if this is a sensible approach or not.  
> 
> I'm sure it is the right way to go. Here is why:
> 
> A typical resistive touchscreen can be described as 2 resistors (plates)
> shorted to each other on pressure:
> 
>           o Y+
>           |
>           #
> 	  #
>           # /---- shorted on pressure
>           |/
> o---###---+---###--o
> X-        |        X+
>           #
>           #
>           #
>           |
>           o Y-
> 
> 
> To find the location of shorted circuit (finger position) we need to
> measure voltage on different points of the circuit:
> - to get X-position, apply voltage on X+/X- and measure voltage on Y+
> - to get Y-position, apply voltage on Y+/Y- and measure voltage on X+
> 
> Measuring the "pressure" is a bit more tricky:
> - apply voltage on X-/Y+ and measure on X+ and Y-, so we will get Z1 and
>   Z2
> - will need to know real plate resistance to do following calculation:
>   Rtouch = Rx-plate * (X-position / 4096) * (Z2/Z1 - 1)
> 
> There is is still more points which share all resistive touchscreens:
> - they have parasitic capacitance, so it take some time between
>   switching to voltage on and usable measurements
> - they act as antenna, so we measure different kind of electrical noise
> - we have low-frequency mechanical waves on the plates which can trigger
>   some bounce artifacts
> - the results will change depending on the temperature and the supply
>   voltage. So we need to monitor both of them to adjust our results.
> 
> To handle this issues we need to skip some samples until voltage is
> settled, we need to apply some simple digital low-pass filter to
> reduce the noise and add some corrections if we are able to measure
> system temperature and voltage.
> 
> All of described measurements are more or less touchscreen and not
> touch controller specific. IMO, resistive-adc-touch provide proper
> abstraction separation and should be a long therm - way to go :)
> 
> Now is the question, what is TSC2046? Please see the block diagram on
> page 10:
> https://www.ti.com/lit/ds/symlink/tsc2046.pdf
> 
> If I oversimplify this diagram, this controller is an ADC with 3 pin
> muxes:
> - ADC input mux
> - termistor mux chained after ADC mux
> - voltage output mux
> 
> all touchscreen specific code within this driver can be moved to the
> resistive-adc-touch, but need some optimization or discussion on how
> this should be done properly. 

ok.  There is definitely an argument in favour of generic code.  Whether
the method of IIO provider and touch screen driver consumer makes sense
is a little less clear but it's certainly a reasonable option.

> 
> > Jonathan
> >   
> > > ---
> > >  MAINTAINERS                  |   8 +
> > >  drivers/iio/adc/Kconfig      |  12 +
> > >  drivers/iio/adc/Makefile     |   1 +
> > >  drivers/iio/adc/ti-tsc2046.c | 652 +++++++++++++++++++++++++++++++++++
> > >  4 files changed, 673 insertions(+)
> > >  create mode 100644 drivers/iio/adc/ti-tsc2046.c
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 3fea1a934b32..2d33c6442a55 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -17852,6 +17852,14 @@ S:	Supported
> > >  F:	Documentation/devicetree/bindings/net/nfc/trf7970a.txt
> > >  F:	drivers/nfc/trf7970a.c
> > >  
> > > +TI TSC2046 ADC DRIVER
> > > +M:	Oleksij Rempel <o.rempel@pengutronix.de>
> > > +R:	kernel@pengutronix.de
> > > +L:	linux-iio@vger.kernel.org
> > > +S:	Maintained
> > > +F:	Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
> > > +F:	drivers/iio/adc/ti-tsc2046.c
> > > +
> > >  TI TWL4030 SERIES SOC CODEC DRIVER
> > >  M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
> > >  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 15587a1bc80d..6ad6f04dfd20 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -1175,6 +1175,18 @@ config TI_TLC4541
> > >  	  This driver can also be built as a module. If so, the module will be
> > >  	  called ti-tlc4541.
> > >  
> > > +config TI_TSC2046
> > > +	tristate "Texas Instruments TSC2046 ADC driver"
> > > +	depends on SPI
> > > +	select IIO_BUFFER
> > > +	select IIO_TRIGGERED_BUFFER
> > > +	help
> > > +	  Say yes here to build support for ADC functionality of Texas
> > > +	  Instruments TSC2046 touch screen controller.
> > > +
> > > +	  This driver can also be built as a module. If so, the module will be
> > > +	  called ti-tsc2046.
> > > +
> > >  config TWL4030_MADC
> > >  	tristate "TWL4030 MADC (Monitoring A/D Converter)"
> > >  	depends on TWL4030_CORE
> > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > index 5fca90ada0ec..440e18ac6780 100644
> > > --- a/drivers/iio/adc/Makefile
> > > +++ b/drivers/iio/adc/Makefile
> > > @@ -105,6 +105,7 @@ obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
> > >  obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
> > >  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
> > >  obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
> > > +obj-$(CONFIG_TI_TSC2046) += ti-tsc2046.o
> > >  obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
> > >  obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
> > >  obj-$(CONFIG_VF610_ADC) += vf610_adc.o
> > > diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> > > new file mode 100644
> > > index 000000000000..e119e7c31fa7
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/ti-tsc2046.c
> > > @@ -0,0 +1,652 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Texas Instruments TSC2046 SPI ADC driver
> > > + *
> > > + * Copyright (c) 2021 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
> > > + */
> > > +
> > > +#include <asm/unaligned.h>  
> > 
> > I'd prefer the more specific include after the generic linux
> > ones.  
> 
> ok. i just like to sort it alphabetically, it makes patching easier :)
> 
> >   
> > > +#include <linux/bitfield.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/iio/buffer.h>
> > > +#include <linux/iio/trigger_consumer.h>
> > > +#include <linux/iio/triggered_buffer.h>
> > > +#include <linux/iio/trigger.h>
> > > +#include <linux/module.h>
> > > +#include <linux/spi/spi.h>
> > > +
> > > +#define TI_TSC2046_NAME				"tsc2046"
> > > +
> > > +/* this driver doesn't aim at the peak continuous sample rate */
> > > +#define	TI_TSC2046_MAX_SAMPLE_RATE		125000
> > > +#define	TI_TSC2046_SAMPLE_BITS			(8 /*cmd*/ + 16 /*sample*/)
> > > +#define	TI_TSC2046_MAX_CLK_FREQ \
> > > +	(TI_TSC2046_MAX_SAMPLE_RATE * TI_TSC2046_SAMPLE_BITS)
> > > +
> > > +/*
> > > + * Default settling time. This time depends on the:
> > > + * - PCB design
> > > + * - touch plates size, temperature, etc
> > > + * - initial power state of the ADC
> > > + *
> > > + * Since most values higher than 100us seems to be good, it make sense to
> > > + * have some default value. These values were measuring get by testing on a
> > > + * PLYM2M board at 2MHz SPI CLK rate.
> > > + *
> > > + * Sometimes there are extra signal filter capacitors on the touchscreen
> > > + * signals, which make it 10 or 100 times worse.  
> > 
> > Sounds like something that makes sense to expose in dt?  
> 
> yes. we need to discuss what is the proper place. Is it possible to
> grub enough buffers in CPU effective way withing one SPI transfer and
> then hand over it to the resistive-adc-touch driver?
> 
> I placed it within ADC driver for optimization. IMO, proper place should
> be resistive-adc-touch driver.

It isn't that unusual to have a generic ADC that needs some settling time
before a good result is obtained, so it might be fine to keep an element of
that in the ADC driver, perhaps even defining a standard interface to do
it.   It is a somewhat similar requirement to oversampling, just that you
drop the first N samples rather than averaging them.


> 
> > > + */
> > > +#define TI_TSC2046_SETTLING_TIME_XYZ_DEF_US	700
> > > +/* Oversampling count for the low-pass filter */
> > > +#define TI_TSC2046_SAMPLES_XYZ_DEF		5
> > > +/* Default sample interval */
> > > +#define TI_TSC2046_SAMPLE_INTERVAL_US		10000
> > > +
> > > +#define TI_TSC2046_START			BIT(7)
> > > +#define TI_TSC2046_ADDR				GENMASK(6, 4)
> > > +#define TI_TSC2046_ADDR_TEMP1			7
> > > +#define TI_TSC2046_ADDR_AUX			6
> > > +#define TI_TSC2046_ADDR_X			5
> > > +#define TI_TSC2046_ADDR_Z2			4
> > > +#define TI_TSC2046_ADDR_Z1			3
> > > +#define TI_TSC2046_ADDR_VBAT			2
> > > +#define TI_TSC2046_ADDR_Y			1
> > > +#define TI_TSC2046_ADDR_TEMP0			0
> > > +
> > > +/*
> > > + * The mode bit sets the resolution of the ADC. With this bit low, the next
> > > + * conversion has 12-bit resolution, whereas with this bit high, the next
> > > + * conversion has 8-bit resolution. This driver is optimized for 12-bit mode.
> > > + * So, for this driver, this bit should stay zero.
> > > + */
> > > +#define TI_TSC2046_8BIT_MODE			BIT(3)
> > > +
> > > +/*
> > > + * SER/DFR - The SER/DFR bit controls the reference mode, either single-ended
> > > + * (high) or differential (low).
> > > + */
> > > +#define TI_TSC2046_SER				BIT(2)
> > > +
> > > +/*
> > > + * If VREF_ON and ADC_ON are both zero, then the chip operates in
> > > + * auto-wake/suspend mode. In most case this bits should stay zero.
> > > + */
> > > +#define TI_TSC2046_PD1_VREF_ON			BIT(1)
> > > +#define TI_TSC2046_PD0_ADC_ON			BIT(0)
> > > +
> > > +#define TI_TSC2046_MAX_CHAN			8
> > > +
> > > +#define TI_TSC2046_TIMESTAMP_SIZE		(sizeof(int64_t) / sizeof(int16_t))
> > > +
> > > +/* represents a HW sample */
> > > +struct tsc2046_adc_atom {
> > > +	u8 cmd;
> > > +	__be16 data;
> > > +} __packed;
> > > +
> > > +/* layout of atomic buffers within big buffer */
> > > +struct tsc2046_adc_group_layout {
> > > +	unsigned int offset;
> > > +	unsigned int count;
> > > +	unsigned int skip;
> > > +};
> > > +
> > > +struct tsc2046_adc_dcfg {
> > > +	const struct iio_chan_spec *channels;
> > > +	unsigned int num_channels;
> > > +};
> > > +
> > > +struct tsc2046_adc_priv {
> > > +	struct spi_device *spi;
> > > +	struct iio_trigger *trig;
> > > +	const struct tsc2046_adc_dcfg *dcfg;
> > > +
> > > +	struct spi_transfer xfer;
> > > +	struct spi_message msg;
> > > +
> > > +	u16 scan_buf[TI_TSC2046_MAX_CHAN + 2 + TI_TSC2046_TIMESTAMP_SIZE];  
> > 
> > buffers passed to iio_push_buffers_with_timestamp() have to be aligned such
> > that he s64 timestamp will be naturally aligned.
> > 
> > __aligned(8) or something like that will work here.
> > 
> > I need to get back to clearing out the last few drivers that don't do
> > this and start enforcing it at runtime.  
> 
> ok
> 
> > > +	/*
> > > +	 * Lock to protect the layout and the spi transfer buffer.
> > > +	 * tsc2046_adc_group_layout can be changed within update_scan_mode(),
> > > +	 * in this case the l[] and tx/rx buffer will be out of sync to each
> > > +	 * other.
> > > +	 */
> > > +	struct mutex slock;
> > > +	struct tsc2046_adc_group_layout l[TI_TSC2046_MAX_CHAN];
> > > +	struct tsc2046_adc_atom *rx;
> > > +	struct tsc2046_adc_atom *tx;
> > > +
> > > +	unsigned int count;
> > > +	unsigned int groups;
> > > +	u32 effective_speed_hz;
> > > +	u32 scan_interval_us;
> > > +	u32 time_per_scan_us;
> > > +	u32 time_per_bit_ns;
> > > +};
> > > +
> > > +#define TI_TSC2046_V_CHAN(index, bits, name)			\
> > > +{								\
> > > +	.type = IIO_VOLTAGE,					\
> > > +	.indexed = 1,						\
> > > +	.channel = index,					\
> > > +	.address = index,					\
> > > +	.datasheet_name = "#name",				\
> > > +	.scan_index = index,					\
> > > +	.scan_type = {						\
> > > +		.sign = 'u',					\
> > > +		.realbits = bits,				\
> > > +		.storagebits = 16,				\
> > > +		.shift = 0,					\
> > > +		.endianness = IIO_CPU,				\
> > > +	},							\
> > > +}
> > > +
> > > +#define DECLARE_TI_TSC2046_8_CHANNELS(name, bits) \
> > > +const struct iio_chan_spec name ## _channels[] = { \
> > > +	TI_TSC2046_V_CHAN(0, bits, TEMP0), \
> > > +	TI_TSC2046_V_CHAN(1, bits, Y), \
> > > +	TI_TSC2046_V_CHAN(2, bits, VBAT), \
> > > +	TI_TSC2046_V_CHAN(3, bits, Z1), \
> > > +	TI_TSC2046_V_CHAN(4, bits, Z2), \
> > > +	TI_TSC2046_V_CHAN(5, bits, X), \
> > > +	TI_TSC2046_V_CHAN(6, bits, AUX), \
> > > +	TI_TSC2046_V_CHAN(7, bits, TEMP1), \
> > > +	IIO_CHAN_SOFT_TIMESTAMP(8), \
> > > +}
> > > +
> > > +static DECLARE_TI_TSC2046_8_CHANNELS(tsc2046_adc, 12);
> > > +
> > > +static const struct tsc2046_adc_dcfg tsc2046_adc_dcfg_tsc2046e = {
> > > +	.channels = tsc2046_adc_channels,
> > > +	.num_channels = ARRAY_SIZE(tsc2046_adc_channels),
> > > +};
> > > +
> > > +/*
> > > + * Convert time to a number of samples which can be transferred within this
> > > + * time.
> > > + */
> > > +static unsigned int tsc2046_adc_time_to_count(struct tsc2046_adc_priv *priv,
> > > +					      unsigned long time)
> > > +{
> > > +	unsigned int bit_count, sample_count;
> > > +
> > > +	bit_count = DIV_ROUND_UP(time * NSEC_PER_USEC, priv->time_per_bit_ns);
> > > +	sample_count = DIV_ROUND_UP(bit_count, TI_TSC2046_SAMPLE_BITS);
> > > +
> > > +	dev_dbg(&priv->spi->dev, "%s effective speed %u, time per bit: %u, count bits: %u, count samples: %u\n",
> > > +		__func__, priv->effective_speed_hz, priv->time_per_bit_ns,
> > > +		bit_count, sample_count);
> > > +
> > > +	return sample_count;
> > > +}
> > > +
> > > +/*
> > > + * In case this ADC is attached to a touchscreen, some channels will need more
> > > + * time to provide usable data than other channels.
> > > + */
> > > +static unsigned int tsc2046_adc_get_settle_count(struct tsc2046_adc_priv *priv,
> > > +						 int ch_idx)
> > > +{
> > > +	u32 settle_time;
> > > +
> > > +	switch (ch_idx) {
> > > +	case TI_TSC2046_ADDR_X:
> > > +	case TI_TSC2046_ADDR_Y:
> > > +	case TI_TSC2046_ADDR_Z1:
> > > +	case TI_TSC2046_ADDR_Z2:
> > > +		settle_time = TI_TSC2046_SETTLING_TIME_XYZ_DEF_US;
> > > +		break;
> > > +	default:
> > > +		settle_time = 0;
> > > +	}
> > > +
> > > +	return tsc2046_adc_time_to_count(priv, settle_time);
> > > +}
> > > +
> > > +static u8 tsc2046_adc_get_cmd(struct tsc2046_adc_priv *priv, int ch_idx,
> > > +			      bool keep_power)
> > > +{
> > > +	u32 pd = 0; /* power down (pd) bits */
> > > +
> > > +	/*
> > > +	 * if PD bits are 0, controller will automatically disable ADC, VREF and
> > > +	 * enable IRQ.
> > > +	 */
> > > +	if (keep_power)
> > > +		pd = TI_TSC2046_PD0_ADC_ON;
> > > +
> > > +	return TI_TSC2046_START | FIELD_PREP(TI_TSC2046_ADDR, ch_idx) | pd;
> > > +}
> > > +
> > > +static u16 tsc2046_adc_get_value(struct tsc2046_adc_atom *buf)
> > > +{
> > > +	/* last 3 bits on the wire are empty */
> > > +	return get_unaligned_be16(&buf->data) >> 3;
> > > +}
> > > +
> > > +static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
> > > +				u32 *effective_speed_hz)
> > > +{
> > > +	struct tsc2046_adc_atom tx_buf, rx_buf;  
> > 
> > Can't safely do spi transfers to buffers on the stack.
> > If you dig around in the docs you'll discover the buffers must be DMA safe.  
> 
> ack
> 
> >   
> > > +	struct spi_transfer xfer;
> > > +	struct spi_message msg;
> > > +	int ret;
> > > +
> > > +	memset(&xfer, 0, sizeof(xfer));
> > > +	tx_buf.cmd = tsc2046_adc_get_cmd(priv, ch_idx, false);
> > > +	tx_buf.data = 0;
> > > +	xfer.tx_buf = &tx_buf;
> > > +	xfer.rx_buf = &rx_buf;
> > > +	xfer.len = sizeof(tx_buf);
> > > +	spi_message_init(&msg);
> > > +	spi_message_add_tail(&xfer, &msg);
> > > +
> > > +	ret = spi_sync(priv->spi, &msg);
> > > +	if (ret) {
> > > +		dev_err_ratelimited(&priv->spi->dev, "%s: SPI transfer filed %pe\n",
> > > +				    __func__, ERR_PTR(ret));
> > > +		return ret;
> > > +	}
> > > +
> > > +	if (effective_speed_hz)
> > > +		*effective_speed_hz = xfer.effective_speed_hz;
> > > +
> > > +	return tsc2046_adc_get_value(&rx_buf);
> > > +}
> > > +
> > > +static size_t tsc2046_adc_group_set_layout(struct tsc2046_adc_priv *priv,
> > > +					   unsigned int group,
> > > +					   unsigned int ch_idx)
> > > +{
> > > +	struct tsc2046_adc_group_layout *l = &priv->l[group];
> > > +	unsigned int max_count, count_skip;
> > > +	unsigned int offset = 0;
> > > +
> > > +	count_skip = tsc2046_adc_get_settle_count(priv, ch_idx);
> > > +
> > > +	if (group != 0) {
> > > +		l = &priv->l[group - 1];
> > > +		offset = l->offset + l->count;
> > > +	}
> > > +
> > > +	l = &priv->l[group];
> > > +
> > > +	max_count = count_skip + TI_TSC2046_SAMPLES_XYZ_DEF;
> > > +
> > > +	l->offset = offset;
> > > +	l->count = max_count;
> > > +	l->skip = count_skip;
> > > +
> > > +	return sizeof(*priv->tx) * max_count;
> > > +}
> > > +
> > > +static void tsc2046_adc_group_set_cmd(struct tsc2046_adc_priv *priv,
> > > +				      unsigned int group, int ch_idx)
> > > +{
> > > +	struct tsc2046_adc_group_layout *l = &priv->l[group];
> > > +	unsigned int i;
> > > +	u8 cmd;
> > > +
> > > +	/*
> > > +	 * Do not enable automatic power down on working samples. Otherwise the
> > > +	 * plates will never be completely charged.
> > > +	 */
> > > +	cmd = tsc2046_adc_get_cmd(priv, ch_idx, true);
> > > +
> > > +	for (i = 0; i < l->count - 1; i++)
> > > +		priv->tx[l->offset + i].cmd = cmd;
> > > +
> > > +	/* automatically power down on last sample */
> > > +	priv->tx[l->offset + i].cmd = tsc2046_adc_get_cmd(priv, ch_idx, false);
> > > +}
> > > +
> > > +static int tsc2046_adc_get_valide_val(struct tsc2046_adc_priv *priv,
> > > +				      int group)
> > > +{
> > > +	struct tsc2046_adc_group_layout *l;
> > > +	struct tsc2046_adc_atom *tx;
> > > +	int ch_idx, valid_count, i;
> > > +	unsigned int val, val_normalized = 0;
> > > +
> > > +	l = &priv->l[group];
> > > +	tx = &priv->tx[l->offset + l->skip];
> > > +	ch_idx = FIELD_GET(TI_TSC2046_ADDR, tx->cmd);
> > > +
> > > +	valid_count = l->count - l->skip;
> > > +	for (i = 0; i < valid_count; i++) {
> > > +		val = tsc2046_adc_get_value(&priv->rx[l->offset + l->skip + i]);
> > > +		/*
> > > +		 * Following values are possible only if touch is not in active
> > > +		 * state. No pressure on plates.  
> > 
> > Given we are treating this as a generic ADC these could happen?  
> 
> in case of generic ADC we would not need it. It is only optimization for
> the toucschreen case.
> 
> > > +		 */
> > > +		switch (ch_idx) {
> > > +		case TI_TSC2046_ADDR_Y:
> > > +			if (val == 0xfff)
> > > +				return -EAGAIN;
> > > +			break;
> > > +		case TI_TSC2046_ADDR_X:
> > > +			if (!val)
> > > +				return -EAGAIN;
> > > +			break;
> > > +		}
> > > +
> > > +		val_normalized += val;
> > > +	}
> > > +
> > > +	return DIV_ROUND_UP(val_normalized, valid_count);
> > > +}
> > > +
> > > +static int tsc2046_adc_scan(struct iio_dev *indio_dev)
> > > +{
> > > +	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> > > +	struct device *dev = &priv->spi->dev;
> > > +	bool valid = true;
> > > +	int group;
> > > +	int ret;
> > > +
> > > +	ret = spi_sync(priv->spi, &priv->msg);
> > > +	if (ret < 0) {
> > > +		dev_err_ratelimited(dev, "%s: SPI transfer filed: %pe\n",
> > > +				    __func__, ERR_PTR(ret));
> > > +		return ret;
> > > +	}
> > > +
> > > +	for (group = 0; group < priv->groups; group++) {
> > > +		if (valid) {
> > > +			/*
> > > +			 * Validate data to stop sampling and reduce power
> > > +			 * consumption.
> > > +			 */  
> > 
> > This is looking very touch screen specific.  That makes me doubt that
> > the approach of having this as an IIO driver makes sense.  
> 
> I hope you have no more doubts after my explanation in the top of the
> email.
> 
> > > +			ret = tsc2046_adc_get_valide_val(priv, group);  
> > 
> > valid_val?  
> 
> sounds good, but may be will be dropped or moved to the toucscreen
> driver
> 
> > > +			if (ret < 0) {
> > > +				/* go back and invalidate all channels */
> > > +				group = 0;
> > > +				valid = false;
> > > +			}
> > > +		} else {
> > > +			ret = 0xffff;
> > > +		}
> > > +
> > > +		priv->scan_buf[group] = ret;
> > > +	}
> > > +
> > > +	ret = iio_push_to_buffers_with_timestamp(indio_dev, &priv->scan_buf,
> > > +						 iio_get_time_ns(indio_dev));
> > > +	/*
> > > +	 * If there's no consumer (or consumer is too slow), we'll get a EBUSY
> > > +	 * here - ignore it.  
> > 
> > If using an in kernel consumer, it will be synchronous so too slow would be
> > odd.  For a kfifo it could indeed happen.  
> 
> ack
> 
> > > +	 */
> > > +	if (ret < 0 && ret != -EBUSY) {
> > > +		dev_err_ratelimited(dev, "%s: Filed to push scan buffer %pe\n",  
> > failed  
> > > +				    __func__, ERR_PTR(ret));
> > > +
> > > +		return ret;
> > > +	}
> > > +
> > > +	return valid ? 0 : -EAGAIN;  
> > 
> > If not valid, why are we pushing it to the buffer?  
> 
> The touchscreen driver will classify this buffer as finger-up event.
> and the ADC driver need to know it to stop sampling.

That is a fairly specific thing to do.  Does the existing 
touch screen driver do that, or it that a proposed change?

> 
> 
> > > +}
> > > +

...


> > > +static const struct iio_info tsc2046_adc_info = {
> > > +	.update_scan_mode = tsc2046_adc_update_scan_mode,
> > > +};
> > > +
> > > +static irqreturn_t tsc2046_adc_irq(int irq, void *dev_id)
> > > +{
> > > +	struct iio_dev *indio_dev = dev_id;
> > > +	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> > > +
> > > +	iio_trigger_poll_chained(priv->trig);
> > > +  
> > 
> > Given you aren't doing anything in here, why run it in the threaded
> > handler?  That somewhat restricts usecases for the trigger (should
> > you want to do something crazy later like slave some other data capture
> > off this trigger)...  
> 
> Isn't the trigger poller function executed in the same context?

If you were to make this a non threaded handler, the poll handler in this
driver will indeed run in the same context, but in theory another
device might be connected to the same trigger.  That one might have
a non threaded handler which would not be called using
iio_trigger_poll_chained().

So generally, unless a driver needs to sleep or do something complex,
it's better to call iio_trigger_poll() from the non threaded
handler.

For many usecases it obviously won't make any difference at all
because there will be no 'top half' interrupts registered and it
will just end up calling the threaded parts anyway.

> 
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
...
