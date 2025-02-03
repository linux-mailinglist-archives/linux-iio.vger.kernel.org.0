Return-Path: <linux-iio+bounces-14924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57572A25B3D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 14:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C031883749
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652C8205AA7;
	Mon,  3 Feb 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8RTg75h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA691D5176;
	Mon,  3 Feb 2025 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590380; cv=none; b=qPZ3Cdrm6JAmUTfzzEuy5tagls7qMaw0+Yk43rHmkaCNtlnv4G6MGdwi0ktHW0pZY9f1pG3Ow+Vab7YuHCk6z1Tc+VBmHPBW9BresuUGdexFIfdfJT229PdbbW3SALp7lKQSNiWNbi9F0lkjKw0yLJJBcoBOn1gYEoeEktYhPPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590380; c=relaxed/simple;
	bh=yRjrClPp2Y8t2oce11v42+iDROF1lGwF9ONkK5huTd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9ov4UoH+gyibJ3wYPBPP/G+E54gV1VdQB9/Qbzayh1cUHS8rgUEB7nK0QAYPgEQKUJs3CMQ+wck6DLX5QpwME+YJJKDkhlD+rnqZNQsa0d5ozOpyfVDuwYesyAC++jiGJCjoFcLan8L5swQX/G7IyXzaBjmamJgUbOYI3rNexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8RTg75h; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216281bc30fso6712305ad.0;
        Mon, 03 Feb 2025 05:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738590375; x=1739195175; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I/ATTF8zsbMuGG2i0AfdxDB1dr4BRw0eSCC+NReTqNk=;
        b=D8RTg75huQBB2he3MUoBz0mE+L+kFKZhvjV43Q5fsHNYgt+ZjOqAHKmoxMWNGTpFAf
         mVwEdovhhzPaCi2UrhhxUKEIfpuMP7NvHdvruFgBq9NNEUz71cELm+oo12X8F+KXtjWr
         dFqB2prkGp5SGCKDzuvr8nRrFU67oRo9DEY1oNLxN3RAK3j0Fl2uRgjyTW1xQ0hlGkpQ
         VR20MqvxRA54CJ0Mpm/6oeFvu07F4UMh6iY47iXivwkPRSkGUDfOmItPtMAfm2f0FXA6
         Qn1aWj3z8r9HPSkit9jeYm1eacG+9fhLQm0j5Xz1FnMpmkDcYd1yjO0pwleCjHbxm9c8
         /G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738590375; x=1739195175;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/ATTF8zsbMuGG2i0AfdxDB1dr4BRw0eSCC+NReTqNk=;
        b=dvR1LGv90s5lwyzmlPFtydaV/3/mAiX+lLsGpgo24ihE0utlRhhFxMTenRcSRXdHJ4
         Ar3QZ8KoAcYU81DhjcJYc9YIWoZu+/elkgSE+pRofItYqueqVXH7j5YRZwrTeLo+ZFNp
         YzyO9FZ3v3pk6nU8lMWLL/Ze+2d13tQI/5tFaEG4d80ZVobvTqsDWZYOrzRCa2/c5oDI
         m2TSSYeFaeLWETt0ASI0PQoVOUBdy+VdkJF7sOCyrmkUQ+gEv/5GZY0/dileW1jl+e/X
         6lkbqgjWzEKKQlk8E3sAgI44Cg9of7BpDIwGLHZWZIOt6cYTSCBeOTVdsXjIz3nXogt3
         RNKw==
X-Forwarded-Encrypted: i=1; AJvYcCUb24AQQgQBHMFBLkUH9bwvbkmLIcGMNPG9x3QY4IO/GRW4ekPtk1SWvjZ7A7DJ6s9A892V98wcSG0q@vger.kernel.org, AJvYcCXx2rnKiTcbIXn5Pi57SQxM0a8fjGHWm8g/Rk0YQcou4Xn8lNjuyq2yErtyFX1Zb1t7UehsAjuWNvmzA5JV@vger.kernel.org
X-Gm-Message-State: AOJu0YyEDDECcyXJeOcdMwsfvpAIti509ahKfOpWizKjTptNBAXyo0Ck
	4vnXJ2q86JhZE0QE6XFPAs+x5CLn416W098lqHv/ehsMOMwERrvTERav5VSz
X-Gm-Gg: ASbGncuWW6sx2QkRxLnvuW1b1CuR+0qjH0BjlJ3DVRXvqdZrJr+EyC22LO7Remeu3Iw
	EFdemZgBM+odqPllEjtPw/us21bCttUPAKASNnJOcBFUKU+HD5XAHKlDWBCLe/mmSiY/tIjNjEf
	40mldGBmYqHXiKO4fdJd8oQ6KBjcuY6CxfQSIlFgihZ7CHVZYB7CjoJu79NoEwPsNJdiojCLg9m
	5DcpA/nZEq8gxDi6mxVgjJ6Mw22RPXgfanoRVmRYhRMkuPMdNBkLIqygbeipirTAFWI2TxgI6s3
	Jt1XlJnjWP/omR8Th4JFF9SxbA==
X-Google-Smtp-Source: AGHT+IEtE5h1/69abVRfO3Y5Rwh6qpPD2rb2iCTavBPfOdeI5wLdc63YNsthxfNn1hA3WoY4KYmcag==
X-Received: by 2002:a05:6a00:a88e:b0:725:e057:c3dd with SMTP id d2e1a72fcca58-72fd0c98729mr33207627b3a.22.1738590374831;
        Mon, 03 Feb 2025 05:46:14 -0800 (PST)
Received: from localhost ([2804:30c:273d:6d00:d9cf:ba3b:291b:37ce])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ceb1csm8253776b3a.151.2025.02.03.05.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 05:46:14 -0800 (PST)
Date: Mon, 3 Feb 2025 10:46:57 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jonath4nns@gmail.com
Subject: Re: [PATCH v2 08/16] iio: adc: ad7768-1: Add reset gpio
Message-ID: <Z6DI0Wo0sEY-yqvh@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <722340b0efff3ed22a763ce6581c96ca403316d8.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <722340b0efff3ed22a763ce6581c96ca403316d8.1737985435.git.Jonathan.Santos@analog.com>

On 01/27, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> Depending on the controller, the default state of a gpio can vary. This
> change excludes the probability that the dafult state of the ADC reset
> gpio will be HIGH if it will be passed as reference in the devicetree.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---
> v2 Changes:
> * Replaced usleep_range() for fsleep() and gpiod_direction_output() for 
>   gpiod_set_value_cansleep().
> * Reset via SPI register is performed if the Reset GPIO is not defined. 
> ---
LGTM.
Aside from including your the SoB, one minor thing about reset timings.
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

>  drivers/iio/adc/ad7768-1.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index fb8d6fae5f8a..17a49bf74637 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -163,6 +163,7 @@ struct ad7768_state {
>  	struct completion completion;
>  	struct iio_trigger *trig;
>  	struct gpio_desc *gpio_sync_in;
> +	struct gpio_desc *gpio_reset;
>  	const char *labels[ARRAY_SIZE(ad7768_channels)];
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
> @@ -453,19 +454,30 @@ static int ad7768_setup(struct ad7768_state *st)
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
> +		fsleep(10);
Is 10 us enough time here? AD7768-1 datasheet page 58 sais
"The time taken from RESET to an SPI write must be at least 200 μs."

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

