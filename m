Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923D0457FDC
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 18:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhKTRh7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 12:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhKTRh7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Nov 2021 12:37:59 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FB9460E9C;
        Sat, 20 Nov 2021 17:34:52 +0000 (UTC)
Date:   Sat, 20 Nov 2021 17:39:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Iain Hunter <drhunter95@gmail.com>
Cc:     iain@hunterembedded.co.uk, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] add support for ADS1018 to IIO.
Message-ID: <20211120173945.46cada00@jic23-huawei>
In-Reply-To: <20211116155935.304368-1-drhunter95@gmail.com>
References: <20211116155935.304368-1-drhunter95@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Nov 2021 15:59:20 +0000
Iain Hunter <drhunter95@gmail.com> wrote:

> v2 Patch incorporates suggestions from Jonathan

Hi Iain,

A few process things first.

Change log should be below the --- as we don't want that detail to end up
in the log that git will pick up when these are applied.

v1 had a nice little description of the device - please put that back for v4
(see comment on v3 binding patch about not splitting up the series)

> 
> Signed-off-by: Iain Hunter <drhunter95@gmail.com>

The binding review obviously affects various things in here, but I haven't
called them out here as that will be obvious as you change the binding.

Various other things inline.

Jonathan

> ---
>  drivers/iio/adc/Kconfig      |  12 +
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ti-ads1018.c | 800 +++++++++++++++++++++++++++++++++++
>  3 files changed, 813 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads1018.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 8bf5b62a73f4..129194755c03 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1131,6 +1131,18 @@ config TI_ADS1015
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-ads1015.
>  
> +config TI_ADS1018
> +	tristate "Texas Instruments ADS1018 ADC"
> +	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  If you say yes here you get support for Texas Instruments ADS1018
> +	  ADC chip.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ti-ads1018.
> +
>  config TI_ADS7950
>  	tristate "Texas Instruments ADS7950 ADC driver"
>  	depends on SPI && GPIOLIB
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d3f53549720c..da462538ec17 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_TI_ADC108S102) += ti-adc108s102.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>  obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
> +obj-$(CONFIG_TI_ADS1018) += ti-ads1018.o
>  obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
>  obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
> diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
> new file mode 100644
> index 000000000000..4f0ac57f6bb5
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1018.c
> @@ -0,0 +1,800 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADS1018 - Texas Instruments Analog-to-Digital Converter
> + *
> + * Copyright 2021 Iain Hunter <iain@hunterembedded.co.uk>
> + *
> + * Based on ti-ads1015.c
> + * Copyright (c) 2016, Intel Corporation.
> + *
> + * IIO driver for 12 bit SPI ADC ADS1018 from TI
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/bitfield.h>

Headers in IIO preferred in alphabetical order within
each block.  So
linux, asm then iio.

> +#include <asm/unaligned.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

