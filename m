Return-Path: <linux-iio+bounces-5133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099208C9607
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 21:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982D828120D
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 19:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8248D1EB2F;
	Sun, 19 May 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkWKc6i2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C979D0;
	Sun, 19 May 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716146230; cv=none; b=rwd6ZGrxPaQcA1ZTzMIppyYcU4kt+6p6PzKygGpWUErJ1C7LnErNRMhPxOiO0Ww0vNTtK9hWh0wp3pvLANC1TTA7qW0abPkKicpinly1g6gd/FVhXL0LcsPDvHgfP3EoD9aK/rK6nq9KZNVTow150UwR+fTTbvxDyqy4WCvemVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716146230; c=relaxed/simple;
	bh=ID2Wq1ma5HCnXQT0Z946CgxnyhJshdNZktkIBVuh5kM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngXR52GaiDAgZkTeAsVXJ+bTzx7o1cOqA08/AkEYJxBtrWCG70Mca///fAEARsM4eQLhzaqAtq+YWtEXwmVK9t6t/hxPj28OeiOjcL54/vWwihRbwph/WPrLoRgPl/rZeqBiFJ9c87YZYwrzlAQR6Z2vR2HZixfh214FkbPluAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkWKc6i2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D31CC32781;
	Sun, 19 May 2024 19:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716146230;
	bh=ID2Wq1ma5HCnXQT0Z946CgxnyhJshdNZktkIBVuh5kM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kkWKc6i26IAflkgQyxV0R95+zls5stIWsn+yE+mykBq99QoeL/+T5cBmHsWxbELaP
	 lNKHWKKuuSMZ1Z4yL508BHPVNOsHa3Yap4l2wG1iPoOuvvEFV8tXFJ/F6SWiIy4Xjd
	 HCzzzO2bpluYumOxeyRY4yLPaOq1CV8PCIp1l5iA3qLYcfhVkJ0t8S2C+akYhG2QoQ
	 7C1uOqIGH4TcADYyj8mqGpPPf8fcQVx0lE/L8iEikVRqP95y5YT/tU84Dfe5S+YEJw
	 50WISExr2plQQVeb0H6TDVx/Wo4cbaSqTdD9KxLcUXISxSXGc0y0cLRIBQSQEThWJw
	 ugfvrgdF3ZVNw==
Date: Sun, 19 May 2024 20:16:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Julien Stephan <jstephan@baylibre.com>, Esteban Blanc
 <eblanc@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] iio: adc: ad7380: add support for multiple scan
 type
Message-ID: <20240519201657.4bc402c4@jic23-huawei>
In-Reply-To: <20240507-iio-add-support-for-multiple-scan-types-v1-4-95ac33ee51e9@baylibre.com>
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
	<20240507-iio-add-support-for-multiple-scan-types-v1-4-95ac33ee51e9@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

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
A few comments inline.

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
Not kernel-doc. Fix all these.

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
This isn't kernel-doc, so /* only

> + * Reads one set of samples from the device. This is a simultaneous sampling
> + * chip, so all channels are always read at the same time.
> + *
> + * On successful return, the raw data is stored in st->scan_data.raw.
> + */
> +static int ad7380_read_one_sample(struct ad7380_state *st,
> +				  const struct iio_scan_type *scan_type)

>  
>  static irqreturn_t ad7380_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
> +	const struct iio_chan_spec *chan = &indio_dev->channels[0];
> +	const struct iio_scan_type *scan_type = iio_get_current_scan_type(
> +								indio_dev, chan);

As below, pull iio_get_current_scan_type( down to the line below.


> @@ -496,18 +475,14 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long info)
>  {
> +	const struct iio_scan_type *scan_type = iio_get_current_scan_type(
> +								indio_dev, chan);

Pull the iio_get_current_scan_type( down to the next line and use one tab.

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

I'd put all the scan types in ext_scan_type, then pick rather than falling back
to the main scan_type.

> +		return chan->ext_scan_type;
> +
> +	return &chan->scan_type;
> +}
> +

> 


