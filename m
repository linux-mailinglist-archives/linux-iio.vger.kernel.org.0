Return-Path: <linux-iio+bounces-25696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8459C21912
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 18:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1283ADD68
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 17:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE0636CA6A;
	Thu, 30 Oct 2025 17:54:43 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9325136A5EE;
	Thu, 30 Oct 2025 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846882; cv=none; b=EUtwEDfgHYis4ROTXUrXn5808VfXMt8p865Va/Xl2z9F+PTHkljz1OUZoSAd8wnSCmj2cYyhnOxNgDBRu9hWegQonnuvKki4InohDwYIGEK4cNaIMMoblJIa4w8ue/kwNLJlXwFwWTgzZIb1t/ZAUyEhUKLqdEFuv0P6ekcttP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846882; c=relaxed/simple;
	bh=j2VtZpCeDsh8GUsD0/crV6yE4h44lhJKR1MKD2Fs3Rw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMbrt75GYo3OQS2XQJvASA128/gIeoLZz+MYMhXIzH0XptZ7+xmJJ04NIIy8Tcz3fof0GoEMNG1igr/GTlgmRui8qR9XGyhyQF1wia3bNiK1ZCGwIFTFWddkbHhRL+MEWTRjoGJg0WOyynkinwZ8z3DEW19D9Y3dRRacQnW4olc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cyBYd24WTzHnGhr;
	Thu, 30 Oct 2025 17:53:41 +0000 (UTC)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 342E91402F5;
	Fri, 31 Oct 2025 01:54:36 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 17:54:35 +0000
Date: Thu, 30 Oct 2025 17:54:33 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ajith Anandhan <ajithanandhan0406@gmail.com>
CC: <linux-iio@vger.kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] iio: adc: Add support for TI ADS1120
Message-ID: <20251030175433.00004cc2@huawei.com>
In-Reply-To: <20251030163411.236672-3-ajithanandhan0406@gmail.com>
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
	<20251030163411.236672-3-ajithanandhan0406@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 30 Oct 2025 22:04:10 +0530
Ajith Anandhan <ajithanandhan0406@gmail.com> wrote:

> Add driver for the Texas Instruments ADS1120, a precision 16-bit
> analog-to-digital converter with an SPI interface.
> 
> The driver provides:
> - 4 single-ended voltage input channels
> - Programmable gain amplifier (1 to 128)
> - Configurable data rates (20 to 1000 SPS)
> - Single-shot conversion mode
> 
> Link: https://www.ti.com/lit/gpn/ads1120
Datasheet:

> Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>

Hi Ajith

Various comments inline.  Mostly superficial stuff but the DMA safety
of SPI buffers needs fixing.  There is a useful talk from this given
by Wolfram Sang if you want to understand more about this
https://www.youtube.com/watch?v=JDwaMClvV-s

Thanks,

Jonathan


> diff --git a/drivers/iio/adc/ti-ads1120.c b/drivers/iio/adc/ti-ads1120.c
> new file mode 100644
> index 000000000..07a6fb309
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1120.c
> @@ -0,0 +1,509 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TI ADS1120 4-channel, 2kSPS, 16-bit delta-sigma ADC
> + *
> + * Datasheet: https://www.ti.com/lit/gpn/ads1120
> + *
> + * Copyright (C) 2025 Ajith Anandhan <ajithanandhan0406@gmail.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>

Figure out what you are actually using. There is ongoing effort to not include
kernel.h in drivers because there is usually a small set of more appropriate
fine grained includes.

> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +
> +/* Commands */
> +#define ADS1120_CMD_RESET		0x06
> +#define ADS1120_CMD_START		0x08
> +#define ADS1120_CMD_PWRDWN		0x02
> +#define ADS1120_CMD_RDATA		0x10
> +#define ADS1120_CMD_RREG		0x20
> +#define ADS1120_CMD_WREG		0x40
> +
> +/* Registers */
> +#define ADS1120_REG_CONFIG0		0x00
> +#define ADS1120_REG_CONFIG1		0x01
> +#define ADS1120_REG_CONFIG2		0x02
> +#define ADS1120_REG_CONFIG3		0x03
> +
> +/* Config Register 0 bit definitions */
> +#define ADS1120_MUX_MASK		GENMASK(7, 4)
> +#define ADS1120_MUX_AIN0_AVSS		0x80
> +#define ADS1120_MUX_AIN1_AVSS		0x90
> +#define ADS1120_MUX_AIN2_AVSS		0xa0
> +#define ADS1120_MUX_AIN3_AVSS		0xb0
> +
> +#define ADS1120_GAIN_MASK		GENMASK(3, 1)

