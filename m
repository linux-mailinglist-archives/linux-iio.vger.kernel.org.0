Return-Path: <linux-iio+bounces-21862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73C2B0D5DA
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 11:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E449C6C1B30
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 09:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB562DE1E6;
	Tue, 22 Jul 2025 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuTV563L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6574323AE84;
	Tue, 22 Jul 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176196; cv=none; b=VnZDfNmIQe1XdO0oYKxplDbceeFZL7FykEnIwAbWpsD9bzNPKkRtMgeiJDasrkOE4dkl6LiaD42a5ZsMiRnRWkgbbr/pnw/wWbeYwQ2QqslO6jNDQH2E5sADXNwS0eCZgTkHS2bLS7fgCU4t+p3CryxJ3vTuL/05MFt/4oZgvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176196; c=relaxed/simple;
	bh=ZwKkSsRNiK4vw3joNNnkDFtMauOnJ34010/H72gzG/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK0nIVo61AQnoThfrYvSH8FBr5LrTHOS2kTSlCDWQdhXEZJmolOqyNI0ITfFmuFlvIxw+2z42kaSCmY8xpr/mwPRf7bDuuAuxwDIqBFMZS8RWNj6k/pxrNLU8fs1qp7HO/KtQOM633tRMLjOOAKMtsV3AOWJo4mGUtcPUE0sbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuTV563L; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4561ca74829so57809445e9.0;
        Tue, 22 Jul 2025 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753176190; x=1753780990; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1+4woj2blIMxZESntw7ogJ3WkdZPq4l3eTQIyRBKHxg=;
        b=RuTV563L7F1JVeoIyYkr8+ShImVfHwHUksLHgjX1dDfGJqkuKYqD8gu3/bT+6buZku
         gAqbSjh944PakCPhFo75Tq2En7Ej7PC3cmTTtidAtq0fWztEVJCQ8tOX7QhfBSksqCRf
         0S5u24zVOmuuBT2nmyGNcBF0x0OGlshQc9A3v+h+4SCbSaoIevm93I8aMYWBKnxv6PNZ
         DrJliISpCvVO/YDItwT18M7Zmx6yN9hTEAin9XctFSFJdUUHcICUJcLdchoJiS8C5cg4
         f8EB38FgS2sI85hy0AmPW27+TpNLFeffNLj39SPQkdh1hnIYQ8EDvjqYS28cNw9G7N8t
         IHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753176190; x=1753780990;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+4woj2blIMxZESntw7ogJ3WkdZPq4l3eTQIyRBKHxg=;
        b=N2vPlngSkTVyGyxxO9Y+XV7hMEWdVnSsG+iIJmzQGIPvSJvlycpDp8ksZh8xoe8YpA
         4Xd3awv0Lye2cn0f2K+4TPM+tvLsm52J5KoDn8yWUdAtuctfjvv7qIVjPZGb5MLaY+9S
         nkMTHM54EO3WcN/eVEZVD674fIHg08iQBRO0mY9XQsp7L83yyeOMST1SEHJw3uIZzyM5
         5c2xB8aI+/mxTPj2asrYsYsmejlSuJYq9INy2/b56XxdMqFeLY99KZLsUl7kxVjPt/2Z
         NEmFY5hLk0rcY9lUSJ0hVD6ZkQ5PR1GXl2jFniYPB7LhgJ0zgcGenYIA9OKXolqLR7mf
         3Glw==
X-Forwarded-Encrypted: i=1; AJvYcCUhIl7xaE8Gu7fG3wqVNZitSCAs/2mQ5GdScIS7KJOsOOKKSwjlAvVnSAm4KPdipP5F7sAOhNGC2QzeVonM@vger.kernel.org, AJvYcCXCZPtV7HK/bY1hFwBbyM8xNA3Hzn77+JlTiMTBA2F4BsdssyRkdZbnEOYEn8muUo2xi0I/KksX02g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ISvNfsbDRygUcHWXQMCzJdLjsRqeRFdbJD47zeiJpGYfz6JP
	P//9zcum/cjSjMpzSxvjw19ttWWvU7MKFNJmYd7bmu4XNsqO+n2aJRle
X-Gm-Gg: ASbGncsQYYkf1cdttHjRHmdwdHIKHjU4yrNILMZ9qvOBQpnXjiQYVZSMropAlwQgiDR
	5R67SIwmsd8JdFy+aOXWKXhC+9ARQSf4sIjM4o6q49RYESNmIdfl3IYBh6ZWGdPgpjTcXJ3BWxj
	HmAJ4t+Wm3s2OWySWB/N0nevjplVt8TIYwx2WmzcEcQj896S9B+0luVl86jQ0ry7GKFBxyyK41H
	qPSEdNDYSKaDbDKbxx83qEg0ZKfecATQ9XnqSf1tIaO3GIvYiIi7egesOKq/6G5asedMzY9p0rQ
	ohagApYOSYokxDWeWUcKfIq9hQLmlVR3cF0JyAbwObQnDGX5tne38mjnqk2L6/jK+Bn9QAcoMii
	mDYJe/ieKuA==
