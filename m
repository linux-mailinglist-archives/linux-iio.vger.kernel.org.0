Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B50F6A5F
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 17:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfKJQzi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 11:55:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfKJQzi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 11:55:38 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 509422080F;
        Sun, 10 Nov 2019 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573404936;
        bh=ZeL0mFFVvPLfdTXKxsVtkP2EBoVHVXAiFb7AvAjFyr4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f/omshvZl/1w3YMwkF/eABj0KSE7sNLurs98gzfQ+enqR8mXPmscpM60WSVOwcAKg
         lFrcnwcKckEW2scwqvKbgH4TyMvb4yAHzbhzt6AmDiUBw6P1j68JMwHLl3kJ/Ldo6J
         7SRdpYgx4I36ePjWpPg/nFtQ2TJopXG2fbga3WTQ=
Date:   Sun, 10 Nov 2019 16:55:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: add driver support for AD5940
Message-ID: <20191110165529.78a4714a@archlinux>
In-Reply-To: <20191108130946.14740-2-songqiang1304521@gmail.com>
References: <20191108130946.14740-1-songqiang1304521@gmail.com>
        <20191108130946.14740-2-songqiang1304521@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  8 Nov 2019 21:09:45 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> The AD5940 is a high precision, low power analog front end (AFE)
> designed for portable applications that require high precision,
> electrochemical-based measurement techniques, such as amper-
> ometric, voltammetric, or impedance measurements.
> 
> Datasheet:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5940.pdf
> 
> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>

Nice little driver on the whole.  I'm guessing this is very much the 'first of
many' patches to support this complex part.  Makes sense and keeps it manageable
from a review point of view.

A few comments inline.

