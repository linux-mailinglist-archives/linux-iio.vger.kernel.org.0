Return-Path: <linux-iio+bounces-26225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D73AC5E62E
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 18:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD7784F6379
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F49732693D;
	Fri, 14 Nov 2025 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2DStiBu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F9284689
	for <linux-iio@vger.kernel.org>; Fri, 14 Nov 2025 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763137548; cv=none; b=i/NRTlvcLqr2zjw3K7jiJP2t7hN6E6KbCsfOhaUdP8hDjzNo7Nx+MYWUNBqGKZcEw9oEc8vJlS79DI6diAHWafe20mdXDCDgVX9MeQQmUOmT7wYecVHVt1FWZ+Susxotvqu6Fni9QezGUwD8kYiwWCY7+rNTrrelTylO3MknjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763137548; c=relaxed/simple;
	bh=DmJBwefMZoeCr6KZ8b+qwY+RIqc/g/yjHguKPhXfyfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBv8kF3vZkSHRdqfy3IG1gw8YAuTuB1E7GuC4WnxXDPhWOkQEdE+jMti0CWGzDNQsMjTnI/pUH0OGtISRUx/I4nbMr6f5MeXQc2Qh+RLQfj6G5GkDpcMAnj0RZVq+DO/XdhtPxvVg2c4MXge7h6WwSercjVeFBe000MIwpgGzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2DStiBu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2953ad5517dso25741105ad.0
        for <linux-iio@vger.kernel.org>; Fri, 14 Nov 2025 08:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763137545; x=1763742345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDPYrZ5jC9FU9ONafAxEWetdxuWbNZj9O50TUKzl3xg=;
        b=H2DStiBu0xpXV0vg42Lx8xCl3KdFF0Ws5brOIz2uW4gtoXeERTOGrtXc4jyaS3le8o
         aLdHNJJ7Pj6wAXkT8urpoYsw+e1KpIsP3mIUzhUEtq0QZ59D7VUYYdSZEngRuagBcG+r
         G4Vo6WFjhNVj868VYFmmK7fwsQartDsJAuYiV0B18QGrggQdMLUcb4Tz9DHKhs86Z5hX
         TEDe/faLDLrYzW+BtTlBRCBuYS137F69mKDjHI5GfaTjY36UuxtLbB3ph0KyVTzEjKr9
         QCJUSbu6FmEhrufuZ3B0BBo24mTAIbuDDrCymWLJM3H9ZIpe6BrfoducwNICofa+OkME
         bipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763137545; x=1763742345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDPYrZ5jC9FU9ONafAxEWetdxuWbNZj9O50TUKzl3xg=;
        b=aaSAi42ix5TW4PEoOxxTWLKU+NVXOyWTszqUlTnJgiid+b8Of74YSTN81/99IZcMqZ
         JVCq25USdYGxN0+lbzHgZvMCbIaF+Lo8/zDQLtY6mKnhsF6G4luThQFaOLJ/kCqgwdbz
         co9+GJfIAXHFfT/6MJSAI3LVKt2vxAc4DkTJ+o3OXgntknXS/saVK8rHnmOzbmFXO7JC
         mOw0c3h+khtwsxNj19ysKd4zRO2NulVddaMyzhecCllO+3an/Mdi31bJf/J3gQbPBJ74
         8gzcAT/76ma+uGVDXG0302nHHkeO1ZN4RzGYk0Rmr/QZj5HNLYD4F82j2NKkQSLp/ntq
         NljQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9N57hGVkG97+6S15QAnBVoHTNqQg1Uwsf9AJbKq9yS6F0Ro9OtL/7eTnu/O0IqLnaymaIl6GYBpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydoou8YSJDk+yI/kF/SXGsEvR/YB1pYzVy0upNxD2Ym0yQO6UI
	1bRu5qBuSuBCMty6EKao3diGMXZKjQttc6FR+qKxXfFUbCyK5mQLnVBs
X-Gm-Gg: ASbGnctx5Jat4/tMvrVGhhP0VO7PzCf/+KLAbvBF4w8Opaq3iM3/aGMEJk7kqPdqyJb
	8mkaHrigSOWK+ejtnQqXPYt4dq7LwqoNx3NC+Brq0IWJy/fdAGoboREt5bkanQZG9Yo/sSSyuqE
	tOvyC4mzjsN4gDCZH7Pn6IK/Nc0Os+jtqrJHa/0zdfDaMs4iJtUM3yOMN0+bFU7U9Zg41VhPZkp
	nzBtCTyruawYSKuQU0hbtHBlQJLx5KZzU+EtCAv6SlyvwRtdurKm+vnobpWJV7ocK+5szVousXN
	9IDxLlhlvcSHiZv30E6D/u9xOxr+uMC1YnCmb5sClG8Rt/FwMNMVnWqB1FY5krBO6xPW831lH4n
	c/x/imEnvWsdLsp0iSFgJ1Mj+b8D5NsyIYtsadhT5M2sdzaHrRv2Pfg/BqIL7SVip9TQuKIbECX
	rV+o82dfH6dw==
X-Google-Smtp-Source: AGHT+IEAMJrHxlc2wb2LmODar5xSV/mQiDepjY/vcKYRxsAv+KWjopJ3xQRNP9uvvpTXkNoqfctKLg==
X-Received: by 2002:a05:7023:a82:b0:119:e55a:9c09 with SMTP id a92af1059eb24-11b4120f614mr1056255c88.37.1763137544997;
        Fri, 14 Nov 2025 08:25:44 -0800 (PST)
Received: from localhost ([2804:30c:1661:8a00:578a:911c:ac25:24a6])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11b0608860fsm9538769c88.5.2025.11.14.08.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 08:25:43 -0800 (PST)
Date: Fri, 14 Nov 2025 13:27:04 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] iio: adc: ad7280a: handle spi_setup() errors in probe()
Message-ID: <aRdYWJ1jMT8oLxp8@debian-BULLSEYE-live-builder-AMD64>
References: <20251114151302.2255348-1-Pavel.Zhigulin@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114151302.2255348-1-Pavel.Zhigulin@kaspersky.com>

On 11/14, Pavel Zhigulin wrote:
> The probe() function ignored the return value of spi_setup(), leaving SPI
> configuration failures undetected. If spi_setup() fails, the driver should
> stop initialization and propagate the error to the caller.
> 
> Add proper error handling: check the return value of spi_setup() and return
> it on failure.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 2051f25d2a26 ("iio: adc: New driver for AD7280A Lithium Ion Battery Monitoring System")
> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

As patch suggestion, we could also have
  spi-cpha: true
in ad7280a dt-binding.

Thanks,
Marcelo

> ---
>  drivers/iio/adc/ad7280a.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
> index dda2986ccda0..63fceb239bd8 100644
> --- a/drivers/iio/adc/ad7280a.c
> +++ b/drivers/iio/adc/ad7280a.c
> @@ -1024,7 +1024,9 @@ static int ad7280_probe(struct spi_device *spi)
> 
>  	st->spi->max_speed_hz = AD7280A_MAX_SPI_CLK_HZ;
>  	st->spi->mode = SPI_MODE_1;
> -	spi_setup(st->spi);
> +	ret = spi_setup(st->spi);
> +	if (ret < 0)
> +		return ret;
> 
>  	st->ctrl_lb = FIELD_PREP(AD7280A_CTRL_LB_ACQ_TIME_MSK, st->acquisition_time) |
>  		FIELD_PREP(AD7280A_CTRL_LB_THERMISTOR_MSK, st->thermistor_term_en);
> --
> 2.43.0
> 
> 

