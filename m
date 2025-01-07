Return-Path: <linux-iio+bounces-14012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57513A04DDA
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 00:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD52164D76
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 23:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9E71F63D4;
	Tue,  7 Jan 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qYRv5iz5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2D1E9B01
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293834; cv=none; b=VmfwudDZFAPS1tegygRenoXieWWHAOJ4DfCI/k88gABTkpPd/pHa022AEmt42bplEcowDbbG6gesqG9WC/Zk2u4S1mYZpOkHBtcx764Q70A7iN0O5i0AbplrfLVePTN42Y6ZqemEWIrqrJ4J2wE7liOv296G0phk0F4lVwQtCfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293834; c=relaxed/simple;
	bh=XfPvlCPGM6v+rwnBGl4dOBG7B5R6Eye3/uGl5/TBzoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkPkVQ5+Sq+bqlw4oXA86lFWQY7YYV0OW49q+iWaNLdUV9KMEmVPuk5FkncZ5rYklSTJKC3QuU4e+galQAUbpb4HJe9Kph2TwlEE+hbt2LW3pn9aZ8ei8gVsVY3vP8ypZLpGhOh8SmzddCQdW3P+d+x8MBZTTIPTYewX+FFXMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qYRv5iz5; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5f2d5b3c094so3233101eaf.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 15:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736293832; x=1736898632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOh6SgpD0fnoQUo4jBTRWWnnORTvD4Gd2yKfcHr0wjI=;
        b=qYRv5iz5uMYu87LBXB6oD37vMQoDpkJTq0+/2tKEaTvPs8LBJy7n08rXSXOhy2E31e
         rNFvBqBB1RXYrIrezLaPEYdt3mdFY7konUkXvEl1Bg7GUtTWnj0l3/doKhU3I5YLoIxf
         ZGDgxk4RMBE1t+7tpio7IXb5B82thM/+bTEXz2VoOlDKleldrHrI9h9FYIPeHzIWQ+bn
         iZpMWO3JuasnB2YNkZWYvCvUIvoDzZYRRnkWD3H+zQmCCoedadgLywGgQVZNdempLxRV
         D2RLZQKwW/fjaK5ghkNLtuGfag5pHVuk3mV8PTFM313bj00cxo816cJ46dSMv+XvaRod
         hEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736293832; x=1736898632;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOh6SgpD0fnoQUo4jBTRWWnnORTvD4Gd2yKfcHr0wjI=;
        b=YnqYi44OmuAbp13WpT1V3j1frb2N5TE/PnjU6cKs1Kbht/Q3liwPb+MtxG27R/AnMv
         m3keeN/T2k1ILQQr7P7YgLQmj+JE5wXFOU+9UG+JJRmCcy4zVkAFuj6M6DMmf/+NA0hl
         o750K3WmMeD3MpOsokSQbjJxTqWx0bFmT4SZpm1fY3dk3iIELWbzvEBOcgfrIZxtovwb
         c7gR9X6U9UHUTlgDfDFLsVdLF7mqPzmASfnWpGQ73Ej9j2SZnSJOeVC4k95oU0eFELPH
         D5CXPprsu8fUliPe774BbTY5iF3BqRliub5pp6W+wKUblxmkJUa07yBzN4BTEYCobG6C
         hmNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5EWIL2jGXWaINkyUi03d+x3Ik72L+ZJU2djU7LiV15aOJUjJvGqilRbvPxpXb4Ius4q7s115RHwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKT04wWc4ZZpBxdQlIwET8/8Ltk7iiyOH3+VC2+7aecEtqVprd
	eCjh7Wji8i46dWrmFqkKO49kUYFgdT5GZ0heLsbxNE2Zni9EzrAQ/Fn+JKRcWNs3Ons/oqQxkDF
	N
X-Gm-Gg: ASbGncsGQz2Prrx5pInNHyZ954MG1wbJ9wzlxUMRh8gNAoZUc9ogsa6DhPbId8V/CwM
	zIRVSpI+y2o8H5veRW7y3ViwGiKmYWd9qrvIUmUp6upA5aMshwoLsxgA7d5v2C9AIqowRhUPTQH
	AwBNZIGZSy/G77kCzB8J11dAVhVsRN+u/cpYIj9e5fAzrOziwhfDlnyj29IIAJUC8oLKw60WgxI
	1Zqvhu2RPrEzs7m83rx0Wzm7ceO3+VxAuKxW5eGjB4QBXnDn+r/83Dhqnw34A3K8VKMjZ6x8xxo
	ZGUaQ/bSARqSW/x5BA==
X-Google-Smtp-Source: AGHT+IEV5Fz0MfSNQ/uGaWWpS3qlhYqNZZWNPwgurnfrwPJX5zzf/vl5vBDqy23+j/EAHi9NAHKtgg==
X-Received: by 2002:a05:6820:543:b0:5f6:c2a3:a146 with SMTP id 006d021491bc7-5f7308c08bemr286228eaf.1.1736293831925;
        Tue, 07 Jan 2025 15:50:31 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc976635dsm10819604a34.9.2025.01.07.15.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:50:30 -0800 (PST)
Message-ID: <c0981545-5e0e-4b6e-93d9-cb2871b583e8@baylibre.com>
Date: Tue, 7 Jan 2025 17:50:29 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/15] iio: adc: ad7768-1: add support for
 Synchronization over SPI
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <0f9a15e6e2e6b7b2c82ef79d8cb883d9eb6c55dd.1736201898.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <0f9a15e6e2e6b7b2c82ef79d8cb883d9eb6c55dd.1736201898.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 9:27 AM, Jonathan Santos wrote:
> The synchronization method using GPIO requires the generated pulse to be
> truly synchronous with the base MCLK signal. When it is not possible to
> do that in hardware, the datasheet recommends using synchronization over
> SPI, where the generated pulse is already synchronous with MCLK. This
> requires the SYNC_OUT pin to be connected to SYNC_IN pin.
> 
> Add the option to handle device synchronization over SPI.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

...

>  static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
> @@ -697,11 +708,21 @@ static int ad7768_setup(struct ad7768_state *st)
>  	if (ret)
>  		return ret;
>  
> -	st->gpio_sync_in = devm_gpiod_get(&st->spi->dev, "adi,sync-in",
> -					  GPIOD_OUT_LOW);
> +	st->gpio_sync_in = devm_gpiod_get_optional(&st->spi->dev, "adi,sync-in",
> +						   GPIOD_OUT_LOW);
>  	if (IS_ERR(st->gpio_sync_in))
>  		return PTR_ERR(st->gpio_sync_in);
>  
> +	if (device_property_present(&st->spi->dev, "adi,sync-in-spi"))
> +		st->en_spi_sync = true;
> +
> +	/*
> +	 * GPIO and SPI Synchronization are mutually exclusive.
> +	 * Return error if both are enabled

Should it also be an error if we have neither? Otherwise it sounds like
decimation won't work correctly since there is a comment that says we have
to toggle this after updating the decimation rate register.

> +	 */
> +	if (st->gpio_sync_in && st->en_spi_sync)
> +		return -EINVAL;

A dev_err_probe() message would be helpful here when creating a new DT and
bringing up a new system since it is easy to forget a property or make a typo
that could lead to this error.

> +
>  	ret = ad7768_gpio_init(st);
>  	if (ret < 0)
>  		return ret;