Thanks,

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-adc-ad5940      |   7 +
>  drivers/iio/adc/Kconfig                       |  10 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/ad5940.c                      | 679 ++++++++++++++++++
>  4 files changed, 697 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad5940
>  create mode 100644 drivers/iio/adc/ad5940.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad5940 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad5940
> new file mode 100644
> index 000000000000..839644ffbd9b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad5940
> @@ -0,0 +1,7 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_voltageY-voltageZ_name
> +Date:		June 2019
> +KernelVersion:	4.14.5
> +Contact:	songqiang1304521@gmail.com
> +Description:
> +		Channel name assigned in devicetree, used to tell userspace
> +		users which channel this is.
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f0af3a42f53c..345f934d3444 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -11,6 +11,16 @@ config AD_SIGMA_DELTA
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  
> +config AD5940
> +	tristate "Analog Devices AD5940 ADC Driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for the ADC part of Analog Devices
> +	  analog front end AD5940.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad5940.
> +
>  config AD7124
>  	tristate "Analog Devices AD7124 and similar sigma-delta ADCs driver"
>  	depends on SPI_MASTER
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ef9cc485fb67..ac52d1b6f3fb 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -5,6 +5,7 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
> +obj-$(CONFIG_AD5940) += ad5940.o
>  obj-$(CONFIG_AD7124) += ad7124.o
>  obj-$(CONFIG_AD7266) += ad7266.o
>  obj-$(CONFIG_AD7291) += ad7291.o
> diff --git a/drivers/iio/adc/ad5940.c b/drivers/iio/adc/ad5940.c
> new file mode 100644
> index 000000000000..57f737edca36
> --- /dev/null
> +++ b/drivers/iio/adc/ad5940.c
> @@ -0,0 +1,679 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AD5940 SPI ADC driver
> + *
> + * Copyright (C) 2019 Song Qiang <songqiang1304521@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bsearch.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define AD5940_CHANNEL_AINP_MSK		GENMASK(5, 0)
> +#define AD5940_CHANNEL_AINP(x)		FIELD_PREP(AD5940_CHANNEL_AINP_MSK, x)
> +#define AD5940_CHANNEL_AINN_MSK		GENMASK(12, 8)
> +#define AD5940_CHANNEL_AINN(x)		FIELD_PREP(AD5940_CHANNEL_AINN_MSK, x)
> +
> +#define AD5940_CHANNEL_NAME		0
> +
> +#define AD5940_SPICMD_SETADDR		0x20
> +#define AD5940_SPICMD_READREG		0x6d
> +#define AD5940_SPICMD_WRITEREG		0x2d
> +#define AD5940_SPICMD_READFIFO		0x5f
> +
> +#define AD5940_REG_AFECON		0x00002000
> +#define AD5940_AFECON_ADCCONV_MSK	BIT(8)
> +#define AD5940_AFECON_ADCCONV_EN	FIELD_PREP(AD5940_AFECON_ADCCONV_MSK, 1)
> +#define AD5940_AFECON_ADCCONV_DIS	FIELD_PREP(AD5940_AFECON_ADCCONV_MSK, 0)
> +#define AD5940_AFECON_ADCEN_MSK		BIT(7)
> +#define AD5940_AFECON_ADCEN		FIELD_PREP(AD5940_AFECON_ADCEN_MSK, 1)
> +
> +#define AD5940_REG_ADCDAT		0x00002074
> +#define AD5940_REG_DFTREAL		0x00002078
> +#define AD5940_REG_DFTIMAG		0x0000207C
> +#define AD5940_REG_SINC2DAT		0x00002080
> +#define AD5940_REG_TEMPSENSDAT		0x00002084
> +#define AD5940_REG_STATSMEAN		0x000021C8
> +#define AD5940_REG_STATSVAR		0x000021C0
> +
> +#define AD5940_REG_INTCPOL		0x00003000 /* Interrupt Polarity. */
> +#define AD5940_INTCPOL_MSK		BIT(0)
> +#define AD5940_INTCPOL_POS		FIELD_PREP(AD5940_INTCPOL_MSK, 1)
> +#define AD5940_INTCPOL_NEG		FIELD_PREP(AD5940_INTCPOL_MSK, 0)
> +#define AD5940_REG_INTCLR		0x00003004
> +
> +#define AD5940_REG_PMBW			0x000022F0
> +#define	AD5940_PMBW_SYSHS_MSK		BIT(0)
> +#define	AD5940_PMBW_HP			FIELD_PREP(AD5940_PMBW_SYSHS_MSK, 1)
> +#define	AD5940_PMBW_LP			FIELD_PREP(AD5940_PMBW_SYSHS_MSK, 0)
> +#define AD5940_PMBW_SYSBW_MSK		GENMASK(3, 2)
> +#define	AD5940_PMBW_BWNA		FIELD_PREP(AD5940_PMBW_SYSBW_MSK, 0)
> +#define	AD5940_PMBW_BW50		FIELD_PREP(AD5940_PMBW_SYSBW_MSK, 1)
> +#define	AD5940_PMBW_BW100		FIELD_PREP(AD5940_PMBW_SYSBW_MSK, 2)
> +#define	AD5940_PMBW_BW250		FIELD_PREP(AD5940_PMBW_SYSBW_MSK, 3)
> +
> +#define AD5940_REG_ADCCON		0x000021A8
> +#define AD5940_ADCCON_PGA_MSK		GENMASK(18, 16)
> +#define AD5940_ADCCON_PGA_1		FIELD_PREP(AD5940_ADCCON_PGA_MSK, 0)
> +#define AD5940_ADCCON_PGA_1P5		FIELD_PREP(AD5940_ADCCON_PGA_MSK, 1)
> +#define AD5940_ADCCON_PGA_2		FIELD_PREP(AD5940_ADCCON_PGA_MSK, 2)
> +#define AD5940_ADCCON_PGA_4		FIELD_PREP(AD5940_ADCCON_PGA_MSK, 3)
> +#define AD5940_ADCCON_PGA_9		FIELD_PREP(AD5940_ADCCON_PGA_MSK, 4)
> +#define AD5940_ADCCON_MUX_MSK		(GENMASK(12, 8) | GENMASK(5, 0))
> +
> +#define AD5940_REG_INTCLR		0x00003004
> +#define AD5940_REG_INTCSEL0		0x00003008
> +#define AD5940_INTC_BRK			BIT(31)
> +#define AD5940_INTC_OUTLIER		BIT(29)
> +#define AD5940_INTC_FIFO_UNDERFLOW	BIT(27)
> +#define AD5940_INTC_FIFO_OVERFLOW	BIT(26)
> +#define AD5940_INTC_FIFO_THRESHOLD	BIT(25)
> +#define AD5940_INTC_FIFO_EMPTY		BIT(24)
> +#define AD5940_INTC_FIFO_FULL		BIT(23)
> +#define AD5940_INTC_SEQ_TO_ERR		BIT(17)
> +#define AD5940_INTC_SEQ_TO_FINISH	BIT(16)
> +#define AD5940_INTC_SEQ_END		BIT(15)
> +#define AD5940_INTC_BL_DONE		BIT(13)
> +#define AD5940_INTC_IRQ_3		BIT(12)
> +#define AD5940_INTC_IRQ_2		BIT(11)
> +#define AD5940_INTC_IRQ_1		BIT(10)
> +#define AD5940_INTC_IRQ_0		BIT(9)
> +#define AD5940_INTC_VAR			BIT(8)
> +#define AD5940_INTC_MEAN		BIT(7)
> +#define AD5940_INTC_ADC_DELTA_FAIL	BIT(6)
> +#define AD5940_INTC_ADC_MAX_FAIL	BIT(5)
> +#define AD5940_INTC_ADC_MIN_FAIL	BIT(4)
> +#define AD5940_INTC_TEMP		BIT(3)
> +#define AD5940_INTC_SINC2		BIT(2)
> +#define AD5940_INTC_DFT			BIT(1)
> +#define AD5940_INTC_ADC			BIT(0)
> +
> +#define AD5940_REG_GP0CON		0x00000000
> +#define AD5940_GP0CON_3_MSK		GENMASK(7, 6)
> +#define AD5940_GP0CON_3_INT		FIELD_PREP(AD5940_GP0CON_3_MSK, 3)
> +#define AD5940_GP0CON_6_MSK		GENMASK(13, 12)
> +#define AD5940_GP0CON_6_INT		FIELD_PREP(AD5940_GP0CON_6_MSK, 3)
> +
> +#define AD5940_REG_GP0OEN		0x00000004
> +
> +#define AD5940_AFECON_CHIPID		0x00000404
> +#define AD5940_CHIPID			0x5502
> +
> +struct ad5940_channel_config {
> +	u32 ain;
> +	const char *channel_name;
> +};
> +
> +struct ad5940_state {
> +	struct spi_device *spi;
> +	/* This mutex is for protecting the SPI command sequences. */
> +	struct mutex lock;
> +
> +	struct completion complete;
> +	u32 conversion_time;
> +
> +	u8 n_input;
> +	u8 p_input;
> +
> +	struct regulator *vref;
> +	int vref_mv;
> +
> +	int num_channels;
> +	struct ad5940_channel_config *channel_config;
> +	union {
> +		__be32 d32;
> +		u8 d8[5];
> +	} data ____cacheline_aligned;
> +};
> +
> +static int ad5940_set_addr(struct ad5940_state *st, u16 addr)
> +{
> +	st->data.d8[0] = AD5940_SPICMD_SETADDR;
> +	st->data.d8[1] = (addr >> 8) & 0xff;
> +	st->data.d8[2] = addr & 0xff;
> +
> +	return spi_write(st->spi, st->data.d8, 3);
> +}
> +
> +static int ad5940_read_reg(struct ad5940_state *st, u16 addr, u32 *data)
> +{
> +	int rx_len;
> +	u8 shift;
> +	int ret;
> +
> +	ret = ad5940_set_addr(st, addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((addr >= 0x1000) && (addr <= 0x3014))
> +		rx_len = 4;
> +	else
> +		rx_len = 2;
> +
> +	st->data.d8[0] = AD5940_SPICMD_READREG;
> +	st->data.d8[1] = 0;
> +	shift = 32 - (8 * rx_len);
> +
> +	ret = spi_write_then_read(st->spi, st->data.d8, 2, &st->data.d32,
> +				  rx_len);
> +	if (ret < 0)
> +		return ret;
> +
> +	*data = be32_to_cpu(st->data.d32) >> shift;
> +
> +	return 0;
> +}
> +
> +static int ad5940_write_reg(struct ad5940_state *st, u16 addr, u32 data)
> +{
> +	int tx_len;
> +	int ret;
> +
> +	ret = ad5940_set_addr(st, addr);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->data.d8[0] = AD5940_SPICMD_WRITEREG;
> +	if ((addr >= 0x1000) && (addr <= 0x3014)) {
> +		st->data.d8[1] = (data >> 24) & 0xff;
> +		st->data.d8[2] = (data >> 16) & 0xff;
> +		st->data.d8[3] = (data >> 8) & 0xff;
> +		st->data.d8[4] = data & 0xff;
> +		tx_len = 5;
> +	} else {
> +		st->data.d8[1] = (data >> 8) & 0xff;
> +		st->data.d8[2] = data & 0xff;
> +		tx_len = 3;
> +	}
> +
> +	return spi_write(st->spi, st->data.d8, tx_len);
> +}
> +
> +static int ad5940_write_reg_mask(struct ad5940_state *st, u16 addr,
> +				 u32 mask, u32 data)
> +{
> +	u32 temp;
> +	int ret;
> +
> +	ret = ad5940_read_reg(st, addr, &temp);
> +	if (ret < 0)
> +		return ret;
> +
> +	temp &= ~mask;
> +	temp |= data;
> +
> +	return ad5940_write_reg(st, addr, temp);
> +}
> +
> +static ssize_t ad5940_read_info(struct iio_dev *indio_dev,
> +				uintptr_t private,
> +				const struct iio_chan_spec *chan,
> +				char *buf)
> +{
> +	struct ad5940_state *st = iio_priv(indio_dev);
> +
> +	switch ((u32)private) {
> +	case AD5940_CHANNEL_NAME:

What is the logic here in this magic define?

> +		return sprintf(buf, "%s\n",
> +			st->channel_config[chan->address].channel_name);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_chan_spec_ext_info ad4590_ext_info[] = {
> +	{
> +		.name = "name",

This is defining new ABI.  I'm not necessarily against doing so but
it needs a separate documentation patch so that it's easy to discuss.
Documentation/ABI/testing/sysfs-bus-iio

We might want to think of a similar naming to the label we recently
added for the device itself.

> +		.read = ad5940_read_info,
> +		.private = AD5940_CHANNEL_NAME,
> +		.shared = IIO_SEPARATE,
> +	},
> +	{ },
> +};
> +
> +static const struct iio_chan_spec ad5940_channel_template = {
> +	.type = IIO_VOLTAGE,
> +	.differential = 1,
> +	.indexed = 1,
> +	.ext_info = ad4590_ext_info,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +};
> +
> +static int ad5940_clear_ready(struct ad5940_state *st)
> +{
> +	int ret;
> +
> +	ret = ad5940_write_reg_mask(st, AD5940_REG_AFECON,
> +				    AD5940_AFECON_ADCCONV_MSK,
> +				    AD5940_AFECON_ADCCONV_DIS);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ad5940_write_reg(st, AD5940_REG_INTCLR, AD5940_INTC_ADC);
> +}
> +
> +static irqreturn_t ad5940_irq_handler(int irq, void *private)
> +{
> +	struct ad5940_state *st = private;
> +	int ret;
> +
> +	ret = ad5940_clear_ready(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	complete(&st->complete);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ad5940_scan_direct(struct ad5940_state *st, u32 mux, int *val)
> +{
> +	int ret;
> +	u32 result;
> +
> +	mutex_lock(&st->lock);
> +	ret = ad5940_write_reg_mask(st, AD5940_REG_ADCCON,
> +				    AD5940_ADCCON_MUX_MSK, mux);
> +	if (ret < 0)
> +		goto unlock_return;
> +
> +	reinit_completion(&st->complete);
> +	ret = ad5940_write_reg_mask(st, AD5940_REG_AFECON,
> +				    AD5940_AFECON_ADCCONV_MSK,
> +				    AD5940_AFECON_ADCCONV_EN);
> +	if (ret < 0)
> +		goto unlock_return;
> +
> +	ret = wait_for_completion_timeout(&st->complete,
> +					  msecs_to_jiffies(1000));
> +	if (!ret) {
> +		ad5940_clear_ready(st);
> +		ret = -ETIMEDOUT;
> +		goto unlock_return;
> +	}
> +
> +	ret = ad5940_read_reg(st, AD5940_REG_ADCDAT, &result);
> +	mutex_unlock(&st->lock);
> +	if (ret < 0)
> +		return ret;

As you already have the unlock_return below on this occasion I would
move the if (ret) inside the lock so all similar errors take a simpler
exit path.  If this was the only case and you didn't have the handling
I would agree with how you have done it.

> +	*val = result & 0xffff;
> +
> +	return 0;
> +
> +unlock_return:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static int ad5940_read_raw(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, int *val, int *val2, long info)
> +{
> +	struct ad5940_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ad5940_scan_direct(st,
> +				st->channel_config[chan->address].ain,
> +				val);
> +		if (ret < 0)
> +			return ret;
> +		else
> +			return IIO_VAL_INT;
		return IIO_VAL_INT;

		Cleaner to only have the error path indented.
		if / else kind of implies some 'equality' of the two
		options.

> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_mv;
> +		*val2 = 16;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ad5940_info = {
> +	.read_raw = &ad5940_read_raw,
> +};
> +
> +int cmp_u8(const void *a, const void *b)
> +{
> +	return (*(u8 *)a - *(u8 *)b);
> +}
> +
> +static int ad5940_check_channel_indexes(struct device *dev, u32 *ain)
> +{
> +	const u8 channel_p[] = {
> +		0, 1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 18, 19,
> +		20, 22, 23, 24, 25, 26, 31, 33, 35, 36
> +	};
> +	const u8 channel_n[] = {
> +		0, 1, 2, 4, 5, 6, 7, 10, 11, 12, 14, 16, 17, 20
> +	};
> +	u8 *index;
> +
> +	index = (u8 *) bsearch(&ain[0], channel_p, ARRAY_SIZE(channel_p),
> +				sizeof(u8), cmp_u8);
> +	if (!index) {
> +		dev_err(dev, "Positive input index not found.\n");
> +		return -EINVAL;
> +	}
> +
> +	index = (u8 *) bsearch(&ain[1], channel_n, ARRAY_SIZE(channel_n),
> +				sizeof(u8), cmp_u8);
> +	if (!index) {
> +		dev_err(dev, "negtive input index not found.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad5940_of_parse_channel_config(struct iio_dev *indio_dev,
> +					  struct device_node *np)
> +{
> +	struct ad5940_state *st = iio_priv(indio_dev);
> +	struct iio_chan_spec *chan;
> +	struct device_node *child;
> +	u32 channel, ain[2];
> +	int ret;
> +
> +	st->num_channels = of_get_available_child_count(np);
> +	if (!st->num_channels) {
> +		dev_err(indio_dev->dev.parent, "no channel children\n");
> +		return -ENODEV;
> +	}
> +
> +	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
> +			    sizeof(*chan), GFP_KERNEL);
> +	if (!chan)
> +		return -ENOMEM;
> +
> +	st->channel_config = devm_kcalloc(indio_dev->dev.parent,
> +					  st->num_channels,
> +					  sizeof(*st->channel_config),
> +					  GFP_KERNEL);
> +	if (!st->channel_config)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = chan;
> +	indio_dev->num_channels = st->num_channels;
> +
> +	for_each_available_child_of_node(np, child) {
> +		ret = of_property_read_u32(child, "reg", &channel);
> +		if (ret)
> +			goto err;
> +
> +		ret = of_property_read_u32_array(child, "diff-channels",
> +						 ain, 2);
> +		if (ret)
> +			goto err;
> +
> +		ret = of_property_read_string(child, "channel-name",
> +				&st->channel_config[channel].channel_name);
> +		if (ret)
> +			st->channel_config[channel].channel_name = "none-name";

You have this as required I think in the dt properties.  If that is the case then
enforce it and refuse to load the driver if not supplied. Otherwise change
the dt docs to make it optional (which is probably better)

> +
> +		ret = ad5940_check_channel_indexes(indio_dev->dev.parent, ain);
> +		if (ret) {
> +			dev_err(indio_dev->dev.parent,
> +				"some input channel index does not exist: %d, %d, %d",
> +				channel, ain[0], ain[1]);
> +			goto err;
> +		}
> +
> +		st->channel_config[channel].ain = AD5940_CHANNEL_AINP(ain[0]) |
> +						  AD5940_CHANNEL_AINN(ain[1]);
> +
> +		*chan = ad5940_channel_template;
> +		chan->address = channel;
> +		chan->scan_index = channel;
> +		chan->channel = ain[0];
> +		chan->channel2 = ain[1];
> +
> +		chan++;
> +	}
> +
> +	return 0;
> +err:
> +	of_node_put(child);
> +
> +	return ret;
> +}
> +
> +static int ad5940_config_polarity(struct ad5940_state *st, u32 polarity)
> +{
> +	u32 val;
> +
> +	if (polarity == IRQF_TRIGGER_RISING)
> +		val = AD5940_INTCPOL_POS;
> +	else
> +		val = AD5940_INTCPOL_NEG;
> +
> +	return ad5940_write_reg_mask(st, AD5940_REG_INTCPOL,
> +				     AD5940_INTCPOL_MSK, val);
> +}
> +
> +static int ad5940_config_int_io(struct ad5940_state *st, u8 int_io)
> +{
> +	int ret = 0;
> +
> +	if (int_io == 3)

Switch statement preferred for matches like this.

> +		ret = ad5940_write_reg_mask(st, AD5940_REG_GP0CON,
> +					    AD5940_GP0CON_3_MSK,
> +					    AD5940_GP0CON_3_INT);
> +	else if (int_io == 6)
> +		ret = ad5940_write_reg_mask(st, AD5940_REG_GP0CON,
> +					    AD5940_GP0CON_6_MSK,
> +					    AD5940_GP0CON_6_INT);
> +	if (ret < 0)
> +		return ret;
> +
> +	return  ad5940_write_reg(st, AD5940_REG_GP0OEN, BIT(int_io));
> +}
> +
> +static const u32 ad5940_powerup_setting[][2] = {

Hmm. This is not good practice when we have docs for the values.
If we can provide a breakdown into what is being set that would be
great.  I can't find docs immediately for some of these however...

> +	{ 0x0908, 0x02c9 },
> +	{ 0x0c08, 0x206c },
> +	{ 0x21f0, 0x0010 },

This one is is simply saying only 1 repeat conversion for example.
Add some defines and you can make that clear.

> +	{ 0x0410, 0x02c9 },
> +	{ 0x0a28, 0x0009 },
> +	{ 0x238c, 0x0104 },
> +	{ 0x0a04, 0x4859 },
> +	{ 0x0a04, 0xf27b },
> +	{ 0x0a00, 0x8009 },
> +	{ 0x22f0, 0x0000 },
> +	{ 0x2230, 0xde87a5af },
> +	{ 0x2250, 0x103f },
> +	{ 0x22b0, 0x203c },
> +	{ 0x2230, 0xde87a5a0 },
> +};
> +
> +static int ad5940_setup(struct ad5940_state *st, u8 int_io)
> +{
> +	u32 chip_id;
> +	int ret;
> +	u8 i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad5940_powerup_setting); i++) {
> +		ret = ad5940_write_reg(st, ad5940_powerup_setting[i][0],
> +				       ad5940_powerup_setting[i][1]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = ad5940_read_reg(st, AD5940_AFECON_CHIPID, &chip_id);
> +	if (ret < 0)
> +		return ret;
> +	if (chip_id != AD5940_CHIPID) {
> +		dev_err(&st->spi->dev, "Wrong chip ID with 0x%x.", chip_id);
> +		return -ENXIO;
> +	}
> +	dev_info(&st->spi->dev, "Found ad5940");

There are lots of ways of telling this, so this is just noise in the log.
If there was other useful information conveyed (serial number etc) then it
would be fine.  For a simple 'found', don't bother.  So drop this print.

> +
> +	ret = ad5940_write_reg(st, AD5940_REG_PMBW,
> +			       AD5940_PMBW_LP | AD5940_PMBW_BW250);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad5940_config_int_io(st, int_io);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad5940_clear_ready(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad5940_write_reg(st, AD5940_REG_INTCSEL0, AD5940_INTC_ADC);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad5940_write_reg_mask(st, AD5940_REG_ADCCON,
> +				    AD5940_ADCCON_PGA_MSK,
> +				    AD5940_ADCCON_PGA_1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ad5940_write_reg_mask(st, AD5940_REG_AFECON,
> +				     AD5940_AFECON_ADCEN_MSK,
> +				     AD5940_AFECON_ADCEN);
> +}
> +
> +static void ad5940_regulator_disable(void *data)
> +{
> +	struct ad5940_state *st = data;
> +
> +	regulator_disable(st->vref);
> +}
> +
> +static inline int ad5940_check_int_io(u32 io, struct device *dev)
> +{
> +	static const u8 int_io[3] = {0, 3, 6};
> +	u8 *p;
> +
> +	p = bsearch(&io, int_io, 3, sizeof(u8), cmp_u8);

I'd just use a switch statement here as there are only 3 options.

> +	if (!p) {
> +		dev_err(dev, "interrupt output pin not valid,");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad5940_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ad5940_state *st;
> +	u32 trig_type;
> +	int vref_uv = 0;
> +	u32 int_io;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	ret = device_property_read_u32(&spi->dev, "adi,interrupt-io", &int_io);

For other devices we have done the same thing via interrupt names.  See
the imu/adis16480 for example.  That lets us use generic bindings.

> +	if (ret) {
> +		dev_err(&spi->dev,
> +			"reading dt property 'adi,interrupt-io' failed.");
> +		return -EINVAL;
> +	}
> +
> +	st->spi = spi;
> +
> +	trig_type = irq_get_trigger_type(spi->irq);
> +	if (trig_type != IRQF_TRIGGER_RISING &&
> +	    trig_type != IRQF_TRIGGER_FALLING) {
> +		dev_err(&spi->dev, "trigger type must be rising or falling.");
> +		return -EINVAL;
> +	}

Slight preference for a blank line here.

> +	ret = ad5940_config_polarity(st, trig_type);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "config polarity failed.");
> +		return ret;
> +	}
> +
> +	ret = ad5940_check_int_io(int_io, &spi->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->vref = devm_regulator_get_optional(&spi->dev, "vref");
> +	if (!IS_ERR(st->vref)) {
> +		ret = regulator_enable(st->vref);
> +		if (ret) {
> +			dev_err(&spi->dev, "Failed to enbale specified vref supply.\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev,
> +				ad5940_regulator_disable, st);
> +		if (ret) {
> +			regulator_disable(st->vref);
> +			return ret;
> +		}
> +
> +		ret = regulator_get_voltage(st->vref);
> +		if (ret < 0)
> +			return ret;

We could move this read to be on demand, but I doubt anyone will share a voltage
reference between this device and any other, so unlikely this value will change.

> +
> +		vref_uv = ret;
> +	}
> +
> +	if (vref_uv)
> +		st->vref_mv = vref_uv / 1000;
> +	else
> +		st->vref_mv = 1820;
Hmm. So the one way this code is different from using the above
if statement is if there is a vref regulator, but it's voltage == 0.
That seems unlikely to occur in a real system.  Perhaps we can just move
the regulator value based version into the block above and initialize
the st->vref_mv to 1820 either in an else block to that or from the start.

> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->dev.of_node = spi->dev.of_node;
> +	indio_dev->name = spi->dev.of_node->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ad5940_info;
> +
> +	ret = ad5940_of_parse_channel_config(indio_dev, spi->dev.of_node);
> +	if (ret < 0)
> +		return ret;
> +
> +	init_completion(&st->complete);
> +
> +	ret = ad5940_setup(st, int_io);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_threaded_irq(&spi->dev, spi->irq, NULL,
> +					ad5940_irq_handler,
> +					trig_type | IRQF_ONESHOT,
> +					dev_name(&spi->dev), st);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad5940_dt_match[] = {
> +	{ .compatible = "adi,ad5940" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ad5940_spi_ids);
> +
> +static struct spi_driver ad5940_driver = {
> +	.driver = {
> +		.name = "ad5940",
> +		.of_match_table = ad5940_dt_match,
> +	},
> +	.probe = ad5940_probe,
> +};
> +module_spi_driver(ad5940_driver);
> +
> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> +MODULE_DESCRIPTION("Analog Device AD5940 ADC driver");
> +MODULE_LICENSE("GPL");

