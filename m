Return-Path: <linux-iio+bounces-8733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 308EC95D58E
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC49281827
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B08B191F81;
	Fri, 23 Aug 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV7IOqWU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C492D7B8;
	Fri, 23 Aug 2024 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439180; cv=none; b=XuJAuiMP55PR7eA70TrNiqtOKGZ4mp6mFIOe0yTAoPFkMU8R6YGuRBOjQoMKwTJH8mWG1tINKh0yquT2sxA1wnrlTGk6PX9kC6+4Z/WV2Fgvfqs2NdpnnJrfudJHZVWAFVdh7EZuMwuxzMMlg+o5/iempGk/MQLXrWiG2JHnWEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439180; c=relaxed/simple;
	bh=a5OnLJfANYSC5UrYhkqe36Xaupf77ZFrSR4vNWZCGsk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHrLaRaOctOwbVAWgN6T1plSqcrhfavY1rREr+FL2sWnPYHvxrqWsGvb320FH5Ukb7FxO3Teb5jZLt6KiYy223PLmsrsdeQ8xbzNl9iGApP3leZJZTOwepuPZ2z8STisFfyIsAAV1e+55u5wnZPhQqPO721+eWqgP9nXpZGrKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV7IOqWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DBCC32786;
	Fri, 23 Aug 2024 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724439179;
	bh=a5OnLJfANYSC5UrYhkqe36Xaupf77ZFrSR4vNWZCGsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jV7IOqWUhN3S57Hw2VodnlilfntQODqmLNXT2F6vAfpxhqc/OKBjyuS+MUtg07PWw
	 wCrfTEm069K9fbyvC8GU7IV0tv267kxCPYuWAnv9DbtYiNxG4905N3Qm42AH49se27
	 N6gr4VJnrwNmsFUcMQ+5hikSjiC9Ul1uDrW4FfD4ioa8TN2lvefMwPg31TUQtvwzIG
	 vXUzCe1VQ6YIMwZEASGpcWRFLMDtCR1QEYxg0UZULSBMkLfOkDn3rWnNpVHh3fxr5K
	 +wvKHrBJR2GT7SFrf2kT+BFyas0ke+MXBYRWrAT4ZguVCHNRsuj2em9RhzMJp9Xe+C
	 xI2yxfovXv8kA==
Date: Fri, 23 Aug 2024 19:52:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH 1/7] iio: adc: ad7606: add 'bits' parameter to channels
 macros
Message-ID: <20240823195251.032c0c22@jic23-huawei>
In-Reply-To: <20240819064721.91494-2-aardelean@baylibre.com>
References: <20240819064721.91494-1-aardelean@baylibre.com>
	<20240819064721.91494-2-aardelean@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 09:47:11 +0300
Alexandru Ardelean <aardelean@baylibre.com> wrote:

> There are some newer additions to the AD7606 family, which support 18 bit
> precision.

Hi Alexandru,

> Up until now, all chips were 16 bit.
> 
> This change adds a 'bits' parameter to the AD760X_CHANNEL macro and renames
> 'ad7606_channels' -> 'ad7606_channels_16bit' for the current devices.
> 
> The AD7606_CHANNEL_PER_CHAN_SCALE() macro is also introduced, as it will
> also require that the number of bits be correctly adjusted (for 18 bit
> parts).
Where is that introduced?  There is a _SW_ variant of one macro that isn't
mentioned...