X-Google-Smtp-Source: AGHT+IHVWrEROMcnqT4miDnQ7GxbEIR5JrMq3IhppJY/3sv/iFGHOzAOkTsX1+81XKwkX2SaNmarNA==
X-Received: by 2002:a05:600c:5298:b0:456:15c7:ce90 with SMTP id 5b1f17b1804b1-4562e38a72fmr234178475e9.12.1753176189335;
        Tue, 22 Jul 2025 02:23:09 -0700 (PDT)
Received: from nsa ([89.40.212.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d732sm12803311f8f.61.2025.07.22.02.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:23:09 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:23:22 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: maxim_thermocouple: use DMA-safe
 buffer for spi_read()
Message-ID: <tazq2tbbg3trlhrpcozznyaa3yujqijdxrurjruuvbzrjaah7i@nupdjs7vi4qp>
References: <20250721-iio-use-more-iio_declare_buffer_with_ts-3-v2-1-0c68d41ccf6c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721-iio-use-more-iio_declare_buffer_with_ts-3-v2-1-0c68d41ccf6c@baylibre.com>

On Mon, Jul 21, 2025 at 06:04:04PM -0500, David Lechner wrote:
> Replace using stack-allocated buffers with a DMA-safe buffer for use
> with spi_read(). This allows the driver to be safely used with
> DMA-enabled SPI controllers.
> 
> The buffer array is also converted to a struct with a union to make the
> usage of the memory in the buffer more clear and ensure proper alignment.
> 
> Fixes: 1f25ca11d84a ("iio: temperature: add support for Maxim thermocouple chips")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - This is a new patch since when looking at it again, I noticed a bug
>   with passing stack-allocated memory to spi_read(). So now the primary
>   purpose is a fix and converting the array to a struct comes free with
>   it.
> - Link to v1: https://lore.kernel.org/r/20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/temperature/maxim_thermocouple.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> index cae8e84821d7fd521d59432580d51def939fa4d1..fa648a6542a4e2f08adb556c776b68331ae69631 100644
> --- a/drivers/iio/temperature/maxim_thermocouple.c
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/err.h>
>  #include <linux/spi/spi.h>
> +#include <linux/types.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger.h>
> @@ -121,8 +122,15 @@ struct maxim_thermocouple_data {
>  	struct spi_device *spi;
>  	const struct maxim_thermocouple_chip *chip;
>  	char tc_type;
> -
> -	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
> +	/* Buffer for reading up to 2 hardware channels. */
> +	struct {
> +		union {
> +			__be16 raw16;
> +			__be32 raw32;
> +			__be16 raw[2];
> +		};
> +		aligned_s64 timestamp;
> +	} buffer __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
> @@ -130,18 +138,16 @@ static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
>  {
>  	unsigned int storage_bytes = data->chip->read_size;
>  	unsigned int shift = chan->scan_type.shift + (chan->address * 8);
> -	__be16 buf16;
> -	__be32 buf32;
>  	int ret;
>  
>  	switch (storage_bytes) {
>  	case 2:
> -		ret = spi_read(data->spi, (void *)&buf16, storage_bytes);
> -		*val = be16_to_cpu(buf16);
> +		ret = spi_read(data->spi, &data->buffer.raw16, storage_bytes);
> +		*val = be16_to_cpu(data->buffer.raw16);
>  		break;
>  	case 4:
> -		ret = spi_read(data->spi, (void *)&buf32, storage_bytes);
> -		*val = be32_to_cpu(buf32);
> +		ret = spi_read(data->spi, &data->buffer.raw32, storage_bytes);
> +		*val = be32_to_cpu(data->buffer.raw32);
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -166,9 +172,9 @@ static irqreturn_t maxim_thermocouple_trigger_handler(int irq, void *private)
>  	struct maxim_thermocouple_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = spi_read(data->spi, data->buffer, data->chip->read_size);
> +	ret = spi_read(data->spi, &data->buffer.raw, data->chip->read_size);
>  	if (!ret) {
> -		iio_push_to_buffers_with_ts(indio_dev, data->buffer,
> +		iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
>  					    sizeof(data->buffer),
>  					    iio_get_time_ns(indio_dev));
>  	}
> 
> ---
> base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
> change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-3-2cc387a66bdc
> 
> Best regards,
> -- 
> David Lechner <dlechner@baylibre.com>
> 

