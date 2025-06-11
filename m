Return-Path: <linux-iio+bounces-20432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BBFAD585D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE9A1BC4C3D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2702429ACD7;
	Wed, 11 Jun 2025 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zoI1VYSs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E54610A3E
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651384; cv=none; b=milyE2sGvl9zy873V8HJ8s1eQe0+5zlEO+pPnfEhq3JWEUJFdeZtFJGlhtumLfdno6nlESLmcl5tZaFNAjS5oDpELd2GAMcgHd7HIrLQuBRcUerT9yhBs9RoHTrzwruhIG+qNhk9UfhHRXn7bXQeXet4Tfkaa1oQCuopS3dkewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651384; c=relaxed/simple;
	bh=EXJnlVTnNud7vFOMtkEXkO8+20lQ+8pjSYNNNw59vac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1WedgHvNCgy4TQvwTl+V0s8fHVQtd1gX7iTx4tLv9CjklNnHyfIjat5Jzxp+hBvLJNyiFIa6SIPzQuIi118uEjWR5WVUKLxQaWUFVbd2zaL+7DxbeEeOPfen+ydhpTmN1YTFjeCJrRhINng2pd3TveRdeqAeYkNj8a8X6nr0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zoI1VYSs; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6facacf521eso70688416d6.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749651382; x=1750256182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1AY2fjU0MUFNTnTPpkTJ6hjB0BWW24lbL76NZAT2+E=;
        b=zoI1VYSsmvSjd8+yAVQ3jZ92pZu1J5VNKW6LfRuxlpewbrYwTmXabEtc42Wjfn3gj5
         BZOG+coxrrjqKywL3yP88Feuyjr5GUkSZcfEECrHbIdXUa3mqyDP07NbHJPs5qED3Zgc
         Sry/QaTWt5yS/duyYdUI1zF2hLYYbRMRm7wdYGxii2amN1ESzcxGQPO2f863k8VJ79K7
         mLlhIZSARuk51ZtUMmHhCq0Zi4mVgqG1ypFLzR0Fua6fnsyZmITKIirm1ub81+eYz+3G
         1QBIE/dF8Umo++Dy+nd0mVp8izeGEAZxoyKKqgBz8uEKs44XSXvjStXEFgURvJwV8/Hj
         EJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651382; x=1750256182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1AY2fjU0MUFNTnTPpkTJ6hjB0BWW24lbL76NZAT2+E=;
        b=XpnMSxdpURCZ8pbSwOHA5g4PsgVcE6uOXsBs/Z7rJVbjnw18SuyUjcpSPbpTli7t0Z
         0TcvMG85MQSgWUbtlWmC+GiClMSmjvOXG1RM0DhHyuZ8iF/DVm6soTVDn/vzx1S9sbfK
         hfZeEu8oZAHASN9S2v5BxoU8HqyWnv2Tj6f502j/zEhBdr6iEmWedPSq2u1W0OQ5hNsi
         /6W7X0GDCGFoY5BFRykgzfMF0Zzc0CiXo+q/yJLitvbZGCqSOelqUtk/6b1DQiAXyh6n
         GZlQ1N/xAv0ER/XXckJiFKqQMfEwPjbeLyAb5gjkZezD59tmCAF2NmF7Yfd9i+l5Ftjf
         x+rA==
X-Gm-Message-State: AOJu0YzK6PDfR8vWJl+Kfcymitynt0UG45sWWf50rAtTMSP8BafcomzD
	cxVCsYJ82xiOtqYnentFh7x4pWp1UIpP9hdKhmnD6LbaIdU00r/jQIWPpTQtJ52Mb0JLM97QJ6R
	p1z9M
X-Gm-Gg: ASbGncsoAw1hZeZCbXe1VjmybX3V7jMyT/xHFuIuzwYBVhZxJ8fF7a7astX7DCXvgFy
	y0AoriIJ0LlcEKcW6jFM4cVUomB3CLG4vRVZ837OCXV2u+0EWTT9nJxSc2Frmp57RKklFzdl9QY
	9gjl8ZJFVCBc8iqUiHXT+Ua2NBhpjK9k4ym2/Bekrb8fTgeVdkIQm/dMwpWsy9//irT8zD08o8n
	bAqHZDhgasBfDQ27YcE3KHiUIyu5p2KoXTeZqrGXGLNhX1wR3g92TzpmwblKcveqXwTnH7y6aCY
	LfOYVPXoArPNU9x8OCPO5gkwgWVzrKAbgV3EHYjuvn1qkpQ2BCwste4YhYsdlHSWbwo7jZAdQg8
	ewLXDRfw+TspBvVuoaOYrlfOIFlVLCxEE8nWM