J
> 
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c     | 58 ++++++++++++++++++------------------
>  drivers/iio/adc/ad7606.h     | 18 ++++++-----
>  drivers/iio/adc/ad7606_spi.c | 16 +++++-----
>  3 files changed, 47 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 539e4a8621fe..dba1f28782e4 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -333,16 +333,16 @@ static const struct iio_chan_spec ad7605_channels[] = {
>  	AD7605_CHANNEL(3),
>  };
>  
> -static const struct iio_chan_spec ad7606_channels[] = {
> +static const struct iio_chan_spec ad7606_channels_16bit[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(8),
> -	AD7606_CHANNEL(0),
> -	AD7606_CHANNEL(1),
> -	AD7606_CHANNEL(2),
> -	AD7606_CHANNEL(3),
> -	AD7606_CHANNEL(4),
> -	AD7606_CHANNEL(5),
> -	AD7606_CHANNEL(6),
> -	AD7606_CHANNEL(7),
> +	AD7606_CHANNEL(0, 16),
> +	AD7606_CHANNEL(1, 16),
> +	AD7606_CHANNEL(2, 16),
> +	AD7606_CHANNEL(3, 16),
> +	AD7606_CHANNEL(4, 16),
> +	AD7606_CHANNEL(5, 16),
> +	AD7606_CHANNEL(6, 16),
> +	AD7606_CHANNEL(7, 16),
>  };
>  
>  /*
> @@ -357,22 +357,22 @@ static const struct iio_chan_spec ad7606_channels[] = {
>   */
>  static const struct iio_chan_spec ad7616_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(16),
> -	AD7606_CHANNEL(0),
> -	AD7606_CHANNEL(1),
> -	AD7606_CHANNEL(2),
> -	AD7606_CHANNEL(3),
> -	AD7606_CHANNEL(4),
> -	AD7606_CHANNEL(5),
> -	AD7606_CHANNEL(6),
> -	AD7606_CHANNEL(7),
> -	AD7606_CHANNEL(8),
> -	AD7606_CHANNEL(9),
> -	AD7606_CHANNEL(10),
> -	AD7606_CHANNEL(11),
> -	AD7606_CHANNEL(12),
> -	AD7606_CHANNEL(13),
> -	AD7606_CHANNEL(14),
> -	AD7606_CHANNEL(15),
> +	AD7606_CHANNEL(0, 16),
> +	AD7606_CHANNEL(1, 16),
> +	AD7606_CHANNEL(2, 16),
> +	AD7606_CHANNEL(3, 16),
> +	AD7606_CHANNEL(4, 16),
> +	AD7606_CHANNEL(5, 16),
> +	AD7606_CHANNEL(6, 16),
> +	AD7606_CHANNEL(7, 16),
> +	AD7606_CHANNEL(8, 16),
> +	AD7606_CHANNEL(9, 16),
> +	AD7606_CHANNEL(10, 16),
> +	AD7606_CHANNEL(11, 16),
> +	AD7606_CHANNEL(12, 16),
> +	AD7606_CHANNEL(13, 16),
> +	AD7606_CHANNEL(14, 16),
> +	AD7606_CHANNEL(15, 16),
>  };
>  
>  static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
> @@ -382,25 +382,25 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
>  		.num_channels = 5,
>  	},
>  	[ID_AD7606_8] = {
> -		.channels = ad7606_channels,
> +		.channels = ad7606_channels_16bit,
>  		.num_channels = 9,
>  		.oversampling_avail = ad7606_oversampling_avail,
>  		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
>  	},
>  	[ID_AD7606_6] = {
> -		.channels = ad7606_channels,
> +		.channels = ad7606_channels_16bit,
>  		.num_channels = 7,
>  		.oversampling_avail = ad7606_oversampling_avail,
>  		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
>  	},
>  	[ID_AD7606_4] = {
> -		.channels = ad7606_channels,
> +		.channels = ad7606_channels_16bit,
>  		.num_channels = 5,
>  		.oversampling_avail = ad7606_oversampling_avail,
>  		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
>  	},
>  	[ID_AD7606B] = {
> -		.channels = ad7606_channels,
> +		.channels = ad7606_channels_16bit,
>  		.num_channels = 9,
>  		.oversampling_avail = ad7606_oversampling_avail,
>  		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 0c6a88cc4695..771121350f98 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -8,7 +8,7 @@
>  #ifndef IIO_ADC_AD7606_H_
>  #define IIO_ADC_AD7606_H_
>  
> -#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all) {	\
> +#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {	\
>  		.type = IIO_VOLTAGE,				\
>  		.indexed = 1,					\
>  		.channel = num,					\
> @@ -19,24 +19,26 @@
>  		.scan_index = num,				\
>  		.scan_type = {					\
>  			.sign = 's',				\
> -			.realbits = 16,				\
> -			.storagebits = 16,			\
> +			.realbits = (bits),			\
> +			.storagebits = (bits),			\
>  			.endianness = IIO_CPU,			\
>  		},						\
>  }
>  
>  #define AD7605_CHANNEL(num)				\
>  	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
> -		BIT(IIO_CHAN_INFO_SCALE), 0)
> +		BIT(IIO_CHAN_INFO_SCALE), 0, 16)
>  
> -#define AD7606_CHANNEL(num)				\
> +#define AD7606_CHANNEL(num, bits)			\
>  	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
>  		BIT(IIO_CHAN_INFO_SCALE),		\
> -		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
>  
> -#define AD7616_CHANNEL(num)	\
> +#define AD7606_SW_CHANNEL(num, bits)	\
>  	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
> -		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> +		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
> +
> +#define AD7616_CHANNEL(num)	AD7606_SW_CHANNEL(num, 16)
>  
>  /**
>   * struct ad7606_chip_info - chip specific information
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index 287a0591533b..dd0075c97c24 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -67,14 +67,14 @@ static const struct iio_chan_spec ad7616_sw_channels[] = {
>  
>  static const struct iio_chan_spec ad7606b_sw_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(8),
> -	AD7616_CHANNEL(0),
> -	AD7616_CHANNEL(1),
> -	AD7616_CHANNEL(2),
> -	AD7616_CHANNEL(3),
> -	AD7616_CHANNEL(4),
> -	AD7616_CHANNEL(5),
> -	AD7616_CHANNEL(6),
> -	AD7616_CHANNEL(7),
> +	AD7606_SW_CHANNEL(0, 16),
> +	AD7606_SW_CHANNEL(1, 16),
> +	AD7606_SW_CHANNEL(2, 16),
> +	AD7606_SW_CHANNEL(3, 16),
> +	AD7606_SW_CHANNEL(4, 16),
> +	AD7606_SW_CHANNEL(5, 16),
> +	AD7606_SW_CHANNEL(6, 16),
> +	AD7606_SW_CHANNEL(7, 16),
>  };
>  
>  static const unsigned int ad7606B_oversampling_avail[9] = {


