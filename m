Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01DF2C74FF
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbgK1Vt3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732949AbgK1TEm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:04:42 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC63A2464B;
        Sat, 28 Nov 2020 13:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606568541;
        bh=PrmtuTE3V4qWPCxieqqJtJPdHhfBclzSNlVil0n6J8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VdIagGN6am5NcxQYFcGZl7kYI3PBriGS8YHlQzQ2ak6OldzfB5Of7nY4a7Q+S56uU
         WqDWuZgcnQisvdZOTrvzginXgcfYbnZhY4z9B1muBIOI4VblMaclETiMJRNKj0H7l8
         kTvwZt1VbC9O6frIIrLQrnyYtfgdLgQmsXw0KIM8=
Date:   Sat, 28 Nov 2020 13:02:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <tomislav.denis@avl.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Texas Instruments
 ADS131E0x ADC family
Message-ID: <20201128130216.3c48c122@archlinux>
In-Reply-To: <20201127194240.15060-2-tomislav.denis@avl.com>
References: <20201127194240.15060-1-tomislav.denis@avl.com>
        <20201127194240.15060-2-tomislav.denis@avl.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Nov 2020 20:42:39 +0100
<tomislav.denis@avl.com> wrote:

> From: Tomislav Denis <tomislav.denis@avl.com>
> 
> The ADS131E0x are a family of multichannel, simultaneous sampling,
> 24-bit, delta-sigma, analog-to-digital converters (ADCs) with a
> built-in programmable gain amplifier (PGA), internal reference
> and an onboard oscillator.
> 
> Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
Hi Tomislav,

Various comments inline.

Thanks,

Jonathan

> ---
>  MAINTAINERS                    |   6 +
>  drivers/iio/adc/Kconfig        |  12 +
>  drivers/iio/adc/Makefile       |   1 +
>  drivers/iio/adc/ti-ads131e08.c | 826 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 845 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads131e08.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 924616d..28bc5f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17220,6 +17220,12 @@ M:	Robert Richter <rric@kernel.org>
>  S:	Odd Fixes
>  F:	drivers/gpio/gpio-thunderx.c
>  
> +TI ADS131E0X ADC SERIES DRIVER
> +M:	Tomislav Denis <tomislav.denis@avl.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/adc/ti-ads131e08.c
> +
>  TI AM437X VPFE DRIVER
>  M:	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 91ae905..b82b6e0 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1140,6 +1140,18 @@ config TI_ADS124S08
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-ads124s08.
>  
> +config TI_ADS131E08
> +	tristate "Texas Instruments ADS131E08"
> +	depends on SPI && OF
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here you get support for Texas Instruments ADS131E08 and
> +	  ADS131E04 chips.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-ads131e08.
> +
>  config TI_AM335X_ADC
>  	tristate "TI's AM335X ADC driver"
>  	depends on MFD_TI_AM335X_TSCADC && HAS_DMA
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 90f94ad..b578315 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -102,6 +102,7 @@ obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
>  obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
>  obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
> +obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>  obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
>  obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
> diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
> new file mode 100644
> index 0000000..5799ab3
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads131e08.c
> @@ -0,0 +1,826 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Texas Instruments ADS131E0x 4-, 6-, and 8-Channel ADCs
> + *
> + * Copyright (c) 2020 AVL DiTEST GmbH
> + *   Tomislav Denis <tomislav.denis@avl.com>
> + *
> + * Datasheet: https://www.ti.com/lit/ds/symlink/ads131e08.pdf
> + */
> +
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/bitfield.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <asm/unaligned.h>
> +
> +/* Commands */
> +#define ADS131E08_CMD_RESET		0x06
> +#define ADS131E08_CMD_START		0x08
> +#define ADS131E08_CMD_STOP		0x0A
> +#define ADS131E08_CMD_OFFSETCAL		0x1A
> +#define ADS131E08_CMD_SDATAC		0x11
> +#define ADS131E08_CMD_RDATA		0x12
> +#define ADS131E08_CMD_RREG(r)		(0x20 | (r & 0x1F))

