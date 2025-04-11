Return-Path: <linux-iio+bounces-17988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA439A868F4
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 00:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE818C1573
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 22:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889682BD588;
	Fri, 11 Apr 2025 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KC9Ajb5D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E06520B7F1
	for <linux-iio@vger.kernel.org>; Fri, 11 Apr 2025 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744411744; cv=none; b=KLhF4Kxd11QtTAxd+dkTuqdR+Q8EAKr1MCN+O7Zwdagb3HFJRVGwtPHSVkrSMDfOk8xqzH9JhfeT/VTDW5dKowp5B1NNZPI6JiNhBh8qE8PnZCQHA+1rA2FCeZl4jTKBU+wVGI98G2Dgc5mD+tep2s1cACqQCUVqe2IpPnuKObI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744411744; c=relaxed/simple;
	bh=+gKutII6aXJ0wrUffjvqF0sKi2f15qSdVcu/a6hEHUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJ+Ajf+MNVxe47rKDPNWvL+JtJr3DPrV01iFC9EgocEwfCGnPvtWPUjau7e0YSwXCtlEU4SfRCv8ZwzYv4F1xD9rO4wUGnmeUbV4XSxmNLVZrvsoOa3l5Gsp3i8U0BQGsW4ULC7uL+axXl7ftctlfCLMJzdtcAyzLxjXsPF9hi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KC9Ajb5D; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f94b7bd964so1556708b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 11 Apr 2025 15:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744411740; x=1745016540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wgl6Ni7QedexIS8h0jddujtCNFqc93iYEcO6ONe4NfU=;
        b=KC9Ajb5Dpsoty/uaX+eOh5x0SBH/jk7JE+jiafrrCjg3Jj4vbnZxgotZU1MV4mcXbs
         02kltKG/7MbbcoJAAUkPQEAgfJB76KYGrSxE6hMqu11xkIAA4lb+X+C3obiLZEyLKyP2
         1cMIo8bie3ZeAdKW0CpszEa+ULHm9KTpVMS0fih5RseRwhpuxVWNuyyJc9wfZXIs2OYq
         LL2h2WcUXROjH7hifojtZAZo9hPqVQhbuD4LndkPbZ8rX3i76o69IRZmAi/Erk3JlOEo
         DtvMklvKomsdTHXulgTzPckoUzsqB2BpgLRdJDDvhGzoBWYjkTgz7D2XMqSETg4yAoOY
         ceog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744411740; x=1745016540;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wgl6Ni7QedexIS8h0jddujtCNFqc93iYEcO6ONe4NfU=;
        b=tnCdo97abUjbgc0Tlax4TMQ/ei2NRBfkzmM5fFPLPdcXcrwRevPSB4UbryDTyn0KKy
         NEslGRTTvoegCb2kRzlzEy8xiFm7ZxLkQgySMlEp6dHDoBWwz4/ha497Nd43ZaQAK/Jq
         YahXR8lAkVpC6C8o3jVW30051TdKNyhOgefaIohcQ72WhdsgDrvdhvs6jWV0b+1XsBGe
         /VpCre925+apiPzeG8XL6xSlf5zz3mcGyZKipdRnu674l/GqbEJfUoqoA9MJwcm9ysI6
         XiNo+//ABSjPE9RkHWjYCFGL22t8tPH0bTxmppg537OQQBTauZ1ZjugebKTxEKcqomS3
         DQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKj6yhqlhKfPyWmUrTeZSjkX5S/T3RWL+p2bsGWpQo7pxuYiJsptTEGqDaO//8fLMen+vwEqnm/BY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcz8LSz4hZNFSufiRnMEvDxb/uaKrqfQa5O80HbCUYBhzs6fwY
	Bijyb7MWnsxUOK2/gMOxuo+w1AW/CzPUdC2GcvWBNIbd6TTeo1gMFh7zjEttABg=
