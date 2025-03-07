Return-Path: <linux-iio+bounces-16521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C854A5691F
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 14:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5733A3B2319
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 13:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F6321A426;
	Fri,  7 Mar 2025 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4ENfnLT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F71DEBE;
	Fri,  7 Mar 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354880; cv=none; b=hOZrC1UMAnJYkZRg0F4M5unmv5Bvx+ZCoXn/zBOUfP7dOKFx/koVkZDWxZEjvRJMBjjqSF0snbK8I6OhezX6n7oBA7OwJ8m+AACdrhctfdwcioiw5xm1yX46c7Kq6DcuviAVI/njxvyFJXr018Kdp7sauRZ94RT11JYClWp9Zdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354880; c=relaxed/simple;
	bh=N8sYo3uz0FrCRUbMqngY+YYmmopRY57XHjzEdmi1tY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXiuHSv0R4fe4kVTj+9d2u9pp0AW7UMcYKeHuIjOLcCdjsz6QGXWSSAI+eHdsQgxd9kZW7aFEGxEK/Du1jNdM0PaTXsWE8XFWFuqu8meptTYRV1fugyVMueZo34+V4gBm+MMtW7BaSlWRquCtgl2zAn+NGJ1g8S+FwRpiiCHYvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4ENfnLT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223a7065ff8so5895965ad.0;
        Fri, 07 Mar 2025 05:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741354877; x=1741959677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h38aqFe9Ma4NHWsTUuQBby7UCorGRNLzawB5Rnpg1KI=;
        b=G4ENfnLTH4tvY2co9QGuN7K2rR1L4r7dXc9OgAm2byrNAvYj84i1bc0xaytPVDWB6L
         Xla8YFi3DA0q78MXfUEHh5v0W8W3zVxfct/HDLhX73kvGsAOcO4bGH7EG8Q1Os560a9i
         DvMj63ZWGRRInA+pvSu8BZ8fohR/Q9OeS3R3a09DaMHvnPKRmgBJa1yrTToD0RqoHmYw
         1bvMAxYKR8GuEZc2jvfbxOPCWvN/YUFNshDYJg1TGEJKNzhw83gOVZmCDVMzm0+IWaT6
         yTDi6CE4cmLLvOtKCUpObm1bUgatcc7/OhVdM7hxATSh/QypcVhOk9q8ft7kAxDOD6Do
         E75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741354877; x=1741959677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h38aqFe9Ma4NHWsTUuQBby7UCorGRNLzawB5Rnpg1KI=;
        b=pjm6FVI4bfZfRDypFDwvCYZXbuQJQ1+udhy3NUpdEr183Bzs0mv5bBmLfRmlAF+8sY
         kD0fpwQTedhb8QfIo3CRm0gblj/zs33kAbPdG554uQ76m2lJPWGyILhfTX3ejZ9Ckyft
         MgMvWDjPYzfn3xktFJkZJeXhGrSImjhbroaIPeZRzp3OMMII+1DJfNhpGY2W5C//HV1L
         j2n7d98h4JYrlbZpHz5tdinJNFAUanc/i608q4uBBYNpH1HD7OJl74XyVdP3fCQirx6D
         9gPG5CcxGgmr9MnhU7HBSe4IWSGp81VSfHWBd4LhHj0t7jv5NwtOWiRwVTG2lwLO0kLB
         1z4g==
X-Forwarded-Encrypted: i=1; AJvYcCUBf13ovEKM8w3S+1luF7l46fO94UHsbf9jvkpdj+bKUx8HlpUxBstrvsLSAl/GrkcfI9BB+01f0lHC9A==@vger.kernel.org, AJvYcCV4oeeNZkRCe5y1B0nwy72939j4O2P3PzaFASSQsfyzKumjcNUeYF8iU8D9mFkYsdq6lIDSPqGMGgxZJTrI@vger.kernel.org, AJvYcCXIDylVZ7RCyeXMZd7VTyDYW5/hluZTNH7quRJiIQPG8D4GcEA7qWbj0CrELYuz/FpWQFOqwH0BKEoD@vger.kernel.org
X-Gm-Message-State: AOJu0YxN1pFk9l7iB64xm4Va5KBsyLQJed2WJpOJNf/9zc/LksE7RH2S
	peDR9jcdlEfDzVUjmoFWI5XCo9dso6/CRusa3kK7A9MZXVan5b1K
