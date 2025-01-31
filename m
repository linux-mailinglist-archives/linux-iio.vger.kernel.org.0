Return-Path: <linux-iio+bounces-14772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838C3A242D3
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 19:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1DC3A8B28
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 18:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C621F2376;
	Fri, 31 Jan 2025 18:35:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FA1F03F9;
	Fri, 31 Jan 2025 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348556; cv=none; b=A7UPuPWvbTU66jAEgvhJdEMn+uUG/ToEs9BcIWLUy5f/5U3waF27ZNUi411sbPUH/dFGvwPXe9PI14z0mcJFABwVf1A+GNy16iITWZ73mRxMECyygfysoTJGD7RwIzc2OGKhP3yr3znjz45Cl8rPzEko63eMLoMNnVteYTLFopI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348556; c=relaxed/simple;
	bh=RFMCqu5yjyLTYIFuhqNm7r9YHpWimuNHpUgrhtxQC0M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ajlto+VFHSURluPyzXnXcfSspW180fV8dQmfhg60WUDW6HIkijK+UsOQivU18V773FJiR1NGmqBMogXHusqp+WTfvanfLsF33U8YguEyo/y+xhUjbcX8b4xMQiCcI6lP3IkQPVOC2xv1+T1mms/XCL//uW6rtt0tS2YMYDkUMbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yl4K42gt4z6L4xF;
	Sat,  1 Feb 2025 02:33:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A29F140520;
	Sat,  1 Feb 2025 02:35:51 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 19:35:50 +0100
Date: Fri, 31 Jan 2025 18:35:48 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
CC: Alisa-Dariana Roman <alisa.roman@analog.com>, David Lechner
	<dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>
Subject: Re: [PATCH v3 2/3] iio: adc: ad7191: add AD7191
Message-ID: <20250131183548.000073ef@huawei.com>
In-Reply-To: <20250129143054.225322-3-alisa.roman@analog.com>
References: <20250129143054.225322-1-alisa.roman@analog.com>
	<20250129143054.225322-3-alisa.roman@analog.com>
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

On Wed, 29 Jan 2025 16:29:03 +0200
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> AD7191 is a pin-programmable, ultra-low noise 24-bit sigma-delta ADC
> designed for precision bridge sensor measurements. It features two
> differential analog input channels, selectable output rates,
> programmable gain, internal temperature sensor and simultaneous
> 50Hz/60Hz rejection.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Hi Alisa-Dariana

Seeing as a v4 is needed for the available thing you mention
in the cover letter, a few minor things inline I might otherwise
have just tidied up whilst applying.

Thanks,

Jonathan


> diff --git a/drivers/iio/adc/ad7191.c b/drivers/iio/adc/ad7191.c
> new file mode 100644
> index 000000000000..b6c1d5c25783
> --- /dev/null
> +++ b/drivers/iio/adc/ad7191.c

> +
> +#include <linux/iio/adc/ad_sigma_delta.h>
> +#include <linux/iio/iio.h>
> +
> +#define ad_sigma_delta_to_ad7191(sigmad)	container_of((sigmad), struct ad7191_state, sd)
#define ad_sigma_delta_to_ad7191(sigmad)	\
	container_of((sigmad), struct ad7191_state, sd)

Given it is very long otherwise.

> +
> +#define AD7191_TEMP_CODES_PER_DEGREE	2815
> +
> +#define AD7191_EXT_CLK_ENABLE		0
> +#define AD7191_INT_CLK_ENABLE		1
> +
> +#define AD7191_CHAN_MASK		BIT(0)
> +#define AD7191_TEMP_MASK		BIT(1)
> +
> +enum ad7191_channel {
> +	AD7191_CH_AIN1_AIN2,
> +	AD7191_CH_AIN3_AIN4,
> +	AD7191_CH_TEMP
Add a trailing comma. Maybe there will be more channels on some
compatible part that we add after this.

> +};
> +
> +/*
> + * NOTE:
> + * The AD7191 features a dual-use data out ready DOUT/RDY output.
> + * In order to avoid contentions on the SPI bus, it's therefore necessary
> + * to use SPI bus locking.
> + *
> + * The DOUT/RDY output must also be wired to an interrupt-capable GPIO.
> + *
> + * The SPI controller's chip select must be connected to the PDOWN pin
> + * of the ADC. When CS (PDOWN) is high, it powers down the device and
> + * resets the internal circuitry.
> + */
> +
> +struct ad7191_state {
> +	struct ad_sigma_delta		sd;
> +	struct mutex			lock; // to protect sensor state
Only use old style /* */ in IIO code with exception of the SPDX
corner case.  This is just a consistency thing hanging over
from when that was only thing used in the kernel.


> +
> +	struct gpio_descs		*odr_gpios;
> +	struct gpio_descs		*pga_gpios;
> +	struct gpio_desc		*temp_gpio;
> +	struct gpio_desc		*chan_gpio;
> +
> +	u16				int_vref_mv;
> +	u32				pga_index;
> +	u32				scale_avail[4][2];
> +	u32				odr_index;
> +	u32				samp_freq_avail[4];
> +
> +	struct clk			*mclk;
> +};

> +
> +static int ad7191_config_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->sd.spi->dev;
> +	/* Sampling frequencies in Hz, see Table 5 */
> +	const int samp_freq[4] = {120, 60, 50, 10};

Space after { and before } in all such places.
This is just my local IIO preference as nice to pick a standard.
I often just tweak this whilst applying but seeing as you
are going to be doing a v4 anyway please tidy it up!

> +	/* Gain options, see Table 7 */
> +	const int gain[4] = {1, 8, 64, 128};
> +	int odr_value, pga_value, i, ret;
> +	u64 scale_uv;
...


> +
> +static int ad7191_setup(struct iio_dev *indio_dev, struct device *dev)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad7191_init_regulators(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7191_config_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7191_clock_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
	return ad7191_clock_setup(st);
and save a few lines of code.

> +}
> +
> +static int ad7191_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long m)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE: {
> +			guard(mutex)(&st->lock);
> +			*val = st->scale_avail[st->pga_index][0];
> +			*val2 = st->scale_avail[st->pga_index][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +		}
> +		case IIO_TEMP:
> +			*val = 0;
> +			*val2 = NANO / AD7191_TEMP_CODES_PER_DEGREE;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -(1 << (chan->scan_type.realbits - 1));
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			*val -= 273 * AD7191_TEMP_CODES_PER_DEGREE;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->samp_freq_avail[st->odr_index];
> +		return IIO_VAL_INT;
> +	}
> +

Can't get here so drop this.  I guess the bot hasn't tested this one yet
or we should have seen unreachable warnings.

> +	return -EINVAL;
> +}
> +
> +static int ad7191_set_gain(struct ad7191_state *st, int gain_index)
> +{
> +	unsigned long value = gain_index;
> +
> +	if (!st->pga_gpios)
> +		return -EPERM;
> +
> +	st->pga_index = gain_index;
> +
> +	return gpiod_set_array_value_cansleep(st->pga_gpios->ndescs,
> +					      st->pga_gpios->desc,
> +					      st->pga_gpios->info, &value);
> +
> +	return 0;

double return.  Drop this bonus one!

> +}
> +

