Return-Path: <linux-iio+bounces-11519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524D79B3B4C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB131F22C23
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E696E1E0094;
	Mon, 28 Oct 2024 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAVPmWkO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994811DF969;
	Mon, 28 Oct 2024 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146948; cv=none; b=HlDnhAoEIvdq2BUFkJ929trjVBONAubNxqhJwrbYa9No2rRB6nsS2Pz8paG/oqyIg0bWFzFTDeWistKpvWsUMGlFWMSNwwx7/bE2XfkLd66qIEFok3mMQSM6ZW/AAJCxWjUBwgRgVwsPKvf3D2lmaXFi6NEllRYrg/nCQQNX9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146948; c=relaxed/simple;
	bh=pT9vby1FTXJmcSXQkwFvclL5W11uGqMmkI13cHc4kTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5Wcy3HltGVABXmGEyr0W0g+yu2TFmHK6EIYEtI7aRniiCjJV9Y7kMMN+S/JzYFwYDHpsvbWot+leueAiAXoG37UoDTg72jvaCs+G+Wqa2zYhaf2NA/UhhQL++t84qUdPfbMk6uIYhidP1GoguH+tevwkq9BKciaRVBClmoZWF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAVPmWkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95097C4CEC3;
	Mon, 28 Oct 2024 20:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730146946;
	bh=pT9vby1FTXJmcSXQkwFvclL5W11uGqMmkI13cHc4kTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AAVPmWkO4WSftmmQc+29HfYTGruEDuceF/k8m3cEJM04cBSrAafckXkADvDuWG/vV
	 7MsVdYMvz/9cfbAONzoEWhwKk8qxZ/p4D5dftfLAwcDRr0d3LNWLWfNdn5WAL+eJGU
	 aEMMDRUPmyBKSsNzN3TyBICCnUd2xYX4abDxNomYPHWe3RT9umhwdEjVaEfLKEFeN0
	 vyPvKh22kk+kjnnuQ0WAQC9WKP02e4nL9fDJuwtx4mx1kXbyJYSSekNk7oiRtO7NuK
	 5pMsMtxFGPDCWZFSKOjwspYfgWMqgf7pqNg8RM9vnEiQgRSRW+sZBUuss6/3miGWGZ
	 toYjg0b1Rn9hA==
Date: Mon, 28 Oct 2024 20:22:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: ahaslam@baylibre.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: dac: ad5791: Include chip_info in device match
 tables
Message-ID: <20241028202218.0f0b3d14@jic23-huawei>
In-Reply-To: <20241028071118.699951-4-ahaslam@baylibre.com>
References: <20241028071118.699951-1-ahaslam@baylibre.com>
	<20241028071118.699951-4-ahaslam@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 08:11:15 +0100
ahaslam@baylibre.com wrote:

> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Include a chip info struct in device SPI and device OF match tables to
> provide channel definitions for each particular ADC model and drop
> device enum.
> 
> Suggested-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  drivers/iio/dac/ad5791.c | 107 +++++++++++++++++++--------------------
>  1 file changed, 51 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
> index 553431bf0232..a11e81211669 100644
> --- a/drivers/iio/dac/ad5791.c
> +++ b/drivers/iio/dac/ad5791.c
> @@ -65,7 +65,9 @@
>   */
Whilst adding the docs for the missing entries, please delete this
blank line!

Otherwise patch looks good to me.

Jonathan
	
>  
>  struct ad5791_chip_info {
> -	int (*get_lin_comp)	(unsigned int span);
> +	const char *name;
> +	const struct iio_chan_spec channel;
> +	int (*get_lin_comp)(unsigned int span);
>  };
>  
>  /**
> @@ -98,13 +100,6 @@ struct ad5791_state {
>  	} data[3] __aligned(IIO_DMA_MINALIGN);
>  };
>  
> -enum ad5791_supported_device_ids {
> -	ID_AD5760,
> -	ID_AD5780,
> -	ID_AD5781,
> -	ID_AD5791,
> -};
> -
>  static int ad5791_spi_write(struct ad5791_state *st, u8 addr, u32 val)
>  {
>  	st->data[0].d32 = cpu_to_be32(AD5791_CMD_WRITE |
> @@ -228,20 +223,6 @@ static int ad5780_get_lin_comp(unsigned int span)
>  	else
>  		return AD5780_LINCOMP_10_20;
>  }
> -static const struct ad5791_chip_info ad5791_chip_info_tbl[] = {
> -	[ID_AD5760] = {
> -		.get_lin_comp = ad5780_get_lin_comp,
> -	},
> -	[ID_AD5780] = {
> -		.get_lin_comp = ad5780_get_lin_comp,
> -	},
> -	[ID_AD5781] = {
> -		.get_lin_comp = ad5791_get_lin_comp,
> -	},
> -	[ID_AD5791] = {
> -		.get_lin_comp = ad5791_get_lin_comp,
> -	},
> -};
>  
>  static int ad5791_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
> @@ -289,30 +270,34 @@ static const struct iio_chan_spec_ext_info ad5791_ext_info[] = {
>  	{ },
>  };
>  
> -#define AD5791_CHAN(bits, _shift) {			\
> -	.type = IIO_VOLTAGE,				\
> -	.output = 1,					\
> -	.indexed = 1,					\
> -	.address = AD5791_ADDR_DAC0,			\
> -	.channel = 0,					\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> -		BIT(IIO_CHAN_INFO_OFFSET),		\
> -	.scan_type = {					\
> -		.sign = 'u',				\
> -		.realbits = (bits),			\
> -		.storagebits = 24,			\
> -		.shift = (_shift),			\
> -	},						\
> -	.ext_info = ad5791_ext_info,			\
> +#define AD5791_DEFINE_CHIP_INFO(_name, bits, _shift, _lin_comp)		\
> +static const struct ad5791_chip_info _name##_chip_info = {		\
> +	.name = #_name,							\
> +	.get_lin_comp = &(_lin_comp),					\
> +	.channel = {							\
> +			.type = IIO_VOLTAGE,				\
> +			.output = 1,					\
> +			.indexed = 1,					\
> +			.address = AD5791_ADDR_DAC0,			\
> +			.channel = 0,					\
> +			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_OFFSET),		\
> +			.scan_type = {					\
> +				.sign = 'u',				\
> +				.realbits = (bits),			\
> +				.storagebits = 24,			\
> +				.shift = (_shift),			\
> +			},						\
> +			.ext_info = ad5791_ext_info,			\
> +	},								\
>  }
>  
> -static const struct iio_chan_spec ad5791_channels[] = {
> -	[ID_AD5760] = AD5791_CHAN(16, 4),
> -	[ID_AD5780] = AD5791_CHAN(18, 2),
> -	[ID_AD5781] = AD5791_CHAN(18, 2),
> -	[ID_AD5791] = AD5791_CHAN(20, 0)
> -};
> +AD5791_DEFINE_CHIP_INFO(ad5760, 16, 4, ad5780_get_lin_comp);
> +AD5791_DEFINE_CHIP_INFO(ad5780, 18, 2, ad5780_get_lin_comp);
> +AD5791_DEFINE_CHIP_INFO(ad5781, 18, 2, ad5791_get_lin_comp);
> +AD5791_DEFINE_CHIP_INFO(ad5790, 20, 0, ad5791_get_lin_comp);
> +AD5791_DEFINE_CHIP_INFO(ad5791, 20, 0, ad5791_get_lin_comp);



