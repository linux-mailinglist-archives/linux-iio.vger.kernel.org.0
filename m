Return-Path: <linux-iio+bounces-14426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCFDA15323
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 16:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58D716750A
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64130194A6B;
	Fri, 17 Jan 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="utrhUUkS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE52192D76
	for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128934; cv=none; b=P3ntkE9I+YBNB/rRG4Hr26EkXjcDfNF1MRP7RM9xs88njZ0o9kk8kebuP3uHLTIPY0mh8q1yOlULto65WSauSAb4Iae5unYmh4kBkqfJk2TvFlS4OS0P3Be3/OZPLNp5Emtmv0+89JxtKDYCafWMFHBGgEiJN0HR/DpNXUuob4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128934; c=relaxed/simple;
	bh=T/09PAn0K9MknUR73hMHLd+8kcIwW0SWgv9GknFSW74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tembcYmBXv1WDb1M/vKZzqzP4eVp9pTQXo3Qh9YmwuScVaRsnZlk6siHbYAHVifyUeSpi8tOK91yQ/cDdqI5qNElmHb0TdFKv9wKEFYPnFbsPuJ6AVWBeo6ucWzjtEBGaTW4qy9Gd6rGrU1Iw22GKk+uxOoHhC33edug/oLxb5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=utrhUUkS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385de9f789cso1715018f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 07:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737128929; x=1737733729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wp5lDYQ/FVQNKqP77PtuRYPa4kZQpA/61vS4WS8uPJM=;
        b=utrhUUkSFOqlzWV4Llpd7d8mldG61LZ9ibnlmd71duOHj2yEpeWNffBBoNom2/r5Sc
         W9JdQMSd7J/59LehHJlP2hWpE4XuzqtZGzhYYSg/PfWhECtPZynwFRpQ4+gC7ZMC9Fzx
         obIQ1a8TeusDnMcDUUW9iqdM2n/YLuX0gM7JyCJBqdPFAHLREDVbBw49sA0E67SXzg1E
         ehonmWHJuIJ11ZYJ3HkVSDTdue07GtxdApSR3UcRwa/XUBvLx/bAmiNS5flK2SGwMbJS
         HogdvTR0HGYPyCYB51skhLp5gU49sZW0yLfaEVlPgP8zgqXtBhmCATahUAxLlLcuo/JP
         AXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737128929; x=1737733729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wp5lDYQ/FVQNKqP77PtuRYPa4kZQpA/61vS4WS8uPJM=;
        b=Tv22AwJmN2z9ks8kbgBTmJRp4q366vnND5ZDK8n3K2LY2Yz4WdPetCk7ljo1+fdCu+
         cpMOMe+vQ5Py1VFjyKtsQYf2ggp2JYNN1imREKw906VFn0/NdAAH26aJ8nLuJwFpd3Q+
         BSCKpeMqK0iLQ66LeKujC8/0EA/zdRQ9SKh6Vpng4YmzZsM4wlbOYzyw/Va3R4c55/zE
         n1t1Yvm3ELmsoyAnnS2yy6L/zT02XXTmTsSWcRDSqRDZAMHMiGyIiR9TQJRV/bcEC4Wy
         ypQHz5ycJdDvbI1P5w5uK+wgMuDA9oQxajUxDaD5qI1mFlwPOUIbYRz0UHU1uj68tKcB
         b2lw==
X-Forwarded-Encrypted: i=1; AJvYcCUFUgl5xcXdwVeR8IWPEIBPp9shVcgzpznoy3psE+GUYoQq47v4ezDa9mKwXwc9exL/pr3+ZblNiwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLMqRZCOq71VZzfmCS1mMobpp/qRTGwCRQa/8THNd+NISL0BlS
	sjU8T4si646dbU7TNIEsqf5qONqPb2iuGPBVSmTLcnCHtHBNpgJOmzmp0HIxzfk=
X-Gm-Gg: ASbGncsQMEvE7X+3VSGX1EPYyzCYNQBYONnc9ZB7FEFFKjMsEbScSjE2YOfh/KS4/+r
	K4cxN1EmyjnAuhw4ijJQmkXAQr80f4OWtE9v/4CYDwkqH+LSqYoYengummbFV7HAgKA5zM535as
	m/v2OIPpnAzq82Kq6PIA6UU2UVjFbgtLE84UyKubLauT3yBPJadwWAubqmDPny/ExEhu9l+ynKT
	jL1jhl/n4+s2acOQ5nBMenAcIfvamcEj5p6SNutx/Lv2+WhXpsoJeJWUWcQMQn+krOF3Hfgum5L
	fUAsupWBtMJm3vAXmL9F//rAYw==