0x1F looks like a mask, so please use GENMASK for that.

> +#define ADS131E08_CMD_WREG(r)		(0x40 | (r & 0x1F))
> +
> +/* Registers */
> +#define ADS131E08_ADR_CFG1R		0x01
> +#define ADS131E08_ADR_CFG3R		0x03
> +#define ADS131E08_ADR_CH0R		0x05
> +
> +/* Configuration register 1 */
> +#define ADS131E08_CFG1R_DR_MASK		GENMASK(2, 0)
> +
> +/* Configuration register 3 */
> +#define ADS131E08_CFG3R_PDB_REFBUF_MASK	BIT(7)
> +#define ADS131E08_CFG3R_VREF_4V_MASK	BIT(5)
> +
> +/* Channel settings register */
> +#define ADS131E08_CHR_GAIN_MASK		GENMASK(6, 4)
> +#define ADS131E08_CHR_PWD_MASK		BIT(7)
> +
> +/* ADC  misc */
> +#define ADS131E08_DEFAULT_DATA_RATE	1
> +#define ADS131E08_DEFAULT_PGA_GAIN	1
> +
> +#define ADS131E08_VREF_2V4_MV		2400
> +#define ADS131E08_VREF_4V_MV		4000
> +
> +#define ADS131E08_WAIT_RESET_CYCLES	18
> +#define ADS131E08_WAIT_SDECODE_CYCLES	4
> +#define ADS131E08_WAIT_OFFSETCAL_MS	153
> +#define ADS131E08_MAX_SETTLING_TIME_MS	6
> +
> +#define ADS131E08_NUM_CHN_MAX		8
> +
> +#define ADS131E08_NUM_STATUS_BYTES	3
> +#define ADS131E08_NUM_DATA_BYTES_MAX	3
> +#define ADS131E08_NUM_DATA_BYTES(dr)	(((dr) >= 32) ? 2 : 3)
> +#define ADS131E08_NUM_DATA_BITS(dr)	(ADS131E08_NUM_DATA_BYTES(dr) * 8)
> +#define ADS131E08_NUM_STORAGE_BYTES	4
> +#define ADS131E08_NUM_STORAGE_BITS	(ADS131E08_NUM_STORAGE_BYTES * 8)
> +
> +enum ads131e08_ids {
> +	ads131e04,
> +	ads131e08,
> +};
> +
> +struct ads131e08_info {
> +	unsigned int max_channels;
> +};
> +
> +struct ads131e08_state {
> +	const struct ads131e08_info *info;
> +	struct spi_device *spi;
> +	struct iio_trigger *trig;
> +	struct clk *adc_clk;
> +	struct regulator *vref_reg;
> +	unsigned int data_rate;
> +	unsigned int pga_gain;
> +	unsigned int vref_mv;
> +	unsigned int sdecode_delay_us;
> +	unsigned int reset_delay_us;
> +	unsigned int readback_len;
> +	struct completion completion;
> +
> +	/*
> +	 * Add extra one padding byte to be able to access the last channel
> +	 * value using u32 pointer
> +	 */
> +	u8 rx_buf[ADS131E08_NUM_STATUS_BYTES +
> +		ADS131E08_NUM_CHN_MAX * ADS131E08_NUM_DATA_BYTES_MAX + 1];

May be used for DMA, so you need to sure appropriate alignment.
____cache_line_aligned will do that as long as you are then careful about
an following elements to make sure they don't end up in the same cacheline
(here just move tmp_buf before rx_buf)

Note that I've suggested below that you pull tx in here as well. That can
share a cacheline with the rx_buf as it's always assumed no SPI controller
is going to be dumb enough to cause trouble with it's own buffers.

> +	u8 tmp_buf[ADS131E08_NUM_CHN_MAX * ADS131E08_NUM_DATA_BYTES_MAX];

> +};
> +
> +static const struct ads131e08_info ads131e08_info_tbl[] = {
> +	[ads131e04] = {
> +		.max_channels = 4,
> +	},
> +	[ads131e08] = {
> +		.max_channels = 8,
> +	},
> +};
> +
> +struct ads131e08_data_rate_desc {
> +	unsigned int rate;  /* data rate in kSPS */
> +	u8 reg;             /* reg value */
> +};
> +
> +static const struct ads131e08_data_rate_desc ads131e08_data_rate_tbl[] = {
> +	{ .rate = 64,   .reg = 0x00 },
> +	{ .rate = 32,   .reg = 0x01 },
> +	{ .rate = 16,   .reg = 0x02 },
> +	{ .rate = 8,    .reg = 0x03 },
> +	{ .rate = 4,    .reg = 0x04 },
> +	{ .rate = 2,    .reg = 0x05 },
> +	{ .rate = 1,    .reg = 0x06 },
> +};
> +
> +struct ads131e08_pga_gain_desc {
> +	unsigned int gain;  /* PGA gain value */
> +	u8 reg;             /* reg value */
> +};
> +
> +static const struct ads131e08_pga_gain_desc ads131e08_pga_gain_tbl[] = {
> +	{ .gain = 1,   .reg = 0x01 },
> +	{ .gain = 2,   .reg = 0x02 },
> +	{ .gain = 4,   .reg = 0x04 },
> +	{ .gain = 8,   .reg = 0x05 },
> +	{ .gain = 12,  .reg = 0x06 },
> +};
> +
> +static int ads131e08_exec_cmd(struct ads131e08_state *st, u8 cmd)
> +{
> +	int ret;
> +
> +	ret = spi_write(st->spi, &cmd, 1);
spi_write is a wrapper around spi_sync and spi_sync requires DMA safe buffers.
If you want to avoid that, use

spi_write_then_read() which uses a bounce buffer (but set the read size to 0)

> +	if (ret) {
> +		dev_err(&st->spi->dev,
> +			"%s: SPI write failed for cmd: %02x\n", __func__, cmd);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ads131e08_read_reg(struct ads131e08_state *st, u8 reg)
> +{
> +	u8 rx;
> +	int ret;
> +
> +	u8 tx_buf[] = {
> +		ADS131E08_CMD_RREG(reg),
> +		0,
> +	};

As below. DMA safety.

> +
> +	struct spi_transfer transfer[] = {
> +		{
> +			.tx_buf = tx_buf,
> +			.len = ARRAY_SIZE(tx_buf),
> +			.delay_usecs = st->sdecode_delay_us,
> +		}, {
> +			.rx_buf = &rx,
> +			.len = 1,
> +		},
> +	};
> +
> +	ret = spi_sync_transfer(st->spi, transfer, ARRAY_SIZE(transfer));
> +	if (ret) {
> +		dev_err(&st->spi->dev, "%s: SPI transfer failed\n", __func__);
> +		return ret;
> +	}
> +
> +	return rx;
> +}
> +
> +static int ads131e08_write_reg(struct ads131e08_state *st, u8 reg, u8 value)
> +{
> +	int ret;
> +
> +	u8 tx_buf[] = {
> +		ADS131E08_CMD_WREG(reg),
> +		0,
> +		value,
> +	};
> +
> +	struct spi_transfer transfer[] = {
> +		{
> +			.tx_buf = tx_buf,
> +			.len = ARRAY_SIZE(tx_buf),
> +			.delay_usecs = st->sdecode_delay_us,
> +		}
> +	};
> +
> +	ret = spi_sync_transfer(st->spi, transfer, ARRAY_SIZE(transfer));
> +	if (ret) {
> +		dev_err(&st->spi->dev, "%s: SPI transfer failed\n", __func__);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ads131e08_read_data(struct ads131e08_state *st, int rx_len)
> +{
> +	int ret;
> +
> +	u8 tx_buf[] = {
> +		ADS131E08_CMD_RDATA,
> +	};

SPI buffers generally need to DMA safe.  That one isn't.
I'd put it in the state structure like you have done for rx.

> +
> +	struct spi_transfer transfer[] = {
> +		{
> +			.tx_buf = tx_buf,
> +			.len = ARRAY_SIZE(tx_buf),
> +		}, {
> +			.rx_buf = &st->rx_buf,
> +			.len = rx_len,
> +		},
> +	};
> +
> +	ret = spi_sync_transfer(st->spi, transfer, ARRAY_SIZE(transfer));
> +	if (ret) {
> +		dev_err(&st->spi->dev, "%s: SPI transfer failed\n", __func__);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ads131e08_set_data_rate(struct ads131e08_state *st, int data_rate)
> +{
> +	int ret, i, reg;
> +
> +	for (i = 0; i < ARRAY_SIZE(ads131e08_data_rate_tbl); ++i) {
> +		if (ads131e08_data_rate_tbl[i].rate == data_rate)
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(ads131e08_data_rate_tbl)) {
> +		dev_err(&st->spi->dev, "invalid data rate value\n");
> +		return -EINVAL;
> +	}
> +
> +	reg = ads131e08_read_reg(st, ADS131E08_ADR_CFG1R);
> +	if (reg < 0)
> +		return reg;
> +
> +	reg &= ~ADS131E08_CFG1R_DR_MASK;
> +	reg |= FIELD_PREP(ADS131E08_CFG1R_DR_MASK,
> +		ads131e08_data_rate_tbl[i].reg);
> +
> +	ret = ads131e08_write_reg(st, ADS131E08_ADR_CFG1R, reg);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ads131e08_set_pga_gain(struct ads131e08_state *st,
> +	unsigned int channel, unsigned int pga_gain)
> +{
> +	int ret, i, reg;
> +
> +	for (i = 0; i < ARRAY_SIZE(ads131e08_pga_gain_tbl); ++i) {
> +		if (ads131e08_pga_gain_tbl[i].gain == pga_gain)
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(ads131e08_pga_gain_tbl)) {
> +		dev_err(&st->spi->dev, "invalid PGA gain value\n");
> +		return -EINVAL;
> +	}
> +
> +	reg = ads131e08_read_reg(st, ADS131E08_ADR_CH0R + channel);
> +	if (reg < 0)
> +		return reg;
> +
> +	reg &= ~ADS131E08_CHR_GAIN_MASK;
> +	reg |= FIELD_PREP(ADS131E08_CHR_GAIN_MASK,
> +		ads131e08_pga_gain_tbl[i].reg);

Align with opening bracket - or just put it on one line as it'll only be jsut
over 80 characters and it will be easier to read.

> +
> +	ret = ads131e08_write_reg(st, ADS131E08_ADR_CH0R + channel, reg);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ads131e08_power_down_channel(struct ads131e08_state *st,
> +	unsigned int channel, bool value)
> +{
> +	int ret, reg;
> +
> +	reg = ads131e08_read_reg(st, ADS131E08_ADR_CH0R + channel);
> +	if (reg < 0)
> +		return reg;
> +
> +	reg &= ~ADS131E08_CHR_PWD_MASK;
> +	reg |= FIELD_PREP(ADS131E08_CHR_PWD_MASK, value);
> +
> +	ret = ads131e08_write_reg(st, ADS131E08_ADR_CH0R + channel, reg);
> +	if (ret)
> +		return ret;

return ads131...
Same elsewhere.  We might as well compact the code a bit where it
doesn't hurt readability.


> +
> +	return 0;
> +}
> +
> +static int ads131e08_config_reference_voltage(struct ads131e08_state *st)
> +{
> +	int ret, reg;
> +
> +	reg = ads131e08_read_reg(st, ADS131E08_ADR_CFG3R);
> +	if (reg < 0)
> +		return reg;
> +
> +	if (st->vref_reg) {
> +		/* Use external reference voltage */
> +		reg &= ~ADS131E08_CFG3R_PDB_REFBUF_MASK;
> +	} else {
> +		/* Use internal reference voltage */
> +		reg &= ~ADS131E08_CFG3R_PDB_REFBUF_MASK |
> +			~ADS131E08_CFG3R_VREF_4V_MASK;
> +		reg |= FIELD_PREP(ADS131E08_CFG3R_PDB_REFBUF_MASK, 1);
> +		reg |= FIELD_PREP(ADS131E08_CFG3R_VREF_4V_MASK,
> +			st->vref_mv == ADS131E08_VREF_4V_MV);
> +	}
> +
> +	ret = ads131e08_write_reg(st, ADS131E08_ADR_CFG3R, reg);
> +	if (ret)
> +		return ret;
> +

return ads131...

> +	return 0;
> +}
> +
> +static int ads131e08_initial_config(struct iio_dev *indio_dev)
> +{
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +	const struct iio_chan_spec *channel = indio_dev->channels;
> +	int ret, i;
> +	u8 active_channels = 0;
> +
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_RESET);
> +	if (ret)
> +		return ret;
> +
> +	udelay(st->reset_delay_us);
> +
> +	/* Disable read data in continuous mode (enabled by default) */
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_SDATAC);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads131e08_set_data_rate(st, st->data_rate);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads131e08_config_reference_voltage(st);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0;  i < indio_dev->num_channels; ++i) {
> +		ret = ads131e08_set_pga_gain(st, channel->channel,
> +			st->pga_gain);
> +		if (ret)
> +			return ret;
> +
> +		active_channels |= BIT(channel->channel);
> +		channel++;
> +	}
> +
> +	/* Power down unused channels */
> +	for (i = 0; i < st->info->max_channels; ++i) {
> +		if (!(active_channels & BIT(i))) {
> +			ret = ads131e08_power_down_channel(st, i, true);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	/* Request channel offset calibration */
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_OFFSETCAL);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Channel offset calibration is triggered with first START command.
> +	 * Since calibration take more time than settling operation,
> +	 * this causes timeout error when command START is sent first
> +	 * time (e.g. first call of the ads131e08_read_direct method).
> +	 * To avoid this problem offset calibration is triggered here.
> +	 */
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_START);
> +	if (ret)
> +		return ret;
> +
> +	msleep(ADS131E08_WAIT_OFFSETCAL_MS);
> +
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_STOP);

return ads13...

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int ads131e08_read_direct(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *channel, int *value)
> +{
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +	int ret;
> +	u8 num_bits, *src;
> +
> +	reinit_completion(&st->completion);
> +
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_START);
> +	if (ret)
> +		return ret;
> +
> +	ret = wait_for_completion_timeout(&st->completion,
> +		msecs_to_jiffies(ADS131E08_MAX_SETTLING_TIME_MS));
> +	if (!ret)
> +		return -ETIMEDOUT;
> +
> +	ret = ads131e08_read_data(st, st->readback_len);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_STOP);
> +	if (ret)
> +		return ret;
> +
> +	num_bits = channel->scan_type.realbits;
> +	src = st->rx_buf + ADS131E08_NUM_STATUS_BYTES +
> +		channel->channel * ADS131E08_NUM_DATA_BYTES(st->data_rate);
> +
> +	*value = sign_extend32(
> +		get_unaligned_be32(src) >> (32 - num_bits), num_bits - 1);
> +
> +	return ret;
> +}
> +
> +static int ads131e08_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *channel, int *value,
> +	int *value2, long mask)
> +{
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = ads131e08_read_direct(indio_dev, channel, value);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*value = st->vref_mv / st->pga_gain;
> +		*value2 = channel->scan_type.realbits - 1;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ads131e08_validate_trigger(struct iio_dev *indio_dev,
> +	struct iio_trigger *trig)
> +{
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +
> +	if (st->trig != trig)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ads131e08_debugfs_reg_access(struct iio_dev *indio_dev,
> +	unsigned int reg, unsigned int writeval, unsigned int *readval)
> +{
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +
> +	if (readval) {
> +		int ret = ads131e08_read_reg(st, (u8)reg);
> +		*readval = ret;
> +		return ret;
> +	}
> +
> +	return ads131e08_write_reg(st, (u8)reg, (u8)writeval);
> +}
> +
> +static const struct iio_info ads131e08_iio_info = {
> +	.read_raw = ads131e08_read_raw,
> +	.validate_trigger = &ads131e08_validate_trigger,
> +	.debugfs_reg_access = &ads131e08_debugfs_reg_access,
> +};
> +
> +static int ads131e08_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +	u8 cmd = state ? ADS131E08_CMD_START : ADS131E08_CMD_STOP;
> +
> +	return ads131e08_exec_cmd(st, cmd);
> +}
> +
> +static const struct iio_trigger_ops ads131e08_trigger_ops = {
> +	.validate_device = &iio_trigger_validate_own_device,

Why?  I can't immediately see why we couldn't let other devices
run in sync with this one by sharing the trigger.

> +	.set_trigger_state = &ads131e08_set_trigger_state,
> +};
> +
> +static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int num_dbytes = ADS131E08_NUM_DATA_BYTES(st->data_rate);
> +	unsigned int chn, i = 0;
> +
> +	ret = ads131e08_read_data(st, st->readback_len);
> +	if (ret)
> +		goto out;
> +
> +	for_each_set_bit(chn, indio_dev->active_scan_mask,
> +		indio_dev->masklength) {
> +		memcpy(st->tmp_buf + i * ADS131E08_NUM_STORAGE_BYTES,
> +			st->rx_buf + ADS131E08_NUM_STATUS_BYTES + chn * num_dbytes,
> +			num_dbytes);
> +		i++;
> +	}
> +
> +	iio_push_to_buffers(indio_dev, st->tmp_buf);

Why no timestamp?

Note that if you do provide one you'll have to ensure st->tmp_buf is 8 byte
aligned.

> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ads131e08_interrupt(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		iio_trigger_poll_chained(st->trig);
> +	else
> +		complete(&st->completion);

We don't do anything that needs to sleep in here and it's trivial so
I'd be tempted to do it in a top half handler rather than the thread.
In particular the completion shouldn't require spinning up the
thread.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ads131e08_parse_dt(struct iio_dev *indio_dev,
> +	struct device_node *node)
> +{
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +	struct iio_chan_spec *channels, *channel;
> +	int vrefsel, num_channels;
> +	struct property *prop;
> +	const __be32 *cur;
> +	u32 value;
> +
> +	if (of_property_read_u32(node, "ti,datarate", &st->data_rate))
> +		st->data_rate = ADS131E08_DEFAULT_DATA_RATE;
> +
> +	if (of_property_read_u32(node, "ti,gain", &st->pga_gain))
> +		st->pga_gain = ADS131E08_DEFAULT_PGA_GAIN;

I think this should be per channel (from a very quick glance at datasheet!)

> +
> +	if (of_property_read_u32(node, "ti,vref-sel", &vrefsel))
> +		vrefsel = 0;

I mention in the binding review that I'd expect default for the case
where an external regulator is specified to always be the external
regulator (someone bothered to put it down on the board!)
That will flip some of this logic around.

> +
> +	switch (vrefsel) {
> +	case 0:
> +		st->vref_mv = ADS131E08_VREF_2V4_MV;
> +		break;
> +	case 1:
> +		st->vref_mv = ADS131E08_VREF_4V_MV;
> +		break;
> +	case 2:
> +		st->vref_mv = 0;
> +		break;
> +	default:
> +		st->vref_mv = ADS131E08_VREF_2V4_MV;
> +	}
> +
> +	num_channels = of_property_count_elems_of_size(node,
> +		"ti,adc-channels", sizeof(u32));

In the binding review I request that you change to subnodes.  That
does make this bit of code more complex, but also allows per channel PGA
settings.

> +	if (num_channels == 0) {
> +		dev_err(&st->spi->dev, "no valid channels property\n");
> +		return -ENODEV;
> +	}
> +
> +	if (num_channels > st->info->max_channels) {
> +		dev_err(&st->spi->dev, "num of channels out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	channels = devm_kcalloc(&st->spi->dev, num_channels,
> +		sizeof(struct iio_chan_spec), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	channel = channels;
> +	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, value) {
> +		channel->type = IIO_VOLTAGE;
> +		channel->indexed = 1;
> +		channel->channel = value;
> +		channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +		channel->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> +		channel->scan_index = value;
> +		channel->scan_type.sign = 's';
> +		channel->scan_type.realbits =
> +			ADS131E08_NUM_DATA_BITS(st->data_rate);
> +		channel->scan_type.storagebits = ADS131E08_NUM_STORAGE_BITS;
> +		channel->scan_type.shift = 8;
It's a bit odd to mix defines and direct values here. I'd argue storeagebits
is a real number so doesn't make sense to hide it in a define.

> +		channel->scan_type.endianness = IIO_BE;
> +		channel++;
> +	}
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = num_channels;
> +
> +	return 0;
> +}
> +
> +static int ads131e08_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ads131e08_state *st;
> +	int ret;
> +	unsigned long adc_clk_hz, adc_clk_ns;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev) {
> +		dev_err(&spi->dev, "failed to allocate IIO device\n");
> +		return -ENOMEM;
> +	}
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	st = iio_priv(indio_dev);
> +	st->info = &ads131e08_info_tbl[spi_get_device_id(spi)->driver_data];
> +	st->spi = spi;
> +
> +	ret = ads131e08_parse_dt(indio_dev, spi->dev.of_node);
> +	if (ret)
> +		return ret;
> +
> +	st->readback_len = ADS131E08_NUM_STATUS_BYTES +
> +		ADS131E08_NUM_DATA_BYTES(st->data_rate) *
> +		st->info->max_channels;
> +
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->dev.of_node = spi->dev.of_node;
> +	indio_dev->info = &ads131e08_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	init_completion(&st->completion);
> +
> +	if (spi->irq) {
> +		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
> +			NULL, ads131e08_interrupt,
> +			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +			spi->dev.driver->name, indio_dev);
> +		if (ret) {
> +			dev_err(&spi->dev, "failed to allocate IRQ\n");
> +			return ret;
> +		}
> +	} else {
> +		dev_err(&spi->dev, "data ready IRQ missing\n");
> +		return -ENODEV;
> +	}
> +
> +	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> +		indio_dev->name, indio_dev->id);
> +	if (!st->trig) {
> +		dev_err(&spi->dev, "failed to allocate IIO trigger\n");
> +		return -ENOMEM;
> +	}
> +
> +	st->trig->ops = &ads131e08_trigger_ops;
> +	st->trig->dev.parent = &spi->dev;
> +	iio_trigger_set_drvdata(st->trig, indio_dev);
> +	ret = devm_iio_trigger_register(&spi->dev, st->trig);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to register IIO trigger\n");
> +		goto err_disable_reg;
> +	}
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +		NULL, &ads131e08_trigger_handler, NULL);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to setup IIO buffer\n");
> +		return ret;
> +	}
> +
> +	st->adc_clk = devm_clk_get(&spi->dev, "adc-clk");
> +	if (IS_ERR(st->adc_clk)) {
> +		dev_err(&spi->dev, "failed to get the ADC clock\n");
> +		return PTR_ERR(st->adc_clk);
> +	}
> +
> +	ret = clk_prepare_enable(st->adc_clk);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to prepare/enable the ADC clock\n");
> +		return ret;
> +	}
> +
> +	adc_clk_hz = clk_get_rate(st->adc_clk);
> +	if (!adc_clk_hz) {
> +		dev_err(&spi->dev, "failed to get the ADC clock rate\n");
> +		ret = -EINVAL;
> +		goto err_disable_clk;
> +	}
> +
> +	adc_clk_ns = NSEC_PER_SEC / adc_clk_hz;
> +	st->sdecode_delay_us = DIV_ROUND_UP(
> +		ADS131E08_WAIT_SDECODE_CYCLES * adc_clk_ns, 1000);
> +	st->reset_delay_us = DIV_ROUND_UP(
> +		ADS131E08_WAIT_RESET_CYCLES * adc_clk_ns, 1000);
> +
> +	if (st->vref_mv == 0) {
> +		st->vref_reg = devm_regulator_get(&spi->dev, "vref");
> +		if (IS_ERR(st->vref_reg)) {
> +			dev_err(&spi->dev,
> +				"failed to get vref regulator\n");
> +			ret = PTR_ERR(st->vref_reg);
> +			goto err_disable_clk;
> +		}
> +
> +		ret = regulator_enable(st->vref_reg);
> +		if (ret) {
> +			dev_err(&spi->dev,
> +				"failed to enable external vref supply\n");
> +			goto err_disable_clk;
> +		}
> +
> +		ret = regulator_get_voltage(st->vref_reg);
> +		if (ret < 0) {
> +			dev_err(&spi->dev, "failed to get vref voltage\n");
> +			goto err_disable_reg;
> +		}
> +
> +		st->vref_mv = ret / 1000;
> +	}
> +
> +	ret = ads131e08_initial_config(indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "initial configuration failed\n");
> +		goto err_disable_reg;
> +	}
> +
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);

