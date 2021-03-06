Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A85932FAD9
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 14:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhCFN3b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 08:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhCFN3J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Mar 2021 08:29:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB31C06174A
        for <linux-iio@vger.kernel.org>; Sat,  6 Mar 2021 05:29:09 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lIWzH-0003ml-6W; Sat, 06 Mar 2021 14:28:55 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lIWzE-0001Hy-76; Sat, 06 Mar 2021 14:28:52 +0100
Date:   Sat, 6 Mar 2021 14:28:52 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 2/2] iio: adc: add ADC driver for the TI TSC2046
 controller
Message-ID: <20210306132852.s2vzotnadanoo2na@pengutronix.de>
References: <20210305133813.27967-1-o.rempel@pengutronix.de>
 <20210305133813.27967-3-o.rempel@pengutronix.de>
 <20210305190239.000075fe@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210305190239.000075fe@Huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:30:22 up 93 days, 22:36, 43 users,  load average: 0.08, 0.02,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 05, 2021 at 07:02:39PM +0000, Jonathan Cameron wrote:
> On Fri, 5 Mar 2021 14:38:13 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> > the touchscreen use case. By implementing it as IIO ADC device, we can
> > make use of resistive-adc-touch and iio-hwmon drivers.
> > 
> > So far, this driver was tested with custom version of resistive-adc-touch driver,
> > since it need to be extended to make use of Z1 and Z2 channels. The X/Y
> > are working without additional changes.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> Hi Oleksij,
> 
> To consider this as a possible long term route instead of just making this
> a touchscreen driver, we'll want to see those mods to the resistive-adc-touch.
> Of course that doesn't stop review of this in the meantime.

ok.

I had following issues with the existing resistive-adc-touch driver:
- the buffer layout is not configurable over DT or i didn't understood
  how to properly configure it
- the "pressure" channel provide pre processed data driver or
  controller, this information cannot be extracted directly from the
  touchscreen plates.

I did following changes to make it work for my use case:

