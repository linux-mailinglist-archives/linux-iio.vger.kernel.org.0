Return-Path: <linux-iio+bounces-4874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499F38BFC68
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 13:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E78286D52
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 11:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F2A82D9A;
	Wed,  8 May 2024 11:40:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24484DF9;
	Wed,  8 May 2024 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168456; cv=none; b=L7+QaJajqX8Ah2hpIC4hze+4ygreCNx4qZRbSQq0Dj6ISRwqxR8IOukMlfqEQ8dnQz0PMy7snWjbJConUIBWAwLC68Pg0WnvIFpFBkOGcMSudaiIz5h1uwuPcBEWgraxa4yA5gKGbuW3SxzZlPxJa4C1jYZQ0C1XMVWs6gt2iLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168456; c=relaxed/simple;
	bh=KHB0rCb0rE9dkuQ1G6p3FMV2kZpIBBilgze1bmSvjk8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eurfYAUMbUKWnXRJtC6xK361Q9NLBiGVKB1TpWeqJ0ARQtGP4XW79HNDC65j1nDvjB02vZLck/1Z8eZYUp/LogKlmwSst2txv36+hjuRML5cAU6qSR0xuAo6QxHrCTxUMjSiw6hpA9qU3+ssR5RE4rsF58mWFm7kUy/jRM2PyyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZCn55Vqbz6K6Fx;
	Wed,  8 May 2024 19:37:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 458FE140B2F;
	Wed,  8 May 2024 19:40:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 8 May
 2024 12:40:50 +0100
Date: Wed, 8 May 2024 12:40:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Julien Stephan <jstephan@baylibre.com>, Esteban Blanc
	<eblanc@baylibre.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 4/4] iio: adc: ad7380: add support for multiple scan
 type
Message-ID: <20240508124049.00001661@Huawei.com>
In-Reply-To: <20240507-iio-add-support-for-multiple-scan-types-v1-4-95ac33ee51e9@baylibre.com>
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
	<20240507-iio-add-support-for-multiple-scan-types-v1-4-95ac33ee51e9@baylibre.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  7 May 2024 14:02:08 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The AD783x chips have a resolution boost feature that allows for 2
> extra bits of resolution. Previously, we had to choose a scan type to
> fit the largest resolution and manipulate the raw data to fit when the
> resolution was lower. This patch adds support for multiple scan types
> for the voltage input channels so that we can support both resolutions
> without having to manipulate the raw data.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

I'm wondering about the control mechanism.  I was thinking we'd poke
the scan type directly but this may well make more sense.

This is relying on _scale change to trigger the change in the scan type.
That may well be sufficient and I've been over thinking this for far too many
years :)

It will get messy though in some cases as the device might have a PGA on the
front end so we will have a trade off between actual scaling control and
resolution related scale changes. We've had a few device where the scale
calculation is already complex and involves various different hardware
controls, but none have affected the storage format like this.

I'll think some more.