Better to name these so it's obvious which register they are in.
#define ADS1120_CFG0_GAIN_MSK or similar.
Saves anyone checking every time that it's being written to
the appropriate register.

> +#define ADS1120_GAIN_1			0x00
> +#define ADS1120_GAIN_2			0x02
> +#define ADS1120_GAIN_4			0x04
> +#define ADS1120_GAIN_8			0x06
> +#define ADS1120_GAIN_16			0x08
> +#define ADS1120_GAIN_32			0x0a
> +#define ADS1120_GAIN_64			0x0c
> +#define ADS1120_GAIN_128		0x0e
Same as called out for DR below. (applies in other places
as well).
> +
> +#define ADS1120_PGA_BYPASS		BIT(0)
> +
> +/* Config Register 1 bit definitions */
> +#define ADS1120_DR_MASK			GENMASK(7, 5)
> +#define ADS1120_DR_20SPS		0x00
> +#define ADS1120_DR_45SPS		0x20
> +#define ADS1120_DR_90SPS		0x40
> +#define ADS1120_DR_175SPS		0x60
> +#define ADS1120_DR_330SPS		0x80
> +#define ADS1120_DR_600SPS		0xa0
> +#define ADS1120_DR_1000SPS		0xc0
Define these as values of the field (So not shifted)

#define ADS1120_DR_20SPS	0
#define ADS1120_DR_45SPS	1
etc.
Then use FIELD_PREP(ADS1120_DR_MASK, ADIS1120_DR_20SPS)
and similar to set them.

> +
> +#define ADS1120_MODE_MASK		GENMASK(4, 3)
> +#define ADS1120_MODE_NORMAL		0x00
No other values for a 2 bit field? Define all values even
if you only use one for now.  Makes it easier to review the
values
> +
> +#define ADS1120_CM_SINGLE		0x00
> +#define ADS1120_CM_CONTINUOUS		BIT(2)

> +
> +#define ADS1120_TS_EN			BIT(1)
> +#define ADS1120_BCS_EN			BIT(0)
> +
> +/* Config Register 2 bit definitions */
> +#define ADS1120_VREF_MASK		GENMASK(7, 6)
> +#define ADS1120_VREF_INTERNAL		0x00
> +#define ADS1120_VREF_EXT_REFP0		0x40
> +#define ADS1120_VREF_EXT_AIN0		0x80
> +#define ADS1120_VREF_AVDD		0xc0
> +
> +#define ADS1120_REJECT_MASK		GENMASK(5, 4)
> +#define ADS1120_REJECT_OFF		0x00
> +#define ADS1120_REJECT_50_60		0x10
> +#define ADS1120_REJECT_50		0x20
> +#define ADS1120_REJECT_60		0x30
> +
> +#define ADS1120_PSW_EN			BIT(3)
> +
> +#define ADS1120_IDAC_MASK		GENMASK(2, 0)
> +
> +/* Config Register 3 bit definitions */
> +#define ADS1120_IDAC1_MASK		GENMASK(7, 5)
> +#define ADS1120_IDAC2_MASK		GENMASK(4, 2)
> +#define ADS1120_DRDYM_EN		BIT(1)
> +
> +/* Default configuration values */
> +#define ADS1120_DEFAULT_GAIN		1
> +#define ADS1120_DEFAULT_DATARATE	175

These should be just handled by writing the registers in init.
The defines in of themselves don't help over seeing the default
set in code.