X-Gm-Gg: ASbGncsN9TBGAfLJSE0CiruZdZ4kM3qFFQbe2Ru/mAYkGICYPDtEsx8x4ZGyo5yE37y
	fajVynOSdBnXjpIc0ulSwT6zTOixuoVVeu/+cd2AuHgPjFRcKU2Avp2CM8nBefTi0VbHqUpDYrc
	+5tVgy9HYGoNIYwC2TrK8pn3M5SwErFj0SyKuJlFMJBogcnbp8OQr1zSfVcyLqSpuVq41awaEWi
	cbK/WjzFNfsGNZV3IEe9g1v+l4W088herq3y84bLTQbMYeNHa9YOpXwFsUbP824bVYBCNhFhIFA
	7Heok+yp4PzkNqE9YwjKpPOKfsTBGXRsX3IFEDzxELsuX/597skGcg==
X-Google-Smtp-Source: AGHT+IFNfcJHZ+3VSfDlVytA+8MieA2fcDSQnh0iehKMSSKusFnNT8AR7I9mN5SQu5o+C1VqXZA3zA==
X-Received: by 2002:a05:6a00:2d90:b0:736:48d1:57f7 with SMTP id d2e1a72fcca58-736aa9dc1d5mr5359686b3a.7.1741354877520;
        Fri, 07 Mar 2025 05:41:17 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73698206ba4sm3220610b3a.4.2025.03.07.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:41:16 -0800 (PST)
Date: Fri, 7 Mar 2025 10:42:09 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	lgirdwood@gmail.com, broonie@kernel.org, dlechner@baylibre.com,
	jonath4nns@gmail.com
Subject: Re: [PATCH v4 09/17] iio: adc: ad7768-1: Add reset gpio
Message-ID: <Z8r3sR740CpZfVFr@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <305f0bb4a90aba547de6b46d4c9dcf04a2a4db72.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305f0bb4a90aba547de6b46d4c9dcf04a2a4db72.1741268122.git.Jonathan.Santos@analog.com>

On 03/06, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> Depending on the controller, the default state of a gpio can vary. This
> change excludes the probability that the dafult state of the ADC reset
> gpio will be HIGH if it will be passed as reference in the devicetree.

The description doesn't seem to match the changes nor the patch title. You are
essentinally adding support for hardware reset. Change the commit description to
reflect that.

The default state of GPIOs would not impact device reset because (in theory)
they weren't being connected to the reset pin prevously.

> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v4 Changes:
> * None.
> 
> v3 Changes:
> * fixed SoB order.
> * increased delay after finishing the reset action to 200us, as the
>   datasheet recommends.
> 
> v2 Changes:
> * Replaced usleep_range() for fsleep() and gpiod_direction_output() for 
>   gpiod_set_value_cansleep().
> * Reset via SPI register is performed if the Reset GPIO is not defined. 
> ---
>  drivers/iio/adc/ad7768-1.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 04a26e5b7d5c..86f44d28c478 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -166,6 +166,7 @@ struct ad7768_state {
>  	struct completion completion;
>  	struct iio_trigger *trig;
>  	struct gpio_desc *gpio_sync_in;
> +	struct gpio_desc *gpio_reset;
>  	const char *labels[ARRAY_SIZE(ad7768_channels)];
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
> @@ -487,19 +488,30 @@ static int ad7768_setup(struct ad7768_state *st)
>  {
>  	int ret;
>  
> -	/*
> -	 * Two writes to the SPI_RESET[1:0] bits are required to initiate
> -	 * a software reset. The bits must first be set to 11, and then
> -	 * to 10. When the sequence is detected, the reset occurs.
> -	 * See the datasheet, page 70.
> -	 */
> -	ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x3);
> -	if (ret)
> -		return ret;
> +	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
> +						 GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->gpio_reset))
> +		return PTR_ERR(st->gpio_reset);
>  
> -	ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x2);
> -	if (ret)
> -		return ret;
> +	if (st->gpio_reset) {
> +		fsleep(10);
> +		gpiod_set_value_cansleep(st->gpio_reset, 0);
> +		fsleep(200);
> +	} else {
> +		/*
> +		 * Two writes to the SPI_RESET[1:0] bits are required to initiate
> +		 * a software reset. The bits must first be set to 11, and then
> +		 * to 10. When the sequence is detected, the reset occurs.
> +		 * See the datasheet, page 70.
> +		 */
> +		ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x3);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x2);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	st->gpio_sync_in = devm_gpiod_get(&st->spi->dev, "adi,sync-in",
>  					  GPIOD_OUT_LOW);
> -- 
> 2.34.1
> 