See below about mixing devm and non devm.

> +	if (ret) {
> +		dev_err(&spi->dev, "failed to register IIO device\n");
> +		goto err_disable_reg;
> +	}
> +
> +	return 0;
> +
> +err_disable_reg:
> +	regulator_disable(st->vref_reg);
> +
> +err_disable_clk:
> +	clk_disable_unprepare(st->adc_clk);
> +
> +	return ret;
> +}
> +
> +static int ads131e08_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +
> +	if (st->vref_reg)
> +		regulator_disable(st->vref_reg);
> +
> +	clk_disable_unprepare(st->adc_clk);
You shouldn't mix devm and unmanaged clean up.  
Here this results in a race where the userspace interfaces are still available 
after you've turned off the power and clocks.

2 solutions to this.
1) The first time you make a call in probe that is not a device managed
call, switch to only use the non managed forms.
2) Make everything device managed - devm_add_action_or_reset() can be used
for those elements that don't have existing managed forms.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ads131e08_of_match[] = {
> +	{ .compatible = "ti,ads131e04", },
> +	{ .compatible = "ti,ads131e08", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ads131e08_matches);
> +
> +static const struct spi_device_id ads131e08_id[] = {
> +	{ "ads131e04",      ads131e04},
> +	{ "ads131e08",      ads131e08},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ads131e08_id);
> +
> +static struct spi_driver ads131e08_driver = {
> +	.driver = {
> +		.name = "ads131e08",
> +		.of_match_table = ads131e08_of_match,
> +	},
> +	.probe = ads131e08_probe,
> +	.remove = ads131e08_remove,
> +	.id_table = ads131e08_id,
> +};
> +module_spi_driver(ads131e08_driver);
> +
> +MODULE_AUTHOR("Tomislav Denis <tomislav.denis@avl.com>");
> +MODULE_DESCRIPTION("Driver for ADS131E0x ADC family");
> +MODULE_LICENSE("GPL v2");