> +
> +struct ads1120_state {
> +	struct spi_device	*spi;
> +	struct mutex		lock;

Locks should always have comments to say what data they protect.

> +	/*
> +	 * Used to correctly align data.
> +	 * Ensure natural alignment for potential future timestamp support.

You don't do that except by coincidence of IIO_DMA_MINALIGN being large
enough. So this comment is misleading - Drop it.

> +	 */
> +	u8 data[4] __aligned(IIO_DMA_MINALIGN);
Unless everything after this is used for DMA buffers you have defeated
the point of the __aligned 'trick'.  We need to ensure nothing that isn't
used for DMA and can potentially be modified in parallel with this
is not in the cache line.  Probably a case of just moving data to the
end of the structure.

> +
> +	u8 config[4];
> +	int current_channel;
> +	int gain;
> +	int datarate;
> +	int conv_time_ms;
> +};
> +
> +struct ads1120_datarate {
> +	int rate;
> +	int conv_time_ms;
> +	u8 reg_value;
> +};
> +
> +static const struct ads1120_datarate ads1120_datarates[] = {
> +	{ 20,   51, ADS1120_DR_20SPS },
As above, use the field values not the shifted ones.

> +	{ 45,   24, ADS1120_DR_45SPS },
> +	{ 90,   13, ADS1120_DR_90SPS },
> +	{ 175,   7, ADS1120_DR_175SPS },
> +	{ 330,   4, ADS1120_DR_330SPS },
> +	{ 600,   3, ADS1120_DR_600SPS },
> +	{ 1000,  2, ADS1120_DR_1000SPS },
> +};

> +static int ads1120_write_cmd(struct ads1120_state *st, u8 cmd)
> +{
> +	st->data[0] = cmd;
> +	return spi_write(st->spi, st->data, 1);
> +}
> +
> +static int ads1120_write_reg(struct ads1120_state *st, u8 reg, u8 value)
> +{
> +	u8 buf[2];
> +
> +	if (reg > ADS1120_REG_CONFIG3)
> +		return -EINVAL;
> +
> +	buf[0] = ADS1120_CMD_WREG | (reg << 2);
> +	buf[1] = value;
> +
> +	return spi_write(st->spi, buf, 2);
sizeof(buf);

However DMA safety thing applies here as well so you can't just use
a buffer in the stack.  Can use spi_write_then_read() though as that bounce
buffers.

> +}

