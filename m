Return-Path: <linux-iio+bounces-14763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD809A24273
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 19:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36DF3A88B4
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 18:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701BF1F236F;
	Fri, 31 Jan 2025 18:14:46 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5281F2376;
	Fri, 31 Jan 2025 18:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738347286; cv=none; b=p9VoeVGVw+b/ZIYkRRmUP9X4jc1/FbsnXLheZbPOzp1XVrQw/9C4uiGBHd+FtGVEi1wnTgVZGqtcm3vAOJNfjfttKzY46S1Q54Eg/vXk3v/mzTuqkymI/VJ518eFoE7rRbHPXAlHkVwPic9BAYST5yYHLINjuDulev9lQ2nDGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738347286; c=relaxed/simple;
	bh=eZ1jTHEPx8NJyvwfJFYUNGRG/eF3CWuUwh25NoVujG8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVHHtoJK4gTgY0fB1XIMhMfb5bphN50AXeDhaxSIEuThHOUJcxder+B60ywGr9OSDRjMhKihUuB1k8S7TGRy9dUNdif77+FrQtON1zAe5taIhMtJJdSjhcnSA/1Sdt9EeuG1V7oy4lz1kt/2zXiwoAf4zg4D+tNQHypfeujbUfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yl3tY5lsXz6K5rB;
	Sat,  1 Feb 2025 02:13:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 10875140520;
	Sat,  1 Feb 2025 02:14:40 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 19:14:38 +0100
Date: Fri, 31 Jan 2025 18:14:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Esteban Blanc <eblanc@baylibre.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <20250131181437.00000097@huawei.com>
In-Reply-To: <20250130-eblanc-ad4630_v1-v3-2-052e8c2d897d@baylibre.com>
References: <20250130-eblanc-ad4630_v1-v3-0-052e8c2d897d@baylibre.com>
	<20250130-eblanc-ad4630_v1-v3-2-052e8c2d897d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 30 Jan 2025 12:08:26 +0100
Esteban Blanc <eblanc@baylibre.com> wrote:

> This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> 
> The driver implements basic support for the AD4030-24 1 channel
> differential ADC with hardware gain and offset control.
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
Hi Esteban,

Just one thing in here that actually matters. Question about scaling of
the common channel.  The others I could tidy up whilst applying if
nothing much else comes up.

Jonathan


> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..e06424b7f2590d28a57943949b070cd7e185fbb7
> --- /dev/null

> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +
> +#define AD4030_REG_INTERFACE_CONFIG_A			0x00
> +#define     AD4030_REG_INTERFACE_CONFIG_A_SW_RESET	(BIT(0) | BIT(7))
> +#define AD4030_REG_INTERFACE_CONFIG_B			0x01
> +#define AD4030_REG_DEVICE_CONFIG			0x02
> +#define AD4030_REG_CHIP_TYPE				0x03
> +#define AD4030_REG_PRODUCT_ID_L				0x04
> +#define AD4030_REG_PRODUCT_ID_H				0x05
> +#define AD4030_REG_CHIP_GRADE				0x06
> +#define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE	0x10
> +#define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE	GENMASK(7, 3)
> +#define AD4030_REG_SCRATCH_PAD			0x0A
> +#define AD4030_REG_SPI_REVISION			0x0B
> +#define AD4030_REG_VENDOR_L			0x0C
> +#define AD4030_REG_VENDOR_H			0x0D
> +#define AD4030_REG_STREAM_MODE			0x0E
> +#define AD4030_REG_INTERFACE_CONFIG_C		0x10
> +#define AD4030_REG_INTERFACE_STATUS_A		0x11
> +#define AD4030_REG_EXIT_CFG_MODE		0x14
> +#define     AD4030_REG_EXIT_CFG_MODE_EXIT_MSK	BIT(0)
> +#define AD4030_REG_AVG				0x15
> +#define     AD4030_REG_AVG_MASK_AVG_SYNC	BIT(7)
> +#define     AD4030_REG_AVG_MASK_AVG_VAL		GENMASK(4, 0)
> +#define AD4030_REG_OFFSET_X0_0			0x16
> +#define AD4030_REG_OFFSET_X0_1			0x17
> +#define AD4030_REG_OFFSET_X0_2			0x18
> +#define AD4030_REG_OFFSET_X1_0			0x19
> +#define AD4030_REG_OFFSET_X1_1			0x1A
> +#define AD4030_REG_OFFSET_X1_2			0x1B
> +#define     AD4030_REG_OFFSET_BYTES_NB		3
> +#define     AD4030_REG_OFFSET_CHAN(ch)		(AD4030_REG_OFFSET_X0_2 + \
> +						(AD4030_REG_OFFSET_BYTES_NB * \
> +						(ch)))
Similar to below. I'd put the implementation on a new linle.