--- a/drivers/input/touchscreen/resistive-adc-touch.c
+++ b/drivers/input/touchscreen/resistive-adc-touch.c
@@ -44,15 +44,34 @@ static int grts_cb(const void *data, void *private)
 {
 	const u16 *touch_info = data;
 	struct grts_state *st = private;
-	unsigned int x, y, press = 0x0;
+	unsigned int x, y, press = 0x0, z1, z2;
+	unsigned int Rt;
 
 	/* channel data coming in buffer in the order below */
-	x = touch_info[0];
-	y = touch_info[1];
+	// TODO: make sure we get buffers in proper order
+	x = touch_info[3];
+	z2 = touch_info[2];
+	z1 = touch_info[1];
+	y = touch_info[0];
+
+	if (z1) {
+		Rt = z2;
+		Rt -= z1;
+		Rt *= 800;
+		//Rt *= ts->x_plate_ohms;
+		Rt = DIV_ROUND_CLOSEST(Rt, 16);
+		Rt *= x;
+		Rt /= z1;
+		Rt = DIV_ROUND_CLOSEST(Rt, 256);
+	} else
+		Rt = 0x400;
+
 	if (st->pressure)
-		press = touch_info[2];
+		press = Rt;
 
-	if ((!x && !y) || (st->pressure && (press < st->pressure_min))) {
+	//printk("%s:%i: x: %x, y %x, z1: %x, z2: %x, press: %x\n", __func__, __LINE__, x, y, z1, z2, press);
+	//if ((!x && !y) || (st->pressure && (press < st->pressure_min))) {
+	if ((!x && !y) || (st->pressure && (press > 0x350))) {
 		/* report end of touch */
 		input_report_key(st->input, BTN_TOUCH, 0);
 		input_sync(st->input);
@@ -116,7 +135,7 @@ static int grts_probe(struct platform_device *pdev)
 	}
 
 	chan = &st->iio_chans[0];
-	st->pressure = false;
+	st->pressure = true;
 	while (chan && chan->indio_dev) {
 


> There are quite a few things in here that feel pretty specific to the touchscreen
> usecase. That makes me wonder if this is a sensible approach or not.

I'm sure it is the right way to go. Here is why:

A typical resistive touchscreen can be described as 2 resistors (plates)
shorted to each other on pressure:

          o Y+
          |
          #
	  #
          # /---- shorted on pressure
          |/
o---###---+---###--o
X-        |        X+
          #
          #
          #
          |
          o Y-


To find the location of shorted circuit (finger position) we need to
measure voltage on different points of the circuit:
- to get X-position, apply voltage on X+/X- and measure voltage on Y+
- to get Y-position, apply voltage on Y+/Y- and measure voltage on X+

Measuring the "pressure" is a bit more tricky:
- apply voltage on X-/Y+ and measure on X+ and Y-, so we will get Z1 and
  Z2
- will need to know real plate resistance to do following calculation:
  Rtouch = Rx-plate * (X-position / 4096) * (Z2/Z1 - 1)

There is is still more points which share all resistive touchscreens:
- they have parasitic capacitance, so it take some time between
  switching to voltage on and usable measurements
- they act as antenna, so we measure different kind of electrical noise
- we have low-frequency mechanical waves on the plates which can trigger
  some bounce artifacts
- the results will change depending on the temperature and the supply
  voltage. So we need to monitor both of them to adjust our results.

To handle this issues we need to skip some samples until voltage is
settled, we need to apply some simple digital low-pass filter to
reduce the noise and add some corrections if we are able to measure
system temperature and voltage.

All of described measurements are more or less touchscreen and not
touch controller specific. IMO, resistive-adc-touch provide proper
abstraction separation and should be a long therm - way to go :)

Now is the question, what is TSC2046? Please see the block diagram on
page 10:
https://www.ti.com/lit/ds/symlink/tsc2046.pdf

If I oversimplify this diagram, this controller is an ADC with 3 pin
muxes:
- ADC input mux
- termistor mux chained after ADC mux
- voltage output mux

all touchscreen specific code within this driver can be moved to the
resistive-adc-touch, but need some optimization or discussion on how
this should be done properly. 

> Jonathan
> 
> > ---
> >  MAINTAINERS                  |   8 +
> >  drivers/iio/adc/Kconfig      |  12 +
> >  drivers/iio/adc/Makefile     |   1 +
> >  drivers/iio/adc/ti-tsc2046.c | 652 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 673 insertions(+)
> >  create mode 100644 drivers/iio/adc/ti-tsc2046.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3fea1a934b32..2d33c6442a55 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17852,6 +17852,14 @@ S:	Supported
> >  F:	Documentation/devicetree/bindings/net/nfc/trf7970a.txt
> >  F:	drivers/nfc/trf7970a.c
> >  
> > +TI TSC2046 ADC DRIVER
> > +M:	Oleksij Rempel <o.rempel@pengutronix.de>
> > +R:	kernel@pengutronix.de
> > +L:	linux-iio@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
> > +F:	drivers/iio/adc/ti-tsc2046.c
> > +
> >  TI TWL4030 SERIES SOC CODEC DRIVER
> >  M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
> >  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 15587a1bc80d..6ad6f04dfd20 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -1175,6 +1175,18 @@ config TI_TLC4541
> >  	  This driver can also be built as a module. If so, the module will be
> >  	  called ti-tlc4541.
> >  
> > +config TI_TSC2046
> > +	tristate "Texas Instruments TSC2046 ADC driver"
> > +	depends on SPI
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	help
> > +	  Say yes here to build support for ADC functionality of Texas
> > +	  Instruments TSC2046 touch screen controller.
> > +
> > +	  This driver can also be built as a module. If so, the module will be
> > +	  called ti-tsc2046.
> > +
> >  config TWL4030_MADC
> >  	tristate "TWL4030 MADC (Monitoring A/D Converter)"
> >  	depends on TWL4030_CORE
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 5fca90ada0ec..440e18ac6780 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -105,6 +105,7 @@ obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
> >  obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
> >  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
> >  obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
> > +obj-$(CONFIG_TI_TSC2046) += ti-tsc2046.o
> >  obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
> >  obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
> >  obj-$(CONFIG_VF610_ADC) += vf610_adc.o
> > diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> > new file mode 100644
> > index 000000000000..e119e7c31fa7
> > --- /dev/null
> > +++ b/drivers/iio/adc/ti-tsc2046.c
> > @@ -0,0 +1,652 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Texas Instruments TSC2046 SPI ADC driver
> > + *
> > + * Copyright (c) 2021 Oleksij Rempel <kernel@pengutronix.de>, Pengutronix
> > + */
> > +
> > +#include <asm/unaligned.h>
> 
> I'd prefer the more specific include after the generic linux
> ones.

ok. i just like to sort it alphabetically, it makes patching easier :)

> 
> > +#include <linux/bitfield.h>
> > +#include <linux/delay.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/module.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#define TI_TSC2046_NAME				"tsc2046"
> > +
> > +/* this driver doesn't aim at the peak continuous sample rate */
> > +#define	TI_TSC2046_MAX_SAMPLE_RATE		125000
> > +#define	TI_TSC2046_SAMPLE_BITS			(8 /*cmd*/ + 16 /*sample*/)
> > +#define	TI_TSC2046_MAX_CLK_FREQ \
> > +	(TI_TSC2046_MAX_SAMPLE_RATE * TI_TSC2046_SAMPLE_BITS)
> > +
> > +/*
> > + * Default settling time. This time depends on the:
> > + * - PCB design
> > + * - touch plates size, temperature, etc
> > + * - initial power state of the ADC
> > + *
> > + * Since most values higher than 100us seems to be good, it make sense to
> > + * have some default value. These values were measuring get by testing on a
> > + * PLYM2M board at 2MHz SPI CLK rate.
> > + *
> > + * Sometimes there are extra signal filter capacitors on the touchscreen
> > + * signals, which make it 10 or 100 times worse.
> 
> Sounds like something that makes sense to expose in dt?

yes. we need to discuss what is the proper place. Is it possible to
grub enough buffers in CPU effective way withing one SPI transfer and
then hand over it to the resistive-adc-touch driver?

I placed it within ADC driver for optimization. IMO, proper place should
be resistive-adc-touch driver.

> > + */
> > +#define TI_TSC2046_SETTLING_TIME_XYZ_DEF_US	700
> > +/* Oversampling count for the low-pass filter */
> > +#define TI_TSC2046_SAMPLES_XYZ_DEF		5
> > +/* Default sample interval */
> > +#define TI_TSC2046_SAMPLE_INTERVAL_US		10000
> > +
> > +#define TI_TSC2046_START			BIT(7)
> > +#define TI_TSC2046_ADDR				GENMASK(6, 4)
> > +#define TI_TSC2046_ADDR_TEMP1			7
> > +#define TI_TSC2046_ADDR_AUX			6
> > +#define TI_TSC2046_ADDR_X			5
> > +#define TI_TSC2046_ADDR_Z2			4
> > +#define TI_TSC2046_ADDR_Z1			3
> > +#define TI_TSC2046_ADDR_VBAT			2
> > +#define TI_TSC2046_ADDR_Y			1
> > +#define TI_TSC2046_ADDR_TEMP0			0
> > +
> > +/*
> > + * The mode bit sets the resolution of the ADC. With this bit low, the next
> > + * conversion has 12-bit resolution, whereas with this bit high, the next
> > + * conversion has 8-bit resolution. This driver is optimized for 12-bit mode.
> > + * So, for this driver, this bit should stay zero.
> > + */
> > +#define TI_TSC2046_8BIT_MODE			BIT(3)
> > +
> > +/*
> > + * SER/DFR - The SER/DFR bit controls the reference mode, either single-ended
> > + * (high) or differential (low).
> > + */
> > +#define TI_TSC2046_SER				BIT(2)
> > +
> > +/*
> > + * If VREF_ON and ADC_ON are both zero, then the chip operates in
> > + * auto-wake/suspend mode. In most case this bits should stay zero.
> > + */
> > +#define TI_TSC2046_PD1_VREF_ON			BIT(1)
> > +#define TI_TSC2046_PD0_ADC_ON			BIT(0)
> > +
> > +#define TI_TSC2046_MAX_CHAN			8
> > +
> > +#define TI_TSC2046_TIMESTAMP_SIZE		(sizeof(int64_t) / sizeof(int16_t))
> > +
> > +/* represents a HW sample */
> > +struct tsc2046_adc_atom {
> > +	u8 cmd;
> > +	__be16 data;
> > +} __packed;
> > +
> > +/* layout of atomic buffers within big buffer */
> > +struct tsc2046_adc_group_layout {
> > +	unsigned int offset;
> > +	unsigned int count;
> > +	unsigned int skip;
> > +};
> > +
> > +struct tsc2046_adc_dcfg {
> > +	const struct iio_chan_spec *channels;
> > +	unsigned int num_channels;
> > +};
> > +
> > +struct tsc2046_adc_priv {
> > +	struct spi_device *spi;
> > +	struct iio_trigger *trig;
> > +	const struct tsc2046_adc_dcfg *dcfg;
> > +
> > +	struct spi_transfer xfer;
> > +	struct spi_message msg;
> > +
> > +	u16 scan_buf[TI_TSC2046_MAX_CHAN + 2 + TI_TSC2046_TIMESTAMP_SIZE];
> 
> buffers passed to iio_push_buffers_with_timestamp() have to be aligned such
> that he s64 timestamp will be naturally aligned.
> 
> __aligned(8) or something like that will work here.
> 
> I need to get back to clearing out the last few drivers that don't do
> this and start enforcing it at runtime.

ok

> > +	/*
> > +	 * Lock to protect the layout and the spi transfer buffer.
> > +	 * tsc2046_adc_group_layout can be changed within update_scan_mode(),
> > +	 * in this case the l[] and tx/rx buffer will be out of sync to each
> > +	 * other.
> > +	 */
> > +	struct mutex slock;
> > +	struct tsc2046_adc_group_layout l[TI_TSC2046_MAX_CHAN];
> > +	struct tsc2046_adc_atom *rx;
> > +	struct tsc2046_adc_atom *tx;
> > +
> > +	unsigned int count;
> > +	unsigned int groups;
> > +	u32 effective_speed_hz;
> > +	u32 scan_interval_us;
> > +	u32 time_per_scan_us;
> > +	u32 time_per_bit_ns;
> > +};
> > +
> > +#define TI_TSC2046_V_CHAN(index, bits, name)			\
> > +{								\
> > +	.type = IIO_VOLTAGE,					\
> > +	.indexed = 1,						\
> > +	.channel = index,					\
> > +	.address = index,					\
> > +	.datasheet_name = "#name",				\
> > +	.scan_index = index,					\
> > +	.scan_type = {						\
> > +		.sign = 'u',					\
> > +		.realbits = bits,				\
> > +		.storagebits = 16,				\
> > +		.shift = 0,					\
> > +		.endianness = IIO_CPU,				\
> > +	},							\
> > +}
> > +
> > +#define DECLARE_TI_TSC2046_8_CHANNELS(name, bits) \
> > +const struct iio_chan_spec name ## _channels[] = { \
> > +	TI_TSC2046_V_CHAN(0, bits, TEMP0), \
> > +	TI_TSC2046_V_CHAN(1, bits, Y), \
> > +	TI_TSC2046_V_CHAN(2, bits, VBAT), \
> > +	TI_TSC2046_V_CHAN(3, bits, Z1), \
> > +	TI_TSC2046_V_CHAN(4, bits, Z2), \
> > +	TI_TSC2046_V_CHAN(5, bits, X), \
> > +	TI_TSC2046_V_CHAN(6, bits, AUX), \
> > +	TI_TSC2046_V_CHAN(7, bits, TEMP1), \
> > +	IIO_CHAN_SOFT_TIMESTAMP(8), \
> > +}
> > +
> > +static DECLARE_TI_TSC2046_8_CHANNELS(tsc2046_adc, 12);
> > +
> > +static const struct tsc2046_adc_dcfg tsc2046_adc_dcfg_tsc2046e = {
> > +	.channels = tsc2046_adc_channels,
> > +	.num_channels = ARRAY_SIZE(tsc2046_adc_channels),
> > +};
> > +
> > +/*
> > + * Convert time to a number of samples which can be transferred within this
> > + * time.
> > + */
> > +static unsigned int tsc2046_adc_time_to_count(struct tsc2046_adc_priv *priv,
> > +					      unsigned long time)
> > +{
> > +	unsigned int bit_count, sample_count;
> > +
> > +	bit_count = DIV_ROUND_UP(time * NSEC_PER_USEC, priv->time_per_bit_ns);
> > +	sample_count = DIV_ROUND_UP(bit_count, TI_TSC2046_SAMPLE_BITS);
> > +
> > +	dev_dbg(&priv->spi->dev, "%s effective speed %u, time per bit: %u, count bits: %u, count samples: %u\n",
> > +		__func__, priv->effective_speed_hz, priv->time_per_bit_ns,
> > +		bit_count, sample_count);
> > +
> > +	return sample_count;
> > +}
> > +
> > +/*
> > + * In case this ADC is attached to a touchscreen, some channels will need more
> > + * time to provide usable data than other channels.
> > + */
> > +static unsigned int tsc2046_adc_get_settle_count(struct tsc2046_adc_priv *priv,
> > +						 int ch_idx)
> > +{
> > +	u32 settle_time;
> > +
> > +	switch (ch_idx) {
> > +	case TI_TSC2046_ADDR_X:
> > +	case TI_TSC2046_ADDR_Y:
> > +	case TI_TSC2046_ADDR_Z1:
> > +	case TI_TSC2046_ADDR_Z2:
> > +		settle_time = TI_TSC2046_SETTLING_TIME_XYZ_DEF_US;
> > +		break;
> > +	default:
> > +		settle_time = 0;
> > +	}
> > +
> > +	return tsc2046_adc_time_to_count(priv, settle_time);
> > +}
> > +
> > +static u8 tsc2046_adc_get_cmd(struct tsc2046_adc_priv *priv, int ch_idx,
> > +			      bool keep_power)
> > +{
> > +	u32 pd = 0; /* power down (pd) bits */
> > +
> > +	/*
> > +	 * if PD bits are 0, controller will automatically disable ADC, VREF and
> > +	 * enable IRQ.
> > +	 */
> > +	if (keep_power)
> > +		pd = TI_TSC2046_PD0_ADC_ON;
> > +
> > +	return TI_TSC2046_START | FIELD_PREP(TI_TSC2046_ADDR, ch_idx) | pd;
> > +}
> > +
> > +static u16 tsc2046_adc_get_value(struct tsc2046_adc_atom *buf)
> > +{
> > +	/* last 3 bits on the wire are empty */
> > +	return get_unaligned_be16(&buf->data) >> 3;
> > +}
> > +
> > +static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
> > +				u32 *effective_speed_hz)
> > +{
> > +	struct tsc2046_adc_atom tx_buf, rx_buf;
> 
> Can't safely do spi transfers to buffers on the stack.
> If you dig around in the docs you'll discover the buffers must be DMA safe.

ack

> 
> > +	struct spi_transfer xfer;
> > +	struct spi_message msg;
> > +	int ret;
> > +
> > +	memset(&xfer, 0, sizeof(xfer));
> > +	tx_buf.cmd = tsc2046_adc_get_cmd(priv, ch_idx, false);
> > +	tx_buf.data = 0;
> > +	xfer.tx_buf = &tx_buf;
> > +	xfer.rx_buf = &rx_buf;
> > +	xfer.len = sizeof(tx_buf);
> > +	spi_message_init(&msg);
> > +	spi_message_add_tail(&xfer, &msg);
> > +
> > +	ret = spi_sync(priv->spi, &msg);
> > +	if (ret) {
> > +		dev_err_ratelimited(&priv->spi->dev, "%s: SPI transfer filed %pe\n",
> > +				    __func__, ERR_PTR(ret));
> > +		return ret;
> > +	}
> > +
> > +	if (effective_speed_hz)
> > +		*effective_speed_hz = xfer.effective_speed_hz;
> > +
> > +	return tsc2046_adc_get_value(&rx_buf);
> > +}
> > +
> > +static size_t tsc2046_adc_group_set_layout(struct tsc2046_adc_priv *priv,
> > +					   unsigned int group,
> > +					   unsigned int ch_idx)
> > +{
> > +	struct tsc2046_adc_group_layout *l = &priv->l[group];
> > +	unsigned int max_count, count_skip;
> > +	unsigned int offset = 0;
> > +
> > +	count_skip = tsc2046_adc_get_settle_count(priv, ch_idx);
> > +
> > +	if (group != 0) {
> > +		l = &priv->l[group - 1];
> > +		offset = l->offset + l->count;
> > +	}
> > +
> > +	l = &priv->l[group];
> > +
> > +	max_count = count_skip + TI_TSC2046_SAMPLES_XYZ_DEF;
> > +
> > +	l->offset = offset;
> > +	l->count = max_count;
> > +	l->skip = count_skip;
> > +
> > +	return sizeof(*priv->tx) * max_count;
> > +}
> > +
> > +static void tsc2046_adc_group_set_cmd(struct tsc2046_adc_priv *priv,
> > +				      unsigned int group, int ch_idx)
> > +{
> > +	struct tsc2046_adc_group_layout *l = &priv->l[group];
> > +	unsigned int i;
> > +	u8 cmd;
> > +
> > +	/*
> > +	 * Do not enable automatic power down on working samples. Otherwise the
> > +	 * plates will never be completely charged.
> > +	 */
> > +	cmd = tsc2046_adc_get_cmd(priv, ch_idx, true);
> > +
> > +	for (i = 0; i < l->count - 1; i++)
> > +		priv->tx[l->offset + i].cmd = cmd;
> > +
> > +	/* automatically power down on last sample */
> > +	priv->tx[l->offset + i].cmd = tsc2046_adc_get_cmd(priv, ch_idx, false);
> > +}
> > +
> > +static int tsc2046_adc_get_valide_val(struct tsc2046_adc_priv *priv,
> > +				      int group)
> > +{
> > +	struct tsc2046_adc_group_layout *l;
> > +	struct tsc2046_adc_atom *tx;
> > +	int ch_idx, valid_count, i;
> > +	unsigned int val, val_normalized = 0;
> > +
> > +	l = &priv->l[group];
> > +	tx = &priv->tx[l->offset + l->skip];
> > +	ch_idx = FIELD_GET(TI_TSC2046_ADDR, tx->cmd);
> > +
> > +	valid_count = l->count - l->skip;
> > +	for (i = 0; i < valid_count; i++) {
> > +		val = tsc2046_adc_get_value(&priv->rx[l->offset + l->skip + i]);
> > +		/*
> > +		 * Following values are possible only if touch is not in active
> > +		 * state. No pressure on plates.
> 
> Given we are treating this as a generic ADC these could happen?

in case of generic ADC we would not need it. It is only optimization for
the toucschreen case.

> > +		 */
> > +		switch (ch_idx) {
> > +		case TI_TSC2046_ADDR_Y:
> > +			if (val == 0xfff)
> > +				return -EAGAIN;
> > +			break;
> > +		case TI_TSC2046_ADDR_X:
> > +			if (!val)
> > +				return -EAGAIN;
> > +			break;
> > +		}
> > +
> > +		val_normalized += val;
> > +	}
> > +
> > +	return DIV_ROUND_UP(val_normalized, valid_count);
> > +}
> > +
> > +static int tsc2046_adc_scan(struct iio_dev *indio_dev)
> > +{
> > +	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> > +	struct device *dev = &priv->spi->dev;
> > +	bool valid = true;
> > +	int group;
> > +	int ret;
> > +
> > +	ret = spi_sync(priv->spi, &priv->msg);
> > +	if (ret < 0) {
> > +		dev_err_ratelimited(dev, "%s: SPI transfer filed: %pe\n",
> > +				    __func__, ERR_PTR(ret));
> > +		return ret;
> > +	}
> > +
> > +	for (group = 0; group < priv->groups; group++) {
> > +		if (valid) {
> > +			/*
> > +			 * Validate data to stop sampling and reduce power
> > +			 * consumption.
> > +			 */
> 
> This is looking very touch screen specific.  That makes me doubt that
> the approach of having this as an IIO driver makes sense.

I hope you have no more doubts after my explanation in the top of the
email.

> > +			ret = tsc2046_adc_get_valide_val(priv, group);
> 
> valid_val?

sounds good, but may be will be dropped or moved to the toucscreen
driver

> > +			if (ret < 0) {
> > +				/* go back and invalidate all channels */
> > +				group = 0;
> > +				valid = false;
> > +			}
> > +		} else {
> > +			ret = 0xffff;
> > +		}
> > +
> > +		priv->scan_buf[group] = ret;
> > +	}
> > +
> > +	ret = iio_push_to_buffers_with_timestamp(indio_dev, &priv->scan_buf,
> > +						 iio_get_time_ns(indio_dev));
> > +	/*
> > +	 * If there's no consumer (or consumer is too slow), we'll get a EBUSY
> > +	 * here - ignore it.
> 
> If using an in kernel consumer, it will be synchronous so too slow would be
> odd.  For a kfifo it could indeed happen.

ack

> > +	 */
> > +	if (ret < 0 && ret != -EBUSY) {
> > +		dev_err_ratelimited(dev, "%s: Filed to push scan buffer %pe\n",
> failed
> > +				    __func__, ERR_PTR(ret));
> > +
> > +		return ret;
> > +	}
> > +
> > +	return valid ? 0 : -EAGAIN;
> 
> If not valid, why are we pushing it to the buffer?

The touchscreen driver will classify this buffer as finger-up event.
and the ADC driver need to know it to stop sampling.


> > +}
> > +
> > +static irqreturn_t tsc2046_adc_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> > +	unsigned int retry = 3;
> > +
> > +	do {
> > +		int ret, delta;
> > +
> > +		mutex_lock(&priv->slock);
> > +		ret = tsc2046_adc_scan(indio_dev);
> > +		mutex_unlock(&priv->slock);
> > +		if (ret)
> > +			goto done;
> > +
> > +		/*
> > +		 * We can sample it as fast as we can, but usually we do not
> > +		 * need so many samples. Reduce the sample rate for default
> > +		 * (touchscreen) use case.
> > +		 * Currently we do not need highly precise sample rate. It
> > +		 * is enough to have calculated numbers.
> > +		 */
> > +		delta = priv->scan_interval_us - priv->time_per_scan_us;
> > +		if (delta > 0)
> > +			fsleep(delta);
> > +	} while (retry--);
> > +
> > +done:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int tsc2046_adc_update_scan_mode(struct iio_dev *indio_dev,
> > +					const unsigned long *active_scan_mask)
> > +{
> > +	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> > +	unsigned int ch_idx, group = 0;
> > +	size_t size = 0;
> > +
> > +	mutex_lock(&priv->slock);
> > +
> > +	for_each_set_bit(ch_idx, active_scan_mask, indio_dev->num_channels) {
> > +		size += tsc2046_adc_group_set_layout(priv, group, ch_idx);
> > +		tsc2046_adc_group_set_cmd(priv, group, ch_idx);
> > +		group++;
> > +	}
> > +
> > +	priv->groups = group;
> > +	priv->xfer.len = size;
> > +	priv->time_per_scan_us = size * 8 *
> > +		priv->time_per_bit_ns / NSEC_PER_USEC;
> > +
> > +	if ((priv->scan_interval_us - priv->time_per_scan_us) < 0)
> > +		dev_warn(&priv->spi->dev, "The scan interval (%d) is less then calculated scan time (%d)\n",
> > +			 priv->scan_interval_us, priv->time_per_scan_us);
> > +
> > +	mutex_unlock(&priv->slock);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct iio_info tsc2046_adc_info = {
> > +	.update_scan_mode = tsc2046_adc_update_scan_mode,
> > +};
> > +
> > +static irqreturn_t tsc2046_adc_irq(int irq, void *dev_id)
> > +{
> > +	struct iio_dev *indio_dev = dev_id;
> > +	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> > +
> > +	iio_trigger_poll_chained(priv->trig);
> > +
> 
> Given you aren't doing anything in here, why run it in the threaded
> handler?  That somewhat restricts usecases for the trigger (should
> you want to do something crazy later like slave some other data capture
> off this trigger)...

Isn't the trigger poller function executed in the same context?

> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int tsc2046_adc_set_trigger_state(struct iio_trigger *trig, bool enable)
> > +{
> > +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > +	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> > +
> > +	if (enable)
> > +		enable_irq(priv->spi->irq);
> > +	else
> > +		disable_irq(priv->spi->irq);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct iio_trigger_ops tsc2046_adc_trigger_ops = {
> > +	.set_trigger_state = tsc2046_adc_set_trigger_state,
> > +};
> > +
> > +static int tsc2046_adc_setup_spi_msg(struct tsc2046_adc_priv *priv)
> > +{
> > +	unsigned int ch_idx;
> > +	size_t size = 0;
> > +	int ret;
> > +
> > +	/*
> > +	 * Make dummy read to set initial power state and get real SPI clock
> > +	 * freq. It seems to be not important which channel is used for this
> > +	 * case.
> > +	 */
> > +	ret = tsc2046_adc_read_one(priv, TI_TSC2046_ADDR_TEMP0,
> > +				   &priv->effective_speed_hz);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * In case SPI controller do not report effective_speed_hz, use
> > +	 * configure value and hope it will match
> > +	 */
> > +	if (!priv->effective_speed_hz)
> > +		priv->effective_speed_hz = priv->spi->max_speed_hz;
> > +
> > +
> > +	priv->scan_interval_us = TI_TSC2046_SAMPLE_INTERVAL_US;
> > +	priv->time_per_bit_ns = DIV_ROUND_UP(NSEC_PER_SEC,
> > +					     priv->effective_speed_hz);
> > +
> > +	/*
> > +	 * calculate and allocate maximal size buffer if all channels are
> > +	 * enabled
> > +	 */
> > +	for (ch_idx = 0; ch_idx < priv->dcfg->num_channels; ch_idx++)
> > +		size += tsc2046_adc_group_set_layout(priv, ch_idx, ch_idx);
> > +
> > +	priv->tx = devm_kzalloc(&priv->spi->dev, size, GFP_KERNEL);
> > +	if (!priv->tx)
> > +		return -ENOMEM;
> > +
> > +	priv->rx = devm_kzalloc(&priv->spi->dev, size, GFP_KERNEL);
> > +	if (!priv->rx)
> > +		return -ENOMEM;
> > +
> > +	spi_message_init(&priv->msg);
> > +	priv->msg.context = priv;
> > +
> > +	priv->xfer.tx_buf = priv->tx;
> > +	priv->xfer.rx_buf = priv->rx;
> > +	priv->xfer.len = size;
> > +	spi_message_add_tail(&priv->xfer, &priv->msg);
> > +
> > +	return 0;
> > +}
> > +
> > +static int tsc2046_adc_probe(struct spi_device *spi)
> > +{
> > +	const struct tsc2046_adc_dcfg *dcfg;
> > +	struct device *dev = &spi->dev;
> > +	struct tsc2046_adc_priv *priv;
> > +	struct iio_dev *indio_dev;
> > +	struct iio_trigger *trig;
> > +	const char *name;
> > +	int ret;
> > +
> > +	/* don't exceed max specified sample rate */
> 
> Comment not needed as obvious from error message (only an opportunity for
> it to bit rot!)

ok

> > +	if (spi->max_speed_hz > TI_TSC2046_MAX_CLK_FREQ) {
> > +		dev_err(dev, "SPI max_speed_hz is too high: %d Hz. Max supported freq is %d Hz\n",
> > +			spi->max_speed_hz, TI_TSC2046_MAX_CLK_FREQ);
> > +		return -EINVAL;
> > +	}
> > +
> > +	dcfg = device_get_match_data(dev);
> > +	if (!dcfg)
> > +		return -EINVAL;
> > +
> > +	spi->bits_per_word = 8;
> > +	spi->mode &= ~SPI_MODE_X_MASK;
> > +	spi->mode |= SPI_MODE_0;
> > +	ret = spi_setup(spi);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "Error in spi setup\n");
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	priv = iio_priv(indio_dev);
> > +	priv->dcfg = dcfg;
> > +
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	priv->spi = spi;
> > +
> > +	name = devm_kasprintf(dev, GFP_KERNEL, "%s-%s",
> > +			      TI_TSC2046_NAME, dev_name(dev));
> > +
> > +	indio_dev->name = name;
> > +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
> > +	indio_dev->channels = dcfg->channels;
> > +	indio_dev->num_channels = dcfg->num_channels;
> > +	indio_dev->info = &tsc2046_adc_info;
> > +
> > +	ret = tsc2046_adc_setup_spi_msg(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mutex_init(&priv->slock);
> > +
> > +	/* TODO: remove IRQ_NOAUTOEN after needed patches are mainline */
> 
> Hopefully those will go in soon. Lots of these to clean up!

:D

> > +	irq_set_status_flags(spi->irq, IRQ_NOAUTOEN);
> > +	ret = devm_request_threaded_irq(dev, spi->irq,
> > +					NULL,
> > +					&tsc2046_adc_irq,
> > +					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > +					name, indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> > +				      indio_dev->name, indio_dev->id);
> > +	if (!trig)
> > +		return -ENOMEM;
> > +
> > +	priv->trig = trig;
> > +	trig->dev.parent = indio_dev->dev.parent;
> > +	iio_trigger_set_drvdata(trig, indio_dev);
> > +	trig->ops = &tsc2046_adc_trigger_ops;
> > +
> > +	ret = devm_iio_trigger_register(dev, trig);
> > +	if (ret) {
> > +		dev_err(dev, "failed to register trigger\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +					      &tsc2046_adc_trigger_handler, NULL);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to setup triggered buffer\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = devm_iio_device_register(dev, indio_dev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to register iio device\n");
> > +		return ret;
> > +	}
> > +
> > +	/* set default trigger */
> > +	indio_dev->trig = iio_trigger_get(priv->trig);
> 
> Hmm. Normally I'd expect that before the device registration but it shouldn't
> cause any problems having it here as far as I can tell.

i copy pasted it from some other IIO driver, not remember which one.

> blank line here slightly preferred.

ok

> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id ads7950_of_table[] = {
> > +	{ .compatible = "ti,tsc2046e-adc", .data = &tsc2046_adc_dcfg_tsc2046e },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, ads7950_of_table);
> > +
> > +static struct spi_driver tsc2046_adc_driver = {
> > +	.driver = {
> > +		.name	= "tsc2046",
> > +		.of_match_table = ads7950_of_table,
> > +	},
> > +	.probe		= tsc2046_adc_probe,
> > +};
> > +module_spi_driver(tsc2046_adc_driver);
> > +
> > +MODULE_AUTHOR("Oleksij Rempel <kernel@pengutronix.de>");
> > +MODULE_DESCRIPTION("TI TSC2046 ADC");
> > +MODULE_LICENSE("GPL v2");

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