That shouldn't be needed once you'd remove the extra
avialable attrs.

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#define ADS1018_DRV_NAME "ads1018"
> +
> +#define ADS1018_CHANNELS		8
> +
> +#define ADS1018_CFG_NOP_MASK		GENMASK(2, 1)
> +#define ADS1018_CFG_PULL_UP_MASK	BIT(3)
> +#define ADS1018_CFG_TS_MODE_MASK	BIT(4)
> +#define ADS1018_CFG_DR_MASK		GENMASK(7, 5)
> +#define ADS1018_CFG_MODE_MASK		BIT(8)
> +#define ADS1018_CFG_PGA_MASK		GENMASK(11, 9)
> +#define ADS1018_CFG_MUX_MASK		GENMASK(14, 12)
> +
> +#define ADS1018_PGA_2_048V			1
> +
> +
> +#define ADS1018_MODE_SINGLE_SHOT		1
> +#define ADS1018_MODE_CONTINUOUS			0
> +
> +
> +#define ADS1018_STATE_RATE_128			0
> +#define ADS1018_STATE_RATE_250			1
> +#define ADS1018_STATE_RATE_490			2
> +#define ADS1018_STATE_RATE_920			3
> +#define ADS1018_STATE_RATE_1600			4
> +#define ADS1018_STATE_RATE_2400			5
> +#define ADS1018_STATE_RATE_3300			6
> +
> +#define ADS1018_TS_MODE_ADC			0
> +#define ADS1018_TS_MODE_TEMP			1
> +
> +#define ADS1018_PULLUP_DOUT_DISABLE		0
> +#define ADS1018_PULLUP_DOUT_ENABLE		1
> +
> +#define ADS1018_NOP_UPDATE_CONFIG		1
> +#define ADS1018_RESERVED			1
> +
> +#define ADS1018_CONFIGURE	\
> +		(FIELD_PREP(ADS1018_CFG_PGA_MASK, ADS1018_PGA_2_048V) | \
> +		 FIELD_PREP(ADS1018_CFG_MODE_MASK, ADS1018_MODE_CONTINUOUS)| \
> +		 FIELD_PREP(ADS1018_CFG_DR_MASK, ADS1018_STATE_RATE_2400) | \
> +		 FIELD_PREP(ADS1018_CFG_TS_MODE_MASK, ADS1018_TS_MODE_ADC) | \
> +		 FIELD_PREP(ADS1018_CFG_PULL_UP_MASK, ADS1018_PULLUP_DOUT_ENABLE) | \
> +		 FIELD_PREP(ADS1018_CFG_NOP_MASK, ADS1018_NOP_UPDATE_CONFIG)| \
> +				ADS1018_RESERVED)
> +
> +#define ADS1018_SLEEP_DELAY_MS			2000
> +#define ADS1018_DEFAULT_PGA			2
> +#define ADS1018_DEFAULT_DATA_RATE		4
> +#define ADS1018_DEFAULT_CHAN			0
> +
> +enum chip_ids {
> +	ADS1018};
enum ads1018_chip_ids {
	ADS1018,
};

Or just remove the use of this entirely until you add support for a second part to
the driver and it becomes necessary.


> +
> +enum ads1018_channels {
> +	ADS1018_AIN0_AIN1 = 0,
> +	ADS1018_AIN0_AIN3,
> +	ADS1018_AIN1_AIN3,
> +	ADS1018_AIN2_AIN3,
> +	ADS1018_AIN0,
> +	ADS1018_AIN1,
> +	ADS1018_AIN2,
> +	ADS1018_AIN3,
> +	ADS1018_TIMESTAMP,
> +};
> +
> +struct ti_ads1018_chip_info {
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +};
> +
> +static const unsigned int ads1018_data_rate[] = {
> +	128, 250, 490, 920, 1600, 2400, 3300
> +};
> +
> +/*
> + * Translation from PGA bits to full-scale positive and negative input voltage
> + * range in mV
> + */
> +static int ads1018_fullscale_range[] = {
> +	6144, 4096, 2048, 1024, 512, 256
> +};
> +

one blank line only.  Same for anywhere else I didn't notice or comment on.