X-Gm-Gg: ASbGncsEmN9DlroHvmIp2Sw4FVOXkDU1KcNfRIyfMuEOG1qkn7QtVsToQpWm9P5q3jI
	z1nyiJxJY28rkZWpBUr99wK2SZwka04D4UisOj6nGTnfoPZCl3e7EHJU8BbkHf3IZeOVQG6FHT7
	E5CzpMkvZVObE9+RTd8Mm29uDkjzWoZZJTxImOIv3govNyHuxI3hTB7yIkXK/3ievA6ZqOfCLnU
	jyS4KYaoAqPK/jCwyQ5X+nS4r8nGHACtzY4eVFHMi+p5nm8mmIKeZMmmHLoJZJEw1joaKcfQIwo
	5t2/aJ4hzytgtyHJc1vmaTI5i92Ku3iRbQJmc9iHLqOHEiOjMqxtHyD52X2JHLkJJF/9g7h6vNR
	ylg==
X-Google-Smtp-Source: AGHT+IHCKIFhKd0vSaIWD5eYx6N/Y34MvmmZSKbjYALR5hdgbPkTqP9spLNbVdc9G93C7ww5Tzmhmg==
X-Received: by 2002:a05:6808:1826:b0:3fb:a7d0:3b46 with SMTP id 5614622812f47-4008500563dmr2548539b6e.8.1744411740046;
        Fri, 11 Apr 2025 15:49:00 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4007639c9d5sm1120882b6e.39.2025.04.11.15.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 15:48:59 -0700 (PDT)
Message-ID: <97a2aebb-f707-4f88-be5f-d86bd795c65a@baylibre.com>
Date: Fri, 11 Apr 2025 17:48:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/14] iio: adc: ad7768-1: add support for
 Synchronization over SPI
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, jonath4nns@gmail.com
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
 <a4d0951fccade0f8e086416e94c4a38e1a21eb81.1744325346.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <a4d0951fccade0f8e086416e94c4a38e1a21eb81.1744325346.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 10:58 AM, Jonathan Santos wrote:
> The synchronization method using GPIO requires the generated pulse to be
> truly synchronous with the base MCLK signal. When it is not possible to
> do that in hardware, the datasheet recommends using synchronization over
> SPI, where the generated pulse is already synchronous with MCLK. This
> requires the SYNC_OUT pin to be connected to SYNC_IN pin.
> 
> Use trigger-sources property to enable device synchronization over SPI
> and to replace sync-in-gpios property for a gpio-trigger node.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v5 Changes:
> * Allow omitting trigger-sources property.

I didn't see this possibility mentioned in the dt-bindings patch. Maybe I missed
something?

> * include gpio-trigger to trigger-sources to replace adi,sync-in-gpios
>   property.
> * Read trigger-sources cell value to differentiate the trigger type.
> 

...

>  drivers/iio/adc/ad7768-1.c | 100 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 92 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 179806f821be..aa60c55afd24 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -100,6 +100,11 @@
>  
>  #define AD7768_VCM_OFF			0x07
>  
> +enum ad7768_trigger_type {
> +	AD7768_TRIGGER_TYPE_GPIO,
> +	AD7768_TRIGGER_TYPE_DEV
> +};

I assume this is supposed to correspond to the #trigger-source-cells argument?
It would make sense to put this in a dt-bindings/iio/adc/adi,ad7768-1.h file
in the dt-bindings patch so that it can also be used in .dts files.

