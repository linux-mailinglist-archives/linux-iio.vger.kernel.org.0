Return-Path: <linux-iio+bounces-12704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE49D9D9C
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A063F28331F
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677EB1DDC2B;
	Tue, 26 Nov 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3vA+Q7f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86A1D45EF;
	Tue, 26 Nov 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646771; cv=none; b=HNJwdlsN91d4HashKyHYveAhexKcmvSbM5Qohd9+8sXVeIvGosGn4H/7MsdK1+LxSMS2nbOkH3jZ24hvv3l/NzGUge+UBTB2CcXiYkJGXtjsOml3bT/RbHa/A1azOfOcuvfaIxLXa+IYBIfz+pnHALYrYGtjc2kOPKJfa6wmcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646771; c=relaxed/simple;
	bh=Xg5aw9e03x+ZlE/v5a5yHAHcVA7j7eBH74adS6n67Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJomgkou9vQR+a52TkBbeRfcjExzf7/6FHRhEBwVDTdUmJnNiW0TBe67CbQ92O3u9bJb9Be/ptTMu0BiR8UePaCakafglUI2DO7hiEiPKImKfkbcjDnVSghD5+LO6xRWxWLO0KasdA8zhCeoTpRim8ir9fAU8XAkKqS9eqF31eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3vA+Q7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65499C4CED0;
	Tue, 26 Nov 2024 18:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732646771;
	bh=Xg5aw9e03x+ZlE/v5a5yHAHcVA7j7eBH74adS6n67Jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U3vA+Q7fRbeKWW5CNLjKkut9m6IvDVoxVxWgvxqbE4GsD0IixqDEUqd9RTEkqV1Ec
	 f9smkPnKE3QEbkbt5+J2nJhFF7aZysuTb7X7kfcnEvIOgDELRSzX8apWo6LRduyfNT
	 HxVwcGeUjOzbye25ABIVTz2NBHkHE4w5QX1kAulnyq50HoA+XSyYO8utqkZjWrzK/r
	 Ncmb1G9XURcDRG7UuRQFV4Z929w9T38T94H9nGf9+wuMwOao63asLyoJKrEMmmOxjo
	 w/BAveUVL8oBdWtnmubjjuRD7yTDms8Fn5Zg+rA3hfx4xerhOqn3nm8l2dSE/+LtyU
	 T91kPXqzLSQjA==
Date: Tue, 26 Nov 2024 18:46:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com,
 aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH 8/9] iio: adc: ad7606: Simplify channel macros
Message-ID: <20241126184604.5a4c74d0@jic23-huawei>
In-Reply-To: <20241121-ad7606_add_iio_backend_software_mode-v1-8-8a693a5e3fa9@baylibre.com>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
	<20241121-ad7606_add_iio_backend_software_mode-v1-8-8a693a5e3fa9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 10:18:30 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> This is a preparation to add the new channels for software mode and
> hardware mode in iio backend mod more easily.

I'm not sure this 'simplifies' anything!  Maybe change title.

> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.h | 51 ++++++++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index eca7ea99e24d..74896d9f1929 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -40,37 +40,19 @@
>  #define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
>  #define AD7606_OS_MODE			0x08
>  
> -#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {	\
> +#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all,	\
> +		mask_sep_avail, mask_all_avail, bits) {		\
>  		.type = IIO_VOLTAGE,				\
>  		.indexed = 1,					\
>  		.channel = num,					\
>  		.address = num,					\
>  		.info_mask_separate = mask_sep,			\
> +		.info_mask_separate_available =			\
> +			mask_sep_avail,				\
>  		.info_mask_shared_by_type = mask_type,		\
>  		.info_mask_shared_by_all = mask_all,		\
> -		.scan_index = num,				\
> -		.scan_type = {					\
> -			.sign = 's',				\
> -			.realbits = (bits),			\
> -			.storagebits = (bits) > 16 ? 32 : 16,	\
> -			.endianness = IIO_CPU,			\
> -		},						\
> -}
> -
> -#define AD7606_SW_CHANNEL(num, bits) {				\
> -		.type = IIO_VOLTAGE,				\
> -		.indexed = 1,					\
> -		.channel = num,					\
> -		.address = num,					\
> -		.info_mask_separate =				\
> -			BIT(IIO_CHAN_INFO_RAW) |		\
> -			BIT(IIO_CHAN_INFO_SCALE),		\
> -		.info_mask_separate_available =			\
> -			BIT(IIO_CHAN_INFO_SCALE),		\
> -		.info_mask_shared_by_all =			\
> -			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
>  		.info_mask_shared_by_all_available =		\
> -			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +			mask_all_avail,				\
>  		.scan_index = num,				\
>  		.scan_type = {					\
>  			.sign = 's',				\
> @@ -82,12 +64,28 @@
>  
>  #define AD7605_CHANNEL(num)				\
>  	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
> -		BIT(IIO_CHAN_INFO_SCALE), 0, 16)
> +		BIT(IIO_CHAN_INFO_SCALE), 0, 0, 0, 16)
>  
>  #define AD7606_CHANNEL(num, bits)			\
>  	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
>  		BIT(IIO_CHAN_INFO_SCALE),		\
> -		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +		0, 0, bits)
> +
> +#define AD7606_SW_CHANNEL(num, bits)			\
> +	AD760X_CHANNEL(num,				\
> +		/* mask separate */			\
> +		BIT(IIO_CHAN_INFO_RAW) |		\
> +		BIT(IIO_CHAN_INFO_SCALE),		\

Maybe use some longer lines to avoid so much wrapping.

> +		/* mask type */				\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +		/* mask all */				\
> +		0,					\
> +		/* mask separate available */		\
> +		BIT(IIO_CHAN_INFO_SCALE),		\
> +		/* mask all available */		\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +		bits)
>  
>  #define AD7616_CHANNEL(num)	AD7606_SW_CHANNEL(num, 16)
>  
> @@ -95,7 +93,8 @@
>  	AD760X_CHANNEL(num, 0,				\
>  		BIT(IIO_CHAN_INFO_SCALE),		\
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
> -		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), 16)
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),  \
> +		0, 0, 16)
>  
>  struct ad7606_state;
>  
> 