> +
> +#define ADS1018_V_CHAN(_chan, _addr) {				\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.address = _addr,					\
> +	.channel = _chan,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +				BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.info_mask_separate_available = \
> +				BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = _addr,					\
> +	.scan_type = {						\
> +		.sign = 's',					\
> +		.realbits = 12,					\
> +		.storagebits = 16,				\
> +		.shift = 4,					\
> +		.endianness = IIO_CPU,				\
> +	},							\
> +	.datasheet_name = "AIN"#_chan,				\
> +}
> +
> +#define ADS1018_V_DIFF_CHAN(_chan, _chan2, _addr) {		\
> +	.type = IIO_VOLTAGE,					\
> +	.differential = 1,					\
> +	.indexed = 1,						\
> +	.address = _addr,					\
> +	.channel = _chan,					\
> +	.channel2 = _chan2,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +				BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.info_mask_separate_available = \
> +				BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = _addr,					\
> +	.scan_type = {						\
> +		.sign = 's',					\
> +		.realbits = 12,					\
> +		.storagebits = 16,				\
> +		.shift = 4,					\
> +		.endianness = IIO_CPU,				\
> +	},							\
> +	.datasheet_name = "AIN"#_chan"-AIN"#_chan2,		\
> +}
> +
> +struct ads1018_channel_data {
> +	bool enabled;
> +	unsigned int pga;
> +	unsigned int data_rate;
> +};
> +
> +struct ti_ads1018_state {
> +	struct spi_device *spi;
> +	struct spi_transfer scan_single_xfer[1];
> +	struct spi_message scan_single_msg;
> +
> +	struct iio_trigger *trig;
> +	/*
> +	 * Protects ADC ops, e.g: concurrent sysfs/buffered
> +	 * data reads, configuration updates
> +	 */
> +	struct mutex lock;
> +	struct ads1018_channel_data channel_data[ADS1018_CHANNELS];
> +	unsigned int current_config;
> +	unsigned int settings;
> +	const unsigned int *data_rate;
> +	/*
> +	 * Set to true when the ADC is switched to the continuous-conversion
> +	 * mode and exits from a power-down state.  This flag is used to avoid
> +	 * getting the stale result from the conversion register.
> +	 */
> +	bool conv_invalid;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	unsigned char	spi_rx_buf[sizeof(u32)]
> +				____cacheline_aligned;
> +	unsigned char	spi_tx_buf[sizeof(u32)]

You will be fine only marking first buffer as ____cacheline_aligned.
There is an assumption that a DMA device will not take out itself.
If you follow through the 'why' dma buffers have this requirement it becomes
obvious that any sane peripheral won't break it's own activity so
all we need to do is ensure both spi_rx_buf and spi_tx_buf are in a different
cacheline from anything else, but it can be the same one.

____cacheline_aligned for rx_buf will do that for us.

> +				____cacheline_aligned;
> +};
> +
> +static const struct iio_chan_spec ti_ads1018_channels[] = {
> +	ADS1018_V_DIFF_CHAN(0, 1, ADS1018_AIN0_AIN1),
> +	ADS1018_V_DIFF_CHAN(0, 3, ADS1018_AIN0_AIN3),
> +	ADS1018_V_DIFF_CHAN(1, 3, ADS1018_AIN1_AIN3),
> +	ADS1018_V_DIFF_CHAN(2, 3, ADS1018_AIN2_AIN3),
> +	ADS1018_V_CHAN(0, ADS1018_AIN0),
> +	ADS1018_V_CHAN(1, ADS1018_AIN1),
> +	ADS1018_V_CHAN(2, ADS1018_AIN2),
> +	ADS1018_V_CHAN(3, ADS1018_AIN3),
> +	IIO_CHAN_SOFT_TIMESTAMP(ADS1018_TIMESTAMP),
> +};
> +
> +static const struct ti_ads1018_chip_info ti_ads1018_chip = {
> +	.channels	= ti_ads1018_channels,
> +	.num_channels	= ARRAY_SIZE(ti_ads1018_channels),
> +};
> +
> +static int ti_ads1018_write_config_register(struct ti_ads1018_state *st, int value)
> +{
> +	int ret;
> +
> +	/* Write new value to the first 2 bytes of the 4 byte SPI transfer */
> +	put_unaligned_be16(value, (void *)&st->spi_tx_buf[0]);
> +	put_unaligned_be16(0x0000, (void *)&st->spi_tx_buf[2]);

As below.  Same anywhere else where I haven't commented on void * casts

> +
> +	ret = spi_sync(st->spi, &st->scan_single_msg);
> +	if (ret)
> +		return ret;
> +
> +	/* Update the state current config based on result of this write

	/*
	 * Update

> +	 * the updated config register value is in second 16 bit word
> +	 * which is third and fourth byte
> +	 */
> +	st->current_config = get_unaligned_be16((void *)&st->spi_rx_buf[2]);

As below, never cast explicitly to void *

> +
> +	return 0;
> +}
> +
> +static int __maybe_unused ads1018_set_power_state(struct ti_ads1018_state *st, bool on)
> +{
> +	int ret;
> +	struct spi_device *spi = st->spi;
> +	struct device *dev = &(spi->dev);

Brackets not needed. -> has higher precedence than &

> +
> +	if (pm_runtime_enabled(dev)) {
> +		if (on) {
> +			ret = pm_runtime_resume_and_get(dev);
> +		} else {
> +			pm_runtime_mark_last_busy(dev);
> +			ret = pm_runtime_put_autosuspend(dev);
> +		}
> +
> +		return ret < 0 ? ret : 0;
> +	} else {
> +		return 0;

I would flip this around for readability.

	if (!pm_runtime_enabled(dev))
		return 0;

	if (on) ...

> +	}
> +}
> +
> +static
> +int ads1018_get_adc_result(struct ti_ads1018_state *st, int chan, int *val)
Prefer having line break in the parameters

