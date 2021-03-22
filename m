Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11609344046
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 12:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCVL5A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 07:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhCVL4k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 07:56:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFBDC061574
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 04:56:40 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lOJAi-000294-In; Mon, 22 Mar 2021 12:56:36 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lOJAh-00057K-IU; Mon, 22 Mar 2021 12:56:35 +0100
Date:   Mon, 22 Mar 2021 12:56:35 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 3/3] iio: adc: add ADC driver for the TI TSC2046
 controller
Message-ID: <20210322115635.GA14791@pengutronix.de>
References: <20210319144509.7627-1-o.rempel@pengutronix.de>
 <20210319144509.7627-4-o.rempel@pengutronix.de>
 <20210320154601.0131805d@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210320154601.0131805d@jic23-huawei>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:47:08 up 21 days, 21:22, 91 users,  load average: 1.05, 0.68,
 0.46
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Sat, Mar 20, 2021 at 03:46:01PM +0000, Jonathan Cameron wrote:
> On Fri, 19 Mar 2021 15:45:09 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> > the touchscreen use case. By implementing it as an IIO ADC device, we can
> > make use of resistive-adc-touch and iio-hwmon drivers.
> > 
> > So far, this driver was tested with a custom version of resistive-adc-touch driver,
> > since it needs to be extended to make use of Z1 and Z2 channels. The X/Y
> > are working without additional changes.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Not a lot to add to Andy's review.  A few minor things inline.
> Biggest one is I think we should call out that we expect to add single
> channel polled reading + scales etc in future to enable the iio-hwmon
> usecase.
> 
> Jonathan
> 
> > ---
> >  MAINTAINERS                  |   8 +
> >  drivers/iio/adc/Kconfig      |  12 +
> >  drivers/iio/adc/Makefile     |   1 +
> >  drivers/iio/adc/ti-tsc2046.c | 728 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 749 insertions(+)
> >  create mode 100644 drivers/iio/adc/ti-tsc2046.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0455cfd5c76c..2ea85a5bb4dd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18002,6 +18002,14 @@ S:	Supported
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
> ...
> > diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> > new file mode 100644
> > index 000000000000..c8c0dd9087c5
> > --- /dev/null
> > +++ b/drivers/iio/adc/ti-tsc2046.c
> > @@ -0,0 +1,728 @@
> > +/*
> > + * The PENIRQ of TSC2046 controller is implemented as level shifter attached to
> > + * the X+ line. If voltage of the X+ line reaches a specific level the IRQ will
> > + * be activated or deactivated.
> > + * To make this kind of IRQ reusable as trigger following additions were
> > + * implemented:
> > + * - rate limiting:
> > + *   For typical touchscreen use case, we need to trigger about each 10ms.
> > + * - hrtimer:
> > + *   Continue triggering at least once after the IRQ was deactivated. Then
> > + *   deactivate this trigger to stop sampling in order to reduce power
> > + *   consumption.
> > + */
> 
> Good description :)
> 
> ...
> 
> 
> > +
> > +struct tsc2046_adc_scan_buf {
> > +	/* Scan data for each channel */
> > +	u16 data[TI_TSC2046_MAX_CHAN];
> > +	/* Timestamp */
> > +	s64 ts __aligned(8);
> > +};
> 
> ...
> 
> > +struct tsc2046_adc_priv {
> > +	struct spi_device *spi;
> > +	const struct tsc2046_adc_dcfg *dcfg;
> > +
> > +	struct iio_trigger *trig;
> > +	struct hrtimer trig_timer;
> > +	spinlock_t trig_lock;
> > +	atomic_t trig_more_count;
> > +
> > +	struct spi_transfer xfer;
> > +	struct spi_message msg;
> > +
> > +	struct tsc2046_adc_scan_buf scan_buf;
> 
> Given the type tsc2046_adc_scan_buf is never used for anything else
> you could make things more compact by using 
> 	struct {
> 	} scan_buf; 
> 
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
> > +	struct tsc2046_adc_atom *rx_one;
> > +	struct tsc2046_adc_atom *tx_one;
> > +
> > +	unsigned int count;
> > +	unsigned int groups;
> > +	u32 effective_speed_hz;
> > +	u32 scan_interval_us;
> > +	u32 time_per_scan_us;
> > +	u32 time_per_bit_ns;
> > +
> > +	struct tsc2046_adc_ch_cfg ch_cfg[TI_TSC2046_MAX_CHAN];
> > +};
> > +
> > +#define TI_TSC2046_V_CHAN(index, bits, name)			\
> > +{								\
> > +	.type = IIO_VOLTAGE,					\
> > +	.indexed = 1,						\
> > +	.channel = index,					\
> > +	.datasheet_name = "#name",				\
> > +	.scan_index = index,					\
> > +	.scan_type = {						\
> > +		.sign = 'u',					\
> > +		.realbits = bits,				\
> > +		.storagebits = 16,				\
> > +		.endianness = IIO_CPU,				\
> > +	},							\
> > +}
> 
> I'd not noticed this before but you are exposing nothing to the
> normal IIO interfaces.
> 
> That means for usecases like iio-hwmon there is no access
> to polled readings, or information like channel scaling.
> 
> I suppose that could be added later, but perhaps you want to call this
> out by mentioning it in the patch description.

If it is ok for you, then I'll add some words about it in to the patch
description.

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
> 
> Hmm.  Flexibility that isn't yet used.  Normally I'm pretty resistant
> to this going in, unless I'm reassured that there is support for additional
> devices already in the pipeline.  Is that true here?  Otherwise
> this is basically unneeded complexity.

In the long term this driver should replace
drivers/input/touchscreen/ads7846.c

This driver supports ti,ads7843, ti,ads7845, ti,ads7846.. at least with
following number of supported channels:
ti,ads7843 - 4 channels: x, y, aux0, aux1
ti,ads7845 - 3 channels: x, y, aux0
ti,ads7846 - 8 channels...

Currently I don't have this HW for testing and there a subtle
differences that have to be taken care of and tested.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