X-Google-Smtp-Source: AGHT+IHUfOaV6u8X5qxFKUlC7LB2yebCfftGMi8JimcjPKwM6QWalazzeWJt1jF5l4ISY9kVP+ktuQ==
X-Received: by 2002:a05:6808:3086:b0:403:3814:b2b1 with SMTP id 5614622812f47-40a5d081c0emr2562964b6e.10.1749651368697;
        Wed, 11 Jun 2025 07:16:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:eb6c:30d1:632b:494? ([2600:8803:e7e4:1d00:eb6c:30d1:632b:494])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a5d95e797sm337318b6e.40.2025.06.11.07.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 07:16:08 -0700 (PDT)
Message-ID: <71b66cbb-ab2f-44e3-926f-9ae4bcb3aadc@baylibre.com>
Date: Wed, 11 Jun 2025 09:16:06 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] spi: expand bits_per_word_mask to 64 bits
To: Da Xue <da@libre.computer>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Mark Brown <broonie@kernel.org>, Rui Miguel Silva <rmfrfs@gmail.com>,
 Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, greybus-dev@lists.linaro.org,
 linux-staging@lists.linux.dev
References: <20250611000516.1383268-1-da@libre.computer>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250611000516.1383268-1-da@libre.computer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 7:05 PM, Da Xue wrote:
> Most current controller IP support 64-bit words.
> Update the mask to u64 from u32.
> 
> Signed-off-by: Da Xue <da@libre.computer>
> ---
>  drivers/iio/adc/ad7949.c         | 2 +-
>  drivers/spi/spi-dln2.c           | 2 +-
>  drivers/spi/spi-ingenic.c        | 2 +-
>  drivers/spi/spi-sh-msiof.c       | 2 +-
>  drivers/spi/spi.c                | 4 ++--
>  drivers/staging/greybus/spilib.c | 2 +-
>  include/linux/spi/altera.h       | 2 +-
>  include/linux/spi/spi.h          | 6 +++---
>  8 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index edd0c3a35ab7..469789ffa4a3 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -308,7 +308,7 @@ static void ad7949_disable_reg(void *reg)
>  
>  static int ad7949_spi_probe(struct spi_device *spi)
>  {
> -	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
> +	u64 spi_ctrl_mask = spi->controller->bits_per_word_mask;

I think this driver is incorrectly accessing bits_per_word_mask
directly and should be using spi_is_bpw_supported() instead.

This driver checks for SPI_BPW_MASK(8) at one point but doesn't
take into account that if bits_per_word_mask == 0, then 8 is
implied. spi_is_bpw_supported(), on the other hand, takes this
into account.

>  	struct device *dev = &spi->dev;
>  	const struct ad7949_adc_spec *spec;
>  	struct ad7949_adc_chip *ad7949_adc;

...

> diff --git a/drivers/staging/greybus/spilib.c b/drivers/staging/greybus/spilib.c
> index 24e9c909fa02..087eed1879b1 100644
> --- a/drivers/staging/greybus/spilib.c
> +++ b/drivers/staging/greybus/spilib.c
> @@ -27,7 +27,7 @@ struct gb_spilib {
>  	unsigned int		op_timeout;
>  	u16			mode;
>  	u16			flags;
> -	u32			bits_per_word_mask;
> +	u64			bits_per_word_mask;

This is assigned by:

	spi->bits_per_word_mask = le32_to_cpu(response.bits_per_word_mask);

in gb_spi_get_master_config(), so changing to u64 doesn't have any
effect and should likely be omitted to avoid confusion.

(The response struct is defined by a communication protocol and can't be
changed, otherwise it would break the communications.)

>  	u8			num_chipselect;
>  	u32			min_speed_hz;
>  	u32			max_speed_hz;