static int ads1018_get_adc_result(struct ti_ads1018_state *st, int chan,
				  int val)
{

> +{
> +	int ret, pga, dr, dr_old, conv_time;
> +	unsigned int old, mask, cfg;
> +	unsigned int cmd;
> +
> +	if (chan < 0 || chan >= ADS1018_CHANNELS)
> +		return -EINVAL;
> +
> +	old = st->current_config;
> +	pga = st->channel_data[chan].pga;
> +	dr = st->channel_data[chan].data_rate;
> +	mask =  ADS1018_CFG_MUX_MASK | ADS1018_CFG_PGA_MASK |
> +			ADS1018_CFG_DR_MASK;
> +	cfg = FIELD_PREP(ADS1018_CFG_MUX_MASK, chan) |
> +	      FIELD_PREP(ADS1018_CFG_PGA_MASK, pga) |
> +	      FIELD_PREP(ADS1018_CFG_DR_MASK, dr);
> +
> +	cfg = (old & ~mask) | (cfg & mask);
> +	if (old != cfg) {
> +		/* Update the configuration to the new one  */
> +		ret = ti_ads1018_write_config_register(st, cfg);
> +		if (ret)
> +			return ret;
> +		st->conv_invalid = true;
> +	}
> +
> +	if (st->conv_invalid) {
> +		dr_old = FIELD_GET(ADS1018_CFG_DR_MASK, old);
> +
> +		conv_time = DIV_ROUND_UP(USEC_PER_SEC, st->data_rate[dr_old]);
> +		conv_time += DIV_ROUND_UP(USEC_PER_SEC, st->data_rate[dr]);
> +		conv_time += conv_time / 10; /* 10% internal clock inaccuracy */
> +		usleep_range(conv_time, conv_time + 1);
> +		st->conv_invalid = false;
> +	}
> +
> +	/* For just a data read cmd is 0x0000 */
> +	cmd = 0x0000;
> +	put_unaligned_be16(cmd, (void *)&st->spi_tx_buf[0]);
> +	put_unaligned_be16(0x0000, (void *)&st->spi_tx_buf[2]);
> +
> +	ret = spi_sync(st->spi, &st->scan_single_msg);
> +	if (ret)
> +		return ret;
> +
> +	*val = get_unaligned_be16((void *)&st->spi_rx_buf[0]);

No to explicit casting to void * The c spec always allows a pointer to be cast to that implicitly.
so this is the same as
	*val = get_unaligned_be16(&st->spi_rx_buf[0]);


blank line as return not really related to line above and helps readability.

> +	return 0;
> +
> +}
> +
> +static irqreturn_t ti_ads1018_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ti_ads1018_state *st = iio_priv(indio_dev);
> +	/* Ensure natural alignment of timestamp */
> +	struct {
> +		s16 chan;
> +		s64 timestamp __aligned(8);
> +

Remove this blank line.

> +	} scan;
> +
> +	int chan, ret, res;
> +
> +	memset(&scan, 0, sizeof(scan));
> +
> +	mutex_lock(&st->lock);
> +	chan = find_first_bit(indio_dev->active_scan_mask,
> +			      indio_dev->masklength);
> +	ret = ads1018_get_adc_result(st, chan, &res);
> +	if (ret < 0) {
> +		mutex_unlock(&st->lock);
> +		goto err;
> +	}
> +
> +	scan.chan = res;

Do this outside the lock as not using anything the lock is protecting.
Having done that you can use the pattern.

	mutex_lock();
	chan = ...
	ret = ads...
	mutex_unlock()
	if (ret < 0)
		goto err;

	scan.chan = res;

Which is common way of avoiding having to unlock separately for error paths
in these simple cases where there is only one function that can return an error
under the lock.

> +	mutex_unlock(&st->lock);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> +					   iio_get_time_ns(indio_dev));
> +
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +

