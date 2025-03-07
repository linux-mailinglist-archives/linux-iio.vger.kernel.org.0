Return-Path: <linux-iio+bounces-16516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36462A56778
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 13:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB64174002
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 12:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159EF218587;
	Fri,  7 Mar 2025 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWBY/ML3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A8E192D7C;
	Fri,  7 Mar 2025 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741349159; cv=none; b=cARSpt1IiFqAe7H26CmkyL0pIV/WaqKFvMyG41EZTqsKTOo4ARhN5UBbC30KLXV2CrRifwQe+FUOCTjCEFAbAn5eXI4RO+5mGGneJ00JXJ17ouVxctEFhun//3b1GJxgHbh+5R9rq19uOOwu1UmZ8mrhVLLFPM5e4QDmfPk0si4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741349159; c=relaxed/simple;
	bh=o4JarWW/MUbOyvdB3aVz3LV8uhCJAFPqTqIujRLiLC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1YvTuYu5Y0xrBeBs5H2sLl5R+nVy4scASkRObaU1BOVv6X4TZyuLvQ6pNHUFfqm6a4JjeMaUrljZN6LEK1tkNe3kIKr2Xk70lRrfejdxDwOnB5Hq7HpAU4hmcucJkXo/q0eW8inKmvnPNANUj2JPedsYDKdmQrczxaehpsIOZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWBY/ML3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223378e2b0dso25140085ad.0;
        Fri, 07 Mar 2025 04:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741349158; x=1741953958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FrmrTRS8Hu1HqQv6SIP179ZqkMWR94/wJgTSiRfF+20=;
        b=KWBY/ML3bQ7fPg21g9eTzxC99gwQqWj1LcrJT37P+NZ5dLHI3QgMFu9eAZjay8g667
         8RIGzXetIJXQAiWr9sNvf+ZpgF1ngY0wptPFtcSD5sst506F/gVLTJNdIAIb2U0ja8YZ
         h+VjE7kigrBADkE0xvzg+5YieLTJCTASjFIplFCu28UHSCzHZMD3JOnoQJ0F8Up24do1
         UWtf/7QonXiCxzSVDKFftnZBa9EswBaCC45YV8pZwvcf5yta2KEwDLD1WKH58f5tShE+
         OJdQm8Qiov0YOwkP1HAoS68QwPwg8f7pQol5N5Ar9OsUcS8W9L+y0UTRX4RezIxmI7yL
         h+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741349158; x=1741953958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrmrTRS8Hu1HqQv6SIP179ZqkMWR94/wJgTSiRfF+20=;
        b=nB6wG9ue00eQQ0oj6BwkpbOgHo8RGzxK5xKh18tq//zTjmJEc2B2wgSgFm2259e39l
         kcXs35pCVpTJcKi6eZwVZXW7hv40lHms8RlmpO5yhtefy66h+GzSCIH3obbGyrXX4QNA
         lH4bAM/FY3L+pQrJbdxRjKsqoRFUze3mO46wM9BJaNa0XNhM0tlGPWjsQBAzucwjH+AC
         nrCvWXsltUu3Qiro3spUkiJK9VOHlKU/csVhD/U+TJ9wy05DZqmPCI+2L4pXL8I9JnGO
         Dvn/MTvdzN9Jq+pwJSHomNRrb+OyLVVXRnq59VSnSRIiuUOhgQ4TtmSt5UX6D8ivPUMx
         c/HA==
X-Forwarded-Encrypted: i=1; AJvYcCUMoGeei4fHIq5FYjCockWTEzIPnlkort4ayS2ittgm4SuV9tdulgfxLkYec6aK1gd45n9vk/JAEUNR@vger.kernel.org, AJvYcCUOCgm6WsZFLxd7YvC67YxDtcBnk7UpktFGWGnCyrSZfozOAz6QvMX4PsABCSjAwn4qS0OMy26brgpKiYPU@vger.kernel.org, AJvYcCX2RjEk0hnuQYt8anG2kR/g1c+RqjLiTtM7k5RJ4PlQqkBaLiTo3Dc+CiH5leTiTqu1HQ9LLygt+YRMVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9YruFjzYYPxYNC/edOUXumI83wV/6dHflDf02VpkhVZZ8SHPu
	82cMdb75zhUKnrJOaocMEZzn8VjF0TkLUoNR2N9pXNPMX5W7x1s2
