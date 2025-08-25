Return-Path: <linux-iio+bounces-23243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF62DB34420
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 16:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6630188221E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A582FD1BF;
	Mon, 25 Aug 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWTOH8fY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93E2FABE3;
	Mon, 25 Aug 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132414; cv=none; b=mTLSDlP/KPr1+ySLl1n9Ea4tdE7umlqfs9MG81IHhtLJdOj2udxVuoEtW2q9T4qNDuLmhqRI0nzDpHbckuzzKxOQNEXBjhE0PNi86Zq17BJJ8ndC7EFRF3KIZDsbcwRF3RrkcBNwiQs1tqCNqMov6T4e+J4gt4drynksoAYtZXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132414; c=relaxed/simple;
	bh=xhSK8G/YNCbg2RlmI771QtKKh27941TambAywmDzy9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7uaJlCpgk98jI2XpP3pEN6OGuJIgslOKEenZ6xr7z/9ktcfVHL3afHe3H4sip77K4S2x4r1CAUneg2hXdNZJqY73O5Ig3BuAE7fR+QsyEtiLWs8Z0DtqhGJXFvEjc5E5bIQ/w6R9DwDnikXnFSaUFVYRYo71u1aTbKjOQvqesw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWTOH8fY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0420C4CEED;
	Mon, 25 Aug 2025 14:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756132414;
	bh=xhSK8G/YNCbg2RlmI771QtKKh27941TambAywmDzy9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LWTOH8fY1roq57qXjs3WI/lZEP/bsdBR4bYrmPvYbrPLFt6yLQ3c5usp/ZS4fp+4C
	 0CETysSPlzvQJshm9ZjJYT0swptyOBauYqtBfiZj/wEUHiIfZ/2GqHwONw8Np0WMwC
	 n8couoUddgyHAxm/fZe5E3ZMg/XckhXsJ6jnHTdz5Bf95s+mQoTtE4Hoemyse0Ay6v
	 ABD3S1/sD8MFHTpbxgnge0xtYfcqP0/5Qpd74bw3suZapCikWCEsQmGmXYXgImYPqg
	 We4oJKxAo+3eWGsu15bK6ofIOpHwvsNd/xwExYoBHeYscFMBfekKqzqRhUFeqhnrfe
	 ahigTTgSP3siA==
Date: Mon, 25 Aug 2025 15:33:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <Michael.Hennerich@analog.com>,
 <lars@metafoo.de>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 2/4] iio: adc: ad7768-1: introduce chip info for
 future multidevice support
Message-ID: <20250825153325.421d2a4d@jic23-huawei>
In-Reply-To: <20250824040953.9547-1-Jonathan.Santos@analog.com>
References: <20250824040953.9547-1-Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Aug 2025 01:09:53 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Add Chip info struct in SPI device to store channel information for
> each supported part.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v2 Changes:
> * removed AD7768_CHAN_INFO_NONE macro.
> * reordered fields in ad7768_chip_info struct.
> * removed trailing comma.
> ---
>  drivers/iio/adc/ad7768-1.c | 75 ++++++++++++++++++++++++++------------
>  1 file changed, 52 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index a2e061f0cb08..83b0907b068d 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -213,6 +213,13 @@ static const struct iio_scan_type ad7768_scan_type[] = {
>  	},
>  };
>  
> +struct ad7768_chip_info {
> +	const char *name;
> +	const unsigned long *available_masks;
> +	const struct iio_chan_spec *channel_spec;
> +	int num_channels;
> +};
> +
>  struct ad7768_state {
>  	struct spi_device *spi;
>  	struct regmap *regmap;
> @@ -234,6 +241,7 @@ struct ad7768_state {
>  	struct gpio_desc *gpio_reset;
>  	const char *labels[AD7768_MAX_CHANNELS];
>  	struct gpio_chip gpiochip;
> +	const struct ad7768_chip_info *chip;
>  	bool en_spi_sync;
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
> @@ -750,24 +758,27 @@ static const struct iio_chan_spec_ext_info ad7768_ext_info[] = {
>  	{ }
>  };
>  
> +#define AD7768_CHAN(_idx, _msk_avail) {	\

Check for consistency.  looks like you were aiming for 1 space before \ but didn't
get it the same everywhere?

> +	.type = IIO_VOLTAGE,\
> +	.info_mask_separate_available = _msk_avail,\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),\
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +	.ext_info = ad7768_ext_info,\
> +	.indexed = 1,\
> +	.channel = _idx,\
> +	.scan_index = _idx,\
> +	.has_ext_scan_type = 1,\
> +	.ext_scan_type = ad7768_scan_type,\
> +	.num_ext_scan_type = ARRAY_SIZE(ad7768_scan_type),\
> +}
> +
>  static const struct iio_chan_spec ad7768_channels[] = {
> -	{
> -		.type = IIO_VOLTAGE,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> -					    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
> -					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.ext_info = ad7768_ext_info,
> -		.indexed = 1,
> -		.channel = 0,
> -		.scan_index = 0,
> -		.has_ext_scan_type = 1,
> -		.ext_scan_type = ad7768_scan_type,
> -		.num_ext_scan_type = ARRAY_SIZE(ad7768_scan_type),
> -	},
> +	AD7768_CHAN(0, 0),
>  };
>  
>  static int ad7768_read_raw(struct iio_dev *indio_dev,
> @@ -1334,6 +1345,18 @@ static int ad7768_register_regulators(struct device *dev, struct ad7768_state *s
>  	return 0;
>  }
>  
> +static const unsigned long ad7768_channel_masks[] = {
> +	BIT(0),

That doesn't make a lot of sense. Don't provide one for devices with
only one channel.  Leave it set to NULL and everything should just work.

> +	0
> +};