> +
> +static int ads1018_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct ti_ads1018_state *st = iio_priv(indio_dev);
> +	int ret, idx;
> +
> +	mutex_lock(&st->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		int shift = chan->scan_type.shift;
> +		int sign_bit = chan->scan_type.realbits - 1;
> +
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			break;
> +
> +		ret = ads1018_set_power_state(st, true);
> +		if (ret < 0)
> +			goto release_direct;
> +
> +		ret = ads1018_get_adc_result(st, chan->address, val);
> +		if (ret < 0) {
> +			ads1018_set_power_state(st, false);
> +			goto release_direct;
> +		}
> +
> +		*val = sign_extend32(*val >> shift, sign_bit);
> +
> +		ret = ads1018_set_power_state(st, false);
> +		if (ret < 0)
> +			goto release_direct;
> +
> +		ret = IIO_VAL_INT;
> +release_direct:

I would suggest a utility function that does everything in this 
case : entry.  It's always nasty to have gotos in a switch because
of the indenting.

> +		iio_device_release_direct_mode(indio_dev);
> +		break;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		idx = st->channel_data[chan->address].pga;
> +		*val = ads1018_fullscale_range[idx];
> +		*val2 = chan->scan_type.realbits - 1;
> +		ret = IIO_VAL_FRACTIONAL_LOG2;
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		idx = st->channel_data[chan->address].data_rate;
> +		*val = st->data_rate[idx];
> +		ret = IIO_VAL_INT;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int ads1018_read_avail(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    const int **vals, int *type, int *length,
> +			    long mask)
> +{
> +	struct ti_ads1018_state *st = iio_priv(indio_dev);
> +	int idx;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		idx = st->channel_data[chan->address].pga;
> +		*length = sizeof(int) / sizeof(int);
> +		*vals = &(ads1018_fullscale_range[idx]);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		idx = st->channel_data[chan->address].data_rate;
> +		*length = sizeof(int) / sizeof(int);
> +		*vals = &(st->data_rate[idx]);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}

Umm.  I'm reviewing backwards - but rather suprised to see this and
the attrs below.  You shouldn't need the attrs if you have the relevant
bits set in scan_mask_available_shared_by*

The whole point is to have the core create them rather than the driver
needing to do it

> +
> +static IIO_CONST_ATTR_NAMED(ads1018_scale_available, scale_available,
> +	"3 2 1 0.5 0.25 0.125");
> +
> +static IIO_CONST_ATTR_NAMED(ads1018_sampling_frequency_available,
> +	sampling_frequency_available, "128 250 490 920 1600 2400 3300");
> +
> +static struct attribute *ads1018_attributes[] = {
> +	&iio_const_attr_ads1018_scale_available.dev_attr.attr,
> +	&iio_const_attr_ads1018_sampling_frequency_available.dev_attr.attr,

As requested previously these should be done in new drivers with the
read_avail() callback rather than via the ATTR macros.
That makes them available to in kernel consumers of the ADC channels.

We are very slowly working through old drivers to convert them over.

> +	NULL,
> +};
> +
> +static const struct attribute_group ads1018_attribute_group = {
> +	.attrs = ads1018_attributes,
> +};
> +

One line is always enough.

> +
> +static const struct iio_info ti_ads1018_info = {
> +	.read_raw	= ads1018_read_raw,
> +	.read_avail	= ads1018_read_avail,
> +	.write_raw	= ads1018_write_raw,
> +	.attrs		= &ads1018_attribute_group,
> +};
> +
> +static int ads1018_device_get_channels_config(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct ti_ads1018_state *data = iio_priv(indio_dev);
> +	struct device *dev = &spi->dev;
> +	struct fwnode_handle *node;
> +	int i = -1;
> +
> +	if (!spi->dev.of_node ||

Use generic tests for these - not of specific ones.
if (dev_fwnode(dev) || (device_get_child_node_count(dev) == 0))

If there is an of_ code in the driver then it's a bad thing and rules
out other firmware types.

> +	    !of_get_next_child(spi->dev.of_node, NULL))
> +		return -EINVAL;
> +
> +	device_for_each_child_node(dev, node) {
> +		u32 pval;
> +		unsigned int channel;
> +		unsigned int pga = ADS1018_DEFAULT_PGA;
> +		unsigned int data_rate = ADS1018_DEFAULT_DATA_RATE;
> +
> +		if (fwnode_property_read_u32(node, "reg", &pval)) {
> +			dev_err(dev, "invalid reg on %pfw\n",
> +				node);

If it's an error don't continue.  return the error code.  We don't
attempt to paper over incorrect firmware.

Same for all the other paths below.

> +			continue;
> +		}
> +
> +		channel = pval;
> +
> +		if (channel >= ADS1018_CHANNELS) {
> +			dev_err(dev,
> +				"invalid channel index %d on %pfw\n",
> +				channel, node);
> +			continue;
> +		}
> +
> +		if (!fwnode_property_read_u32(node, "ti,gain", &pval)) {
> +			pga = pval;
> +			if (pga > ARRAY_SIZE(ads1018_fullscale_range)) {
> +				dev_err(dev, "invalid gain on %pfw\n",
> +					node);
> +				fwnode_handle_put(node);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		if (!fwnode_property_read_u32(node, "ti,datarate", &pval)) {
> +			data_rate = pval;
> +			if (data_rate > ARRAY_SIZE(ads1018_data_rate)) {
> +				dev_err(&spi->dev,
> +					"invalid data_rate on %pfw\n",
> +					node);
> +				fwnode_handle_put(node);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		data->channel_data[channel].enabled = 1;
> +		data->channel_data[channel].pga = pga;
> +		data->channel_data[channel].data_rate = data_rate;
> +
> +		i++;
> +	}
> +
> +	return i < 0 ? -EINVAL : 0;
> +}
> +
> +static void ads1018_get_channels_config(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct ti_ads1018_state *data = iio_priv(indio_dev);
> +	unsigned int k;
> +
> +	if (!ads1018_device_get_channels_config(spi))
> +		return;

blank line here for readabilty

> +	/* fallback on default configuration */
> +	for (k = 0; k < ADS1018_CHANNELS; ++k) {
> +		data->channel_data[k].enabled = 0;
> +		data->channel_data[k].pga = ADS1018_DEFAULT_PGA;
> +		data->channel_data[k].data_rate = ADS1018_DEFAULT_DATA_RATE;
> +	}
> +}
> +
> +static int ads1018_set_conv_mode(struct ti_ads1018_state *st, int mode)
> +{
> +	int updatedConfig;
> +
> +	updatedConfig = st->current_config & ~(ADS1018_CFG_MODE_MASK);
> +	updatedConfig |= FIELD_PREP(ADS1018_CFG_MODE_MASK, mode);
> +
> +	return ti_ads1018_write_config_register(st, updatedConfig);
> +}
> +
> +static int ti_ads1018_set_trigger_state(struct iio_trigger *trig, bool enable)
> +{
> +	return 0;

I'm fairly sure that's checked and if there is no means of doing anything useful in it then
no need to provide it.

> +}
> +
> +static const struct iio_trigger_ops ti_ads1018_trigger_ops = {
> +	.set_trigger_state = ti_ads1018_set_trigger_state,
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
> +static void ads1018_disable(void *data)
> +{
> +	struct ti_ads1018_state *st = (struct ti_ads1018_state *) data;
> +	struct spi_device *spi = st->spi;
> +
> +	pm_runtime_disable(&spi->dev);
> +	pm_runtime_set_suspended(&spi->dev);
> +	pm_runtime_put_noidle(&spi->dev);
As below, this can't be done in one go because in some error paths you haven't
enabled runtime pm yet. You will need at least two such callbacks.
> +
> +	/* power down single shot mode */
> +	ads1018_set_conv_mode(st, ADS1018_MODE_SINGLE_SHOT);
> +}
> +
> +static int ti_ads1018_probe(struct spi_device *spi)
> +{
> +	const struct ti_ads1018_chip_info *info;
> +	struct ti_ads1018_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +	int i;
> +	int config;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->spi = spi;
> +	config = ADS1018_CONFIGURE;
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	mutex_init(&st->lock);
> +
> +	info = &ti_ads1018_chip;
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = info->channels;
> +	indio_dev->num_channels = info->num_channels;
> +	indio_dev->info = &ti_ads1018_info;
> +	st->data_rate = &ads1018_data_rate[0];
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ads1018_disable,
> +				       st);

No line break needed here to keep it under 80 chars advised line length.

> +
> +	if (ret)
> +		return ret;
> +
> +	/* allocate and then register trigger with IIO core */
> +	st->trig = devm_iio_trigger_alloc(indio_dev->dev.parent, "%s-dev%d",
> +					  indio_dev->name,
> +					  iio_device_id(indio_dev));
> +	if (st->trig == NULL)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ti_ads1018_trigger_ops;
> +
> +	devm_iio_trigger_register(indio_dev->dev.parent, st->trig);

That call can fail.  You should be checking for errors.

> +
> +	/* set the default trigger */
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	ads1018_get_channels_config(spi);
> +
> +	/* Find out if DT has enabled any of the channels, only one allowed so

/*
 * Find ...

For all comments in IIO.  There are a few variants of comment syntax across
the kernel so copy local style for new code. In IIO we are pretty fixed on this one.

> +	 * just take the first one
> +	 */
> +	for (i = 0; i < info->num_channels; i++)
> +		if (st->channel_data[i].enabled == 1)
> +			break;
> +
> +	/* If a channel was enabled set it by default in the device */
> +	if (i < info->num_channels) {
> +		/* mask out the mux bits  */
> +		config &= ~(ADS1018_CFG_MUX_MASK);
> +		config |= FIELD_PREP(ADS1018_CFG_MUX_MASK, i);
> +	}
> +
> +	/*
> +	 * Always use 4 * 8 bit transfer mode so that the status is read back
> +	 * in the second 16 bit word. This allows us to track when updated
> +	 * configuration needs to be applied.
> +	 */
> +	st->scan_single_xfer[0].tx_buf = &st->spi_tx_buf[0];
> +	st->scan_single_xfer[0].rx_buf = &st->spi_rx_buf[0];
> +	st->scan_single_xfer[0].len = 4;
> +	st->scan_single_xfer[0].cs_change = 0;
> +	st->scan_single_xfer[0].bits_per_word = 8;
> +
> +	spi_message_init_with_transfers(&st->scan_single_msg,
> +					st->scan_single_xfer, 1);
> +
> +	ret = ti_ads1018_write_config_register(st, config);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "ads1018 configuration failed\n");
> +		return ret;
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent,
> +					 indio_dev, NULL,
> +					 ti_ads1018_trigger_handler,
> +					 &ti_ads1018_buffer_setup_ops);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
> +		return ret;
> +	}
> +
> +	ret = ads1018_set_conv_mode(st, ADS1018_MODE_CONTINUOUS);
> +	if (ret)
> +		return ret;
> +
> +	st->conv_invalid = true;
> +
> +	ret = pm_runtime_set_active(&spi->dev);
> +	if (ret)
> +		return ret;
> +	pm_runtime_set_autosuspend_delay(&spi->dev, ADS1018_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(&spi->dev);
> +	pm_runtime_enable(&spi->dev);

I made a comment about using a devm_add_action_or_reset() to unwind the
runtime pm setup.  That seems to be missing as it should be here.  You should
not be undoing things unless you have first done them.  Hence you will need
several devm_add_action_or_reset() calls in probe to cover the different
elements.

> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +#ifdef CONFIG_PM

Mark these as __maybe_unused and drop the CONFIG_PM protections.
That's the preferred option for new drivers (and when I get a few minutes
to finish writing patch descriptions, there will be a series removing this
usage from all IIO drivers except for a few very complex cases).

The SET_RUNTIME_PM_OPS call will make them unreferenced if CONFIG_PM not
enabled and hence the compiler can remove them.


> +static int ads1018_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ti_ads1018_state *st = iio_priv(indio_dev);
> +
> +	return ads1018_set_conv_mode(st, ADS1018_MODE_SINGLE_SHOT);
> +}
> +
> +static int ads1018_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ti_ads1018_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ads1018_set_conv_mode(st, ADS1018_MODE_CONTINUOUS);
> +	if (!ret)
> +		st->conv_invalid = true;
> +
> +	return ret;
> +}
> +#endif
> +
> +static const struct dev_pm_ops ads1018_pm_ops = {
> +	SET_RUNTIME_PM_OPS(ads1018_runtime_suspend,
> +			   ads1018_runtime_resume, NULL)
> +};