> +static int ad7768_set_sync_source(struct device *dev, struct ad7768_state *st)
> +{
> +	struct fwnode_reference_args args;
> +	struct fwnode_handle *fwnode = NULL;
> +	const char *value;
> +	int trigger_type, ret;
> +
> +	/*
> +	 * The AD7768-1 allows two primary methods for driving the SYNC_IN pin
> +	 * to synchronize one or more devices:
> +	 * 1. Using a GPIO to directly drive the SYNC_IN pin.
> +	 * 2. Using a SPI command, where the SYNC_OUT pin generates a
> +	 *    synchronization pulse that loops back to the SYNC_IN pin.
> +	 */
> +	ret = fwnode_property_get_reference_args(dev_fwnode(dev),
> +						 "trigger-sources",
> +						 "#trigger-source-cells",
> +						 0, 0, &args);

Since we have more than one possible trigger-source index, it could be helpful
to create macros or an enum instead of hard-coding 0 here for the index arg.

> +	if (ret) {

This ignores errors other than the property just being missing. Probably better
would be to use device_property_present() first for this check then call
fwnode_property_get_reference_args() later and return any error.

> +		/*
> +		 * In the absence of trigger-sources property, enable self
> +		 * synchronziation via SPI command.

s/synchronziation/synchronization/

> +		 */
> +		st->en_spi_sync = true;
> +		return 0;
> +	}
> +
> +	trigger_type = args.args[0];

This is accessing args.args without checking args.nargs, so could be reading
out of bounds.

Also, we need to inspect args.fwnode first to see what type of trigger it is
since the meaning of the args will depend on the compatible string of
args.fwnode. The "gpio-trigger" has #trigger-source-cells = <0>; so this really
would be reading uninitialized memory.

> +	fwnode = args.fwnode;
> +	if (!fwnode)
> +		return dev_err_probe(dev, -ENOENT,
> +				     "Invalid or missing fwnode in 'trigger-sources'\n");

Is it really possible for this to happen without an error being returned by
fwnode_property_get_reference_args()?

> +
> +	switch (trigger_type) {
> +	case AD7768_TRIGGER_TYPE_GPIO:

As mentioned in the dt-bindings review, this isn't a valid value. We should
just check the compatible string directly.

> +		ret = fwnode_property_read_string(fwnode, "compatible", &value);
> +		if (ret)
> +			goto out_put_node;
> +
> +		if (strcmp("gpio-trigger", value))
> +			goto err_not_supp;

Ideally we would have a trigger subsystem where we could just call a
devm_trigger_source_get_gpio() function instead of this. But that is a bit
beyond the scope of this patch series. :-)

> +
> +		st->gpio_sync_in = fwnode_gpiod_get_index(fwnode, NULL, 0,

Should be devm_fwnode_gpiod_get_index() so that the gpiod is released on driver
removal.

> +							  GPIOD_OUT_LOW,
> +							  "sync-in");
> +		if (IS_ERR(st->gpio_sync_in))
> +			ret = PTR_ERR(st->gpio_sync_in);
> +
> +		goto out_put_node;
> +	case AD7768_TRIGGER_TYPE_DEV:

As mentioned in the dt-bindings review, this isn't a valid value. We can just
check fwnode->dev directly earlier in this function. Then it is only safe
to do trigger_type = args.args[0]; after that. And we should be checking that
trigger_type is SYNC_OUT since that is the only supported self trigger for now.

> +		/* Only self synchronization is supported for now */
> +		if (fwnode->dev == dev) {
> +			st->en_spi_sync = true;
> +			goto out_put_node;
> +		}
> +
> +		goto err_not_supp;
> +	default:
> +		goto err_not_supp;
> +	}
> +
> +err_not_supp:
> +	ret = -EOPNOTSUPP;
> +	dev_err(dev, "Trigger-sources type not supported\n");
> +out_put_node:
> +	fwnode_handle_put(args.fwnode);
> +	return ret;
> +}
> +
>  static int ad7768_setup(struct iio_dev *indio_dev)
>  {
>  	struct ad7768_state *st = iio_priv(indio_dev);
> @@ -699,10 +784,9 @@ static int ad7768_setup(struct iio_dev *indio_dev)
>  			return ret;
>  	}
>  
> -	st->gpio_sync_in = devm_gpiod_get(&st->spi->dev, "adi,sync-in",

I don't see where this function is moved to. If we remove it, wouldn't that
break existing users depending on it? We can't expect everyone to update their
devicetree to the new bindings.

We could change it to devm_gpiod_get_optional() instead and only call
ad7768_set_sync_source() if (!st->gpio_sync_in).

> -					  GPIOD_OUT_LOW);
> -	if (IS_ERR(st->gpio_sync_in))
> -		return PTR_ERR(st->gpio_sync_in);
> +	ret = ad7768_set_sync_source(&st->spi->dev, st);
> +	if (ret)
> +		return ret;
>  
>  	/* Only create a Chip GPIO if flagged for it */
>  	if (device_property_read_bool(&st->spi->dev, "gpio-controller")) {