> +#define AD4030_REG_GAIN_X0_LSB			0x1C
> +#define AD4030_REG_GAIN_X0_MSB			0x1D
> +#define AD4030_REG_GAIN_X1_LSB			0x1E
> +#define AD4030_REG_GAIN_X1_MSB			0x1F
> +#define     AD4030_REG_GAIN_MAX_GAIN		1999970
> +#define     AD4030_REG_GAIN_BYTES_NB		2
> +#define     AD4030_REG_GAIN_CHAN(ch)		(AD4030_REG_GAIN_X0_MSB + \
> +						(AD4030_REG_GAIN_BYTES_NB * \
> +						(ch)))
#define     AD4030_REG_GAIN_CHAN(ch)		\
	(AD4030_REG_GAIN_X0_MSB + (AD4030_REG_GAIN_BYTES_NB * (ch)))

Is perhaps more readable?


> +enum ad4030_out_mode {
> +	AD4030_OUT_DATA_MD_DIFF,
> +	AD4030_OUT_DATA_MD_16_DIFF_8_COM,
> +	AD4030_OUT_DATA_MD_24_DIFF_8_COM,
> +	AD4030_OUT_DATA_MD_30_AVERAGED_DIFF,
> +	AD4030_OUT_DATA_MD_32_PATTERN

Trivial but add a trailing comma.   It's not obviously a terminating
entry so even though we know there won't be other values convention is
to have the comma.

> +};
>
> +
> +static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int *val,
> +				 int *val2)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +
> +	if (chan->differential) {
> +		*val = (st->vref_uv * 2) / MILLI;
> +		*val2 = st->chip->precision_bits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	}
> +
> +	*val = st->vref_uv / 256;

This is a bit non obvious.
A comment on this scaling might be good to have.
Particularly the lack of / MILLI
(I think that's a bug?)

> +	return IIO_VAL_INT;
> +}




> +static int ad4030_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);

0-day noticed this is not used.

> +	int ret;

This doesn't do anything useful either.

> +
> +	ret = ad4030_set_mode(indio_dev, *indio_dev->active_scan_mask);
> +	if (ret)
> +		return ret;

	return ad4030_set_mode();

> +
> +	return 0;
> +}

> +
> +static int ad4030_regulators_get(struct ad4030_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	static const char * const ids[] = { "vdd-5v", "vdd-1v8" };
> +	int ret;
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ids), ids);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +
> +	st->vio_uv = devm_regulator_get_enable_read_voltage(dev, "vio");
> +	if (st->vio_uv < 0)
> +		return dev_err_probe(dev, st->vio_uv,
> +				     "Failed to enable and read vio voltage\n");
> +
> +	st->vref_uv = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (st->vref_uv < 0) {
> +		if (st->vref_uv != -ENODEV)
> +			return dev_err_probe(dev, st->vref_uv,
> +					     "Failed to read ref voltage\n");
> +
> +		/* if not using optional REF, the internal REFIN must be used */
> +		st->vref_uv = devm_regulator_get_enable_read_voltage(dev,
> +								     "refin");

If refin is internal. How are we reading it's voltage?

Ah. It's not. It's just buffered.  Drop 'internal' above and this is fine.


> +		if (st->vref_uv < 0)
> +			return dev_err_probe(dev, st->vref_uv,
> +					     "Failed to read refin voltage\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4030_reset(struct ad4030_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct gpio_desc *reset;
> +	int ret;
> +
> +	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(dev, PTR_ERR(reset),
> +				     "Failed to get reset GPIO\n");
> +
> +	if (reset) {
> +		ndelay(50);
> +		gpiod_set_value_cansleep(reset, 0);
Could make trivial change to
		return 0;
	}

	return regmap_write()

> +	} else {
> +		ret = regmap_write(st->regmap, AD4030_REG_INTERFACE_CONFIG_A,
> +				   AD4030_REG_INTERFACE_CONFIG_A_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

