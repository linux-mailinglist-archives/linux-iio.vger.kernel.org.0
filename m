Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05101342DE8
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 16:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhCTPq1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 11:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhCTPqI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 11:46:08 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 296186194A;
        Sat, 20 Mar 2021 15:46:04 +0000 (UTC)
Date:   Sat, 20 Mar 2021 15:46:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 3/3] iio: adc: add ADC driver for the TI TSC2046
 controller
Message-ID: <20210320154601.0131805d@jic23-huawei>
In-Reply-To: <20210319144509.7627-4-o.rempel@pengutronix.de>
References: <20210319144509.7627-1-o.rempel@pengutronix.de>
        <20210319144509.7627-4-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Mar 2021 15:45:09 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> the touchscreen use case. By implementing it as an IIO ADC device, we can
> make use of resistive-adc-touch and iio-hwmon drivers.
> 
> So far, this driver was tested with a custom version of resistive-adc-touch driver,
> since it needs to be extended to make use of Z1 and Z2 channels. The X/Y
> are working without additional changes.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Not a lot to add to Andy's review.  A few minor things inline.
Biggest one is I think we should call out that we expect to add single
channel polled reading + scales etc in future to enable the iio-hwmon
usecase.

Jonathan

> ---
>  MAINTAINERS                  |   8 +
>  drivers/iio/adc/Kconfig      |  12 +
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ti-tsc2046.c | 728 +++++++++++++++++++++++++++++++++++
>  4 files changed, 749 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-tsc2046.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0455cfd5c76c..2ea85a5bb4dd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18002,6 +18002,14 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/net/nfc/trf7970a.txt
>  F:	drivers/nfc/trf7970a.c
>  
> +TI TSC2046 ADC DRIVER
> +M:	Oleksij Rempel <o.rempel@pengutronix.de>
> +R:	kernel@pengutronix.de
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
> +F:	drivers/iio/adc/ti-tsc2046.c
> +
>  TI TWL4030 SERIES SOC CODEC DRIVER
>  M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
...
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> new file mode 100644
> index 000000000000..c8c0dd9087c5
> --- /dev/null
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -0,0 +1,728 @@
> +/*
> + * The PENIRQ of TSC2046 controller is implemented as level shifter attached to
> + * the X+ line. If voltage of the X+ line reaches a specific level the IRQ will
> + * be activated or deactivated.
> + * To make this kind of IRQ reusable as trigger following additions were
> + * implemented:
> + * - rate limiting:
> + *   For typical touchscreen use case, we need to trigger about each 10ms.
> + * - hrtimer:
> + *   Continue triggering at least once after the IRQ was deactivated. Then
> + *   deactivate this trigger to stop sampling in order to reduce power
> + *   consumption.
> + */

Good description :)

...


> +
> +struct tsc2046_adc_scan_buf {
> +	/* Scan data for each channel */
> +	u16 data[TI_TSC2046_MAX_CHAN];
> +	/* Timestamp */
> +	s64 ts __aligned(8);
> +};

...

> +struct tsc2046_adc_priv {
> +	struct spi_device *spi;
> +	const struct tsc2046_adc_dcfg *dcfg;
> +
> +	struct iio_trigger *trig;
> +	struct hrtimer trig_timer;
> +	spinlock_t trig_lock;
> +	atomic_t trig_more_count;
> +
> +	struct spi_transfer xfer;
> +	struct spi_message msg;
> +
> +	struct tsc2046_adc_scan_buf scan_buf;

Given the type tsc2046_adc_scan_buf is never used for anything else
you could make things more compact by using 
	struct {
	} scan_buf; 

> +	/*
> +	 * Lock to protect the layout and the spi transfer buffer.
> +	 * tsc2046_adc_group_layout can be changed within update_scan_mode(),
> +	 * in this case the l[] and tx/rx buffer will be out of sync to each
> +	 * other.
> +	 */
> +	struct mutex slock;
> +	struct tsc2046_adc_group_layout l[TI_TSC2046_MAX_CHAN];
> +	struct tsc2046_adc_atom *rx;
> +	struct tsc2046_adc_atom *tx;
> +
> +	struct tsc2046_adc_atom *rx_one;
> +	struct tsc2046_adc_atom *tx_one;
> +
> +	unsigned int count;
> +	unsigned int groups;
> +	u32 effective_speed_hz;
> +	u32 scan_interval_us;
> +	u32 time_per_scan_us;
> +	u32 time_per_bit_ns;
> +
> +	struct tsc2046_adc_ch_cfg ch_cfg[TI_TSC2046_MAX_CHAN];
> +};
> +
> +#define TI_TSC2046_V_CHAN(index, bits, name)			\
> +{								\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = index,					\
> +	.datasheet_name = "#name",				\
> +	.scan_index = index,					\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = bits,				\
> +		.storagebits = 16,				\
> +		.endianness = IIO_CPU,				\
> +	},							\
> +}

I'd not noticed this before but you are exposing nothing to the
normal IIO interfaces.

That means for usecases like iio-hwmon there is no access
to polled readings, or information like channel scaling.

I suppose that could be added later, but perhaps you want to call this
out by mentioning it in the patch description.


> +
> +#define DECLARE_TI_TSC2046_8_CHANNELS(name, bits) \
> +const struct iio_chan_spec name ## _channels[] = { \
> +	TI_TSC2046_V_CHAN(0, bits, TEMP0), \
> +	TI_TSC2046_V_CHAN(1, bits, Y), \
> +	TI_TSC2046_V_CHAN(2, bits, VBAT), \
> +	TI_TSC2046_V_CHAN(3, bits, Z1), \
> +	TI_TSC2046_V_CHAN(4, bits, Z2), \
> +	TI_TSC2046_V_CHAN(5, bits, X), \
> +	TI_TSC2046_V_CHAN(6, bits, AUX), \
> +	TI_TSC2046_V_CHAN(7, bits, TEMP1), \
> +	IIO_CHAN_SOFT_TIMESTAMP(8), \
> +}
> +
> +static DECLARE_TI_TSC2046_8_CHANNELS(tsc2046_adc, 12);
> +
> +static const struct tsc2046_adc_dcfg tsc2046_adc_dcfg_tsc2046e = {
> +	.channels = tsc2046_adc_channels,
> +	.num_channels = ARRAY_SIZE(tsc2046_adc_channels),
> +};
> +

Hmm.  Flexibility that isn't yet used.  Normally I'm pretty resistant
to this going in, unless I'm reassured that there is support for additional
devices already in the pipeline.  Is that true here?  Otherwise
this is basically unneeded complexity.

...

Jonathan