X-Google-Smtp-Source: AGHT+IEUwldAZQq+9u44Cgxr20RCrrtNFuCZgAttsz2mk4lnSLbnQasV79BguyJKWinaPHhq+x/qVQ==
X-Received: by 2002:a05:6000:1a8c:b0:38b:ed6f:f00f with SMTP id ffacd0b85a97d-38bf56635a1mr2730865f8f.17.1737128929108;
        Fri, 17 Jan 2025 07:48:49 -0800 (PST)
Received: from dfj (host-95-245-235-245.retail.telecomitalia.it. [95.245.235.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322a506sm2775979f8f.41.2025.01.17.07.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 07:48:48 -0800 (PST)
Date: Fri, 17 Jan 2025 16:47:18 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v7 14/17] iio: adc: ad4695: Add support for SPI offload
Message-ID: <ls32gl5a7nsihmmpfabxhm6ilg7idyxdhyrhbkay6e2fiokoah@o5ujfxlsq3s3>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
 <20250113-dlech-mainline-spi-engine-offload-2-v7-14-e0860c81caae@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-dlech-mainline-spi-engine-offload-2-v7-14-e0860c81caae@baylibre.com>

Hi,

noticed just one possible issue here, see below.

On 13.01.2025 15:00, David Lechner wrote:
> Add support for SPI offload to the ad4695 driver. SPI offload allows
> sampling data at the max sample rate (500kSPS or 1MSPS).
> 
> This is developed and tested against the ADI example FPGA design for
> this family of ADCs [1].
> 
> [1]: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v7 changes: none
> 
> v6 changes:
> * Fixed use of c++ style comments
> * Moved static const struct definition out of probe function
> * Changes bits_per_word to always be 19 for future oversampling
>   compatibility (Trevor is working on implementing oversampling support
>   on top of this patch, so we have high confidence this is the correct
>   thing to do)
> * Fixed wrong xfer->len
> 
> v5 changes:
> * Register SCLK speed handling has been split out into a separate series.
> * Add sampling_frequency_available attribute.
> * Limit max allowed sampling frequency based on chip info.
> * Expand explanations of offload enable/disable ordering requirements.
> * Finish TODO to use macros for phandle arg values.
> * Don't use dev_info() when falling back to non-offload operation.
> * Update to accommodate changes in other patches in this series.
> 
> v4 changes: new patch in v4
> ---
>  drivers/iio/adc/Kconfig  |   1 +
>  drivers/iio/adc/ad4695.c | 445 +++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 429 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 995b9cacbaa964d26424346120c139858f93cdcd..ec60b64c46e187e2be18ab1f8ca9e6f4f03299f9 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -52,6 +52,7 @@ config AD4695
>  	tristate "Analog Device AD4695 ADC Driver"
>  	depends on SPI
>  	select IIO_BUFFER
> +	select IIO_BUFFER_DMAENGINE
>  	select IIO_TRIGGERED_BUFFER
>  	select REGMAP
>  	help
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> index 13cf01d35301be40369571e7dd2aeac1a8148d15..c8cd73d19e869f11999608f61df5724d329b4427 100644
> --- a/drivers/iio/adc/ad4695.c
> +++ b/drivers/iio/adc/ad4695.c
> @@ -19,14 +19,19 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/minmax.h>
> +#include <linux/mutex.h>
>  #include <linux/property.h>
> +#include <linux/pwm.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/spi/offload/consumer.h>
> +#include <linux/spi/offload/provider.h>
>  #include <linux/spi/spi.h>
>  #include <linux/units.h>

...

> +static int ad4695_offload_trigger_request(struct spi_offload_trigger *trigger,
> +					  enum spi_offload_trigger_type type,
> +					  u64 *args, u32 nargs)
> +{
> +	struct ad4695_state *st = spi_offload_trigger_get_priv(trigger);
> +
> +	/* Should already be validated by match, but just in case. */
> +	if (nargs != 2)
> +		return -EINVAL;
> +
> +	/* DT tells us if BUSY event uses GP0 or GP3. */
> +	if (args[1] == AD4695_TRIGGER_PIN_GP3)
> +		return regmap_set_bits(st->regmap, AD4695_REG_GP_MODE,
> +				       AD4695_REG_GP_MODE_BUSY_GP_SEL);
> +
> +	return regmap_clear_bits(st->regmap, AD4695_REG_GPIO_CTRL,
> +				 AD4695_REG_GP_MODE_BUSY_GP_SEL);

This should probably be:
         
        return regmap_clear_bits(st->regmap, AD4695_REG_GPIO_MODE,
                                 AD4695_REG_GP_MODE_BUSY_GP_SEL);

> +}
> +

Regards,
angelo