> +
> +static int ads1120_set_channel(struct ads1120_state *st, int channel)
> +{
> +	u8 mux_val;
> +	u8 config0;
> +
> +	if (channel < 0 || channel > 3)
> +		return -EINVAL;
> +
> +	/* Map channel to AINx/AVSS single-ended input */
> +	mux_val = ADS1120_MUX_AIN0_AVSS + (channel << 4);
> +
> +	config0 = (st->config[0] & ~ADS1120_MUX_MASK) | mux_val;
> +	st->config[0] = config0;

FIELD_MODIFY() after the defines are field values (not shifted version)
and that << 4 is gone.

> +
> +	return ads1120_write_reg(st, ADS1120_REG_CONFIG0, config0);
> +}
> +
> +static int ads1120_set_gain(struct ads1120_state *st, int gain_val)
> +{
> +	u8 gain_bits;
> +	u8 config0;
> +	int i;
> +
> +	/* Find gain in supported values */
> +	for (i = 0; i < ARRAY_SIZE(ads1120_gain_values); i++) {
> +		if (ads1120_gain_values[i] == gain_val) {
> +			gain_bits = i << 1;
			gain_bits = BIT(i);

> +			goto found;

Avoid this goto by the following simplifying code flow.

			break;
> +		}
> +	}
	if (i == ARRAY_SIZE(ads1120_gain_values)
		return -EINVAL;

	config0 = ...

> +	return -EINVAL;
> +
> +found:
> +	config0 = (st->config[0] & ~ADS1120_GAIN_MASK) | gain_bits;
> +	st->config[0] = config0;
FIELD_MODIFY()

> +	st->gain = gain_val;

Similar to below - I'd not store this explicitly. Where it is used
is not a fast path so add loop to look it up there.

It's much easier to be sure there is no getting out of sync with
only one store of information, even if it does bloat the code a it.

> +
> +	return ads1120_write_reg(st, ADS1120_REG_CONFIG0, config0);
> +}
> +
> +static int ads1120_set_datarate(struct ads1120_state *st, int rate)
> +{
> +	u8 config1;
> +	int i;
> +
> +	/* Find data rate in supported values */
> +	for (i = 0; i < ARRAY_SIZE(ads1120_datarates); i++) {
> +		if (ads1120_datarates[i].rate == rate) {

Flip logic to reduce indent
		if (ads1120_datarates[i].rate != rate)
			continue;

		config1 =...

> +			config1 = (st->config[1] & ~ADS1120_DR_MASK) |
> +				  ads1120_datarates[i].reg_value;

FIELD_MODIFY() once reg_value is the field value not a shifted version of it.
And operate directly on st->config[1]

> +			st->config[1] = config1;
> +			st->datarate = rate;
> +			st->conv_time_ms = ads1120_datarates[i].conv_time_ms;
> +
> +			return ads1120_write_reg(st, ADS1120_REG_CONFIG1,
> +						 config1);
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ads1120_read_raw_adc(struct ads1120_state *st, int *val)
> +{
> +	u8 rx_buf[4];
> +	u8 tx_buf[4] = { ADS1120_CMD_RDATA, 0xff, 0xff, 0xff };
> +	int ret;
> +	struct spi_transfer xfer = {
> +		.tx_buf = tx_buf,
> +		.rx_buf = rx_buf,
> +		.len = 4,
> +	};
> +
> +	ret = spi_sync_transfer(st->spi, &xfer, 1);

SPI requires DMA safe buffers.  2 ways to make that true
here.
1. Put a buffer at the end of iio_priv() structure and mark it 
   __aligned(IIO_DMA_MINALIGN);
2. Allocate on the heap here.
(Can't use spi_write_then read() here if those '0xff's are required values).

> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Data format: 16-bit two's complement MSB first
> +	 * rx_buf[0] is echo of command
> +	 * rx_buf[1] is MSB of data
> +	 * rx_buf[2] is LSB of data
> +	 */
> +	*val = (s16)((rx_buf[1] << 8) | rx_buf[2]);

	*val = sign_extend32(get_unaligned_be16(&rx_buf[1]), 15);
or something along those lines.


> +
> +	return 0;
> +}
> +
> +static int ads1120_read_measurement(struct ads1120_state *st, int channel,
> +				    int *val)
> +{
> +	int ret;
> +
> +	ret = ads1120_set_channel(st, channel);
> +	if (ret)
> +		return ret;
> +
> +	/* Start single-shot conversion */

This all seems fairly standard so not sure what your RFC question was
looking for feedback on wrt to how you did single conversions?

> +	ret = ads1120_write_cmd(st, ADS1120_CMD_START);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for conversion to complete */
> +	msleep(st->conv_time_ms);
> +
> +	/* Read the result */
> +	ret = ads1120_read_raw_adc(st, val);
> +	if (ret)
> +		return ret;
> +
> +	st->current_channel = channel;
> +
> +	return 0;
> +}
> +
> +static int ads1120_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ads1120_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret = ads1120_read_measurement(st, chan->channel, val);

guard() as below.

> +		mutex_unlock(&st->lock);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->gain;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->datarate;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ads1120_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct ads1120_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		mutex_lock(&st->lock);

include cleanup.h and use

		guard(mutex)(&st->lock;
		return ads1120_set_gain(st, val);
here.  Similar for other cases.
 

> +		ret = ads1120_set_gain(st, val);
> +		mutex_unlock(&st->lock);
> +		return ret;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&st->lock);
> +		ret = ads1120_set_datarate(st, val);
> +		mutex_unlock(&st->lock);
> +		return ret;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ads1120_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	static const int datarates[] = { 20, 45, 90, 175, 330, 600, 1000 };
I'd put this up alongside the register defines.  Much easier to see it aligns
with those that way.
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = ads1120_gain_values;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(ads1120_gain_values);
> +		return IIO_AVAIL_LIST;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = datarates;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(datarates);
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +
> +static int ads1120_init(struct ads1120_state *st)
> +{
> +	int ret;
> +
> +	/* Reset device to default state */

I think that is is obvious enough from the function name that I'd
drop this comment.

> +	ret = ads1120_reset(st);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Failed to reset device\n");
> +		return ret;

return dev_err_probe()

> +	}
> +
> +	/*
> +	 * Configure Register 0:
> +	 * - Input MUX: AIN0/AVSS (updated per channel read)
> +	 * - Gain: 1
> +	 * - PGA bypassed (lower power consumption)
> +	 */
> +	st->config[0] = ADS1120_MUX_AIN0_AVSS | ADS1120_GAIN_1 |
> +			ADS1120_PGA_BYPASS;
> +	ret = ads1120_write_reg(st, ADS1120_REG_CONFIG0, st->config[0]);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Configure Register 1:
> +	 * - Data rate: 175 SPS
> +	 * - Mode: Normal
> +	 * - Conversion mode: Single-shot
> +	 * - Temperature sensor: Disabled
> +	 * - Burnout current: Disabled
If you want to make this more self documenting you can use
the definition changes above and
	st->config[1] = FIELD_PREP(ADS1120_CFG1_DR_MASK, ADS1120_CFG1_DR_175_SPS) |
			FIELD_PREP(ADS1120_CFG1_MODE_MASK, ADS1120_CFG1_MODE_NORMAL) |
			FIELD_PREP(ADS1120_CFG1_CONTINOUS, 0) |
			FIELD_PREP(ADS1120_CFG1_TEMP, 0) |
			FIELD_PREP(ADS1120_CFG1_BCS, 0);
So provide field writes with 0 rather than setting them by their absence.


	
> +	 */
> +	st->config[1] = ADS1120_DR_175SPS | ADS1120_MODE_NORMAL |
> +			ADS1120_CM_SINGLE;
> +	ret = ads1120_write_reg(st, ADS1120_REG_CONFIG1, st->config[1]);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Configure Register 2:
> +	 * - Voltage reference: AVDD
> +	 * - 50/60Hz rejection: Off
> +	 * - Power switch: Off
> +	 * - IDAC: Off
> +	 */
> +	st->config[2] = ADS1120_VREF_AVDD | ADS1120_REJECT_OFF;

Currently config[2] and config[3] are unused outside this function.
Might make sense to use local variables for now.

> +	ret = ads1120_write_reg(st, ADS1120_REG_CONFIG2, st->config[2]);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Configure Register 3:
> +	 * - IDAC1: Disabled
> +	 * - IDAC2: Disabled
> +	 * - DRDY mode: DOUT/DRDY pin behavior
> +	 */
> +	st->config[3] = ADS1120_DRDYM_EN;
> +	ret = ads1120_write_reg(st, ADS1120_REG_CONFIG3, st->config[3]);
> +	if (ret)
> +		return ret;
> +
> +	/* Set default operating parameters */
> +	st->gain = ADS1120_DEFAULT_GAIN;
> +	st->datarate = ADS1120_DEFAULT_DATARATE;
> +	st->conv_time_ms = 7; /* For 175 SPS */

I'd set these alongside where you do the writes.
Where possible just retrieve the value from what is cached in the config[]
registers rather than having two ways to get to related info.

> +	st->current_channel = -1;
> +
> +	return 0;
> +}
> +
> +static int ads1120_probe(struct spi_device *spi)
> +{

There are enough uses of spi->dev that I'd add a local variable
	struct device *dev = &spi->dev;

> +	struct iio_dev *indio_dev;
> +	struct ads1120_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	mutex_init(&st->lock);
	ret = devm_mutex_init(&spi->dev, st->lock);
	if (ret)
		return ret;

This helper is so easy to use it makes sense to use it here even though
the lock debugging it enables is unlikely to be particularly useful.

> +
> +	indio_dev->name = "ads1120";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ads1120_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads1120_channels);
> +	indio_dev->info = &ads1120_info;
> +
> +	ret = ads1120_init(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to initialize device: %d\n", ret);
> +		return ret;
For errors in code only called form probe path use
		return dev_err_probe(&spi->dev, ret, "Failed to initialize device\n");

Whilst this particular path presumably doesn't defer it is still a useful
helper and pretty prints the return value + takes a few lines less than what
you currently have.

> +	}
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}