> ---
>  drivers/iio/adc/ad7380.c | 185 ++++++++++++++++++++++-------------------------
>  1 file changed, 86 insertions(+), 99 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index e240098708e9..ca317e3a72d9 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -89,14 +89,22 @@ struct ad7380_chip_info {
>  	const struct ad7380_timing_specs *timing_specs;
>  };
>  
> -/*
> - * realbits/storagebits cannot be dynamically changed, so in order to
> - * support the resolution boost (additional 2  bits of resolution)
> - * we need to set realbits/storagebits to the maximum value i.e :
> - *   - realbits = 16 + 2 = 18, and storagebits = 32 for 16-bits chips
> - *   - realbits = 14 + 2 = 16, and storagebits = 16 for 14-bits chips
> - * We need to adjust the scale depending on resolution boost status
> - */
> +/** scan type for 14-bit chips with resolution boost enabled. */
> +static const struct iio_scan_type ad7380_scan_type_14_boost = {
> +	.sign = 's',
> +	.realbits = 16,
> +	.storagebits = 16,
> +	.endianness = IIO_CPU,
> +};
> +
> +/** scan type for 16-bit chips with resolution boost enabled. */
> +static const struct iio_scan_type ad7380_scan_type_16_boost = {
> +	.sign = 's',
> +	.realbits = 18,
> +	.storagebits = 32,
> +	.endianness = IIO_CPU,
> +};
> +
>  #define AD7380_CHANNEL(index, bits, diff) {			\
>  	.type = IIO_VOLTAGE,					\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> @@ -113,10 +121,12 @@ struct ad7380_chip_info {
>  	.scan_index = (index),					\
>  	.scan_type = {						\
>  		.sign = 's',					\
> -		.realbits = (bits) + 2,				\
> -		.storagebits = ((bits) + 2 > 16) ? 32 : 16,	\
> +		.realbits = (bits),				\
> +		.storagebits = ((bits) > 16) ? 32 : 16,		\
>  		.endianness = IIO_CPU,				\
>  	},							\
> +	.ext_scan_type = &ad7380_scan_type_##bits##_boost,	\
> +	.num_ext_scan_type = 1,					\
>  }
>  
>  #define DEFINE_AD7380_2_CHANNEL(name, bits, diff)	\
> @@ -376,67 +386,62 @@ static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
>  	unreachable();
>  }
>  
> -static int ad7380_prepare_spi_xfer(struct ad7380_state *st, struct spi_transfer *xfer)
> +/**
> + * Reads one set of samples from the device. This is a simultaneous sampling
> + * chip, so all channels are always read at the same time.
> + *
> + * On successful return, the raw data is stored in st->scan_data.raw.
> + */
> +static int ad7380_read_one_sample(struct ad7380_state *st,
> +				  const struct iio_scan_type *scan_type)
>  {
> -	int bits_per_word;
> -
> -	memset(xfer, 0, sizeof(*xfer));
> -
> -	xfer->rx_buf = &st->scan_data.raw;
> -
> -	if (st->resolution_boost_enable == RESOLUTION_BOOST_ENABLE)
> -		bits_per_word = st->chip_info->channels[0].scan_type.realbits;
> -	else
> -		bits_per_word = st->chip_info->channels[0].scan_type.realbits - 2;
> -
> -	xfer->bits_per_word = bits_per_word;
> +	struct spi_transfer xfers[2] = {
> +		/* toggle CS (no data xfer) to trigger a conversion */
> +		{
> +			.speed_hz = AD7380_REG_WR_SPEED_HZ,
> +			.bits_per_word = scan_type->realbits,
> +			.delay = {
> +				.value = T_CONVERT_NS,
> +				.unit = SPI_DELAY_UNIT_NSECS,
> +			},
> +			.cs_change = 1,
> +			.cs_change_delay = {
> +				.value = st->chip_info->timing_specs->t_csh_ns,
> +				.unit = SPI_DELAY_UNIT_NSECS,
> +			},
> +		},
> +		{
> +			.rx_buf = &st->scan_data.raw,
> +			.len = BITS_TO_BYTES(scan_type->storagebits) *
> +						(st->chip_info->num_channels - 1),
> +			.bits_per_word = scan_type->realbits,
> +		},
> +	};
>  
> -	xfer->len = (st->chip_info->num_channels - 1) * BITS_TO_BYTES(bits_per_word);
> +	/*
> +	 * In normal average oversampling we need to wait for multiple conversions to be done
> +	 */
> +	if (st->oversampling_mode == OS_MODE_NORMAL_AVERAGE && st->oversampling_ratio > 1)
> +		xfers[0].delay.value = T_CONVERT_NS + 500 * st->oversampling_ratio;
>  
> -	return bits_per_word;
> +	return spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
>  }
>  
>  static irqreturn_t ad7380_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
> +	const struct iio_chan_spec *chan = &indio_dev->channels[0];
> +	const struct iio_scan_type *scan_type = iio_get_current_scan_type(
> +								indio_dev, chan);
>  	struct ad7380_state *st = iio_priv(indio_dev);
> -	struct spi_transfer xfer;
> -	int bits_per_word, realbits, i, ret;
> +	int ret;
>  
> -	realbits = st->chip_info->channels[0].scan_type.realbits;
> -	bits_per_word = ad7380_prepare_spi_xfer(st, &xfer);
>  
> -	ret = spi_sync_transfer(st->spi, &xfer, 1);
> +	ret = ad7380_read_one_sample(st, scan_type);
>  	if (ret)
>  		goto out;
>  
> -	/*
> -	 * If bits_per_word == realbits (resolution boost enabled), we don't
> -	 * need to manipulate the raw data, otherwise we may need to fix things
> -	 * up a bit to fit the scan_type specs
> -	 */
> -	if (bits_per_word < realbits) {
> -		if (realbits > 16 && bits_per_word <= 16) {
> -			/*
> -			 * Here realbits > 16 so storagebits is 32 and bits_per_word is <= 16
> -			 * so we need to sign extend u16 to u32 using reverse order to
> -			 * avoid writing over union data
> -			 */
> -			for (i = st->chip_info->num_channels - 2; i >= 0; i--)
> -				st->scan_data.raw.u32[i] = sign_extend32(st->scan_data.raw.u16[i],
> -									 bits_per_word - 1);
> -		} else if (bits_per_word < 16) {
> -			/*
> -			 * Here realbits <= 16 so storagebits is 16.
> -			 * We only need to sign extend only if bits_per_word is < 16
> -			 */
> -			for (i = 0; i < st->chip_info->num_channels - 1; i++)
> -				st->scan_data.raw.u16[i] = sign_extend32(st->scan_data.raw.u16[i],
> -									 bits_per_word - 1);
> -		}
> -	}
> -
>  	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan_data,
>  					   pf->timestamp);
>  
> @@ -447,47 +452,21 @@ static irqreturn_t ad7380_trigger_handler(int irq, void *p)
>  }
>  
>  static int ad7380_read_direct(struct ad7380_state *st,
> -			      struct iio_chan_spec const *chan, int *val)
> +			      struct iio_chan_spec const *chan,
> +			      const struct iio_scan_type *scan_type,
> +			      int *val)
>  {
> -	struct spi_transfer xfers[2] = {
> -		/* toggle CS (no data xfer) to trigger a conversion */
> -		{
> -			.speed_hz = AD7380_REG_WR_SPEED_HZ,
> -			.bits_per_word = chan->scan_type.realbits,
> -			.delay = {
> -				.value = T_CONVERT_NS,
> -				.unit = SPI_DELAY_UNIT_NSECS,
> -			},
> -			.cs_change = 1,
> -			.cs_change_delay = {
> -				.value = st->chip_info->timing_specs->t_csh_ns,
> -				.unit = SPI_DELAY_UNIT_NSECS,
> -			},
> -		},
> -		/* then read all channels, it will be filled by ad7380_prepare_spi_xfer */
> -		{
> -		},
> -	};
> -	int bits_per_word, ret;
> -
> -	/*
> -	 * In normal average oversampling we need to wait for multiple conversions to be done
> -	 */
> -	if (st->oversampling_mode == OS_MODE_NORMAL_AVERAGE && st->oversampling_ratio > 1)
> -		xfers[0].delay.value = T_CONVERT_NS + 500 * st->oversampling_ratio;
> -
> -	bits_per_word = ad7380_prepare_spi_xfer(st, &xfers[1]);
> +	int ret;
>  
> -	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> -	if (ret < 0)
> +	ret = ad7380_read_one_sample(st, scan_type);
> +	if (ret)
>  		return ret;
> -
> -	if (bits_per_word > 16)
> +	if (scan_type->storagebits > 16)
>  		*val = sign_extend32(st->scan_data.raw.u32[chan->scan_index],
> -				     bits_per_word - 1);
> +				     scan_type->realbits - 1);
>  	else
>  		*val = sign_extend32(st->scan_data.raw.u16[chan->scan_index],
> -				     bits_per_word - 1);
> +				     scan_type->realbits - 1);
>  
>  	return IIO_VAL_INT;
>  }
> @@ -496,18 +475,14 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long info)
>  {
> +	const struct iio_scan_type *scan_type = iio_get_current_scan_type(
> +								indio_dev, chan);
>  	struct ad7380_state *st = iio_priv(indio_dev);
> -	int realbits;
> -
> -	if (st->resolution_boost_enable == RESOLUTION_BOOST_ENABLE)
> -		realbits = chan->scan_type.realbits;
> -	else
> -		realbits = chan->scan_type.realbits - 2;
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW:
>  		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -			return ad7380_read_direct(st, chan, val);
> +			return ad7380_read_direct(st, chan, scan_type, val);
>  		}
>  		unreachable();
>  	case IIO_CHAN_INFO_SCALE:
> @@ -520,7 +495,7 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
>  		 * According to IIO ABI, offset is applied before scale,
>  		 * so offset is: vcm_mv / scale
>  		 */
> -		*val = st->vcm_mv[chan->channel] * (1 << realbits)
> +		*val = st->vcm_mv[chan->channel] * (1 << scan_type->realbits)
>  			/ st->vref_mv;
>  
>  		return IIO_VAL_INT;
> @@ -700,6 +675,17 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static const struct iio_scan_type *ad7380_get_current_scan_type(
> +		const struct iio_dev *indio_dev, struct iio_chan_spec const *chan)
> +{
> +	struct ad7380_state *st = iio_priv(indio_dev);
> +
> +	if (st->resolution_boost_enable && chan->num_ext_scan_type)
> +		return chan->ext_scan_type;
> +
> +	return &chan->scan_type;
> +}
> +
>  static ssize_t oversampling_mode_show(struct device *dev,
>  				      struct device_attribute *attr, char *buf)
>  {
> @@ -796,6 +782,7 @@ static const struct iio_info ad7380_info = {
>  	.read_raw = &ad7380_read_raw,
>  	.read_avail = &ad7380_read_avail,
>  	.write_raw = &ad7380_write_raw,
> +	.get_current_scan_type = &ad7380_get_current_scan_type,
>  	.debugfs_reg_access = &ad7380_debugfs_reg_access,
>  };
>  
> 