X-Gm-Gg: ASbGncuaWSToyrxHEaZ8Ikvay3kh3ZY4k0lUIu3x1h6JctDVXauTfcz9wvUaPEasIGE
	Kl/Ichtt9aJhMgka3ck4hmHwAsDjXs9JtW93qoAuu/FZ0rfz0FZMeKW11zlWOeqXfICu+nBChrI
	l+tC/uENb+0fy11z/itjObDy2kSnMbmLd91105BmotHzTAJr0H9CXwVXwvyAMkEhB9vC2r4LWlm
	X6b/YdYnnnIqDh7xHHOVqo83/h8yLcAYAhmQESs/p3NbYpEJRcQXS3RO3JMsh10RJPGB5XrrN/d
	hpzs/JAeYiBsVN4Mn2bME4cnSbxq/kdT5xWSeIe7v3OgU+VBUQh1Wg==
X-Google-Smtp-Source: AGHT+IH7hW6CQv7KXxiwAEKf27FKpfxNgGTgX9XMOGE2DCZirz393uzNz0ltsUEj3zWjPg31mHD2yQ==
X-Received: by 2002:a17:903:22cc:b0:224:76f:9e59 with SMTP id d9443c01a7336-22428886833mr53916435ad.10.1741349157554;
        Fri, 07 Mar 2025 04:05:57 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109e944csm28368535ad.74.2025.03.07.04.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 04:05:56 -0800 (PST)
Date: Fri, 7 Mar 2025 09:06:48 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, lgirdwood@gmail.com, broonie@kernel.org,
	dlechner@baylibre.com, jonath4nns@gmail.com
Subject: Re: [PATCH v4 02/17] iio: adc: ad7768-1: set MOSI idle state to
 prevent accidental reset
Message-ID: <Z8rhWLz32fdySDyN@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <c2a2b0f3d54829079763a5511359a1fa80516cfb.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2a2b0f3d54829079763a5511359a1fa80516cfb.1741268122.git.Jonathan.Santos@analog.com>

On 03/06, Jonathan Santos wrote:
> Datasheet recommends Setting the MOSI idle state to high in order to
> prevent accidental reset of the device when SCLK is free running.
> This happens when the controller clocks out a 1 followed by 63 zeros
> while the CS is held low.
> 
> Check if SPI controller supports SPI_MOSI_IDLE_HIGH flag and set it.
> 
> Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

LGTM

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

> v4 Changes:
> * None.
> 
> v3 Changes:
> * Patch moved closer to the start of the patch set.
> 
> v2 Changes:
> * Only setup SPI_MOSI_IDLE_HIGH flag if the controller supports it, otherwise the driver
>   continues the same. I realized that using bits_per_word does not avoid the problem that
>   MOSI idle state is trying to solve. If the controller drives the MOSI low between bytes
>   during a transfer, nothing happens.

When you say nothing happens if the controller drives MOSI low between data
bytes you mean the data is still good in that case? Just trying to understand
the device behavior.

Thanks,
Marcelo

> ---
>  drivers/iio/adc/ad7768-1.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index c3cf04311c40..2e2d50ccb744 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -574,6 +574,21 @@ static int ad7768_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> +	/*
> +	 * Datasheet recommends SDI line to be kept high when data is not being
> +	 * clocked out of the controller and the spi clock is free running,
> +	 * to prevent accidental reset.
> +	 * Since many controllers do not support the SPI_MOSI_IDLE_HIGH flag
> +	 * yet, only request the MOSI idle state to enable if the controller
> +	 * supports it.
> +	 */
> +	if (spi->controller->mode_bits & SPI_MOSI_IDLE_HIGH) {
> +		spi->mode |= SPI_MOSI_IDLE_HIGH;
> +		ret = spi_setup(spi);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	st->spi = spi;
>  
>  	st->vref = devm_regulator_get(&spi->dev, "vref");
> -- 
> 2.34.1
> 

