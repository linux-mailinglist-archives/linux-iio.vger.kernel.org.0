Return-Path: <linux-iio+bounces-16714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC00CA5A66D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 22:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF733AD141
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D447E1E1A33;
	Mon, 10 Mar 2025 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IBAjriiO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E11D514E
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643365; cv=none; b=u5Xdk7QdYu2xV8/wdSXdgZqiNAqJpwBdI5jjSWtL6c7GnR0xUgHTs49KH5P/K7B63bIJOMK/20ah6WX2iMyWX9EJ4VfJj+KdAibLjvwFnsnY0l86xGxGZk7dg0jXmspFmzHzx1/TWMIVtVn2He/UjaroXj4qA90mR1Z3PPo5MLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643365; c=relaxed/simple;
	bh=iHObBAeGFYFRevR3jGHYOgksNiNP8aHP4FWXBdttAj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7I69K4L10Tvi/GMr6czFN/VmDbeMc7HEGn2x/jqYlHtON713Au97Bngpp/FaNgtA+ID7rehsbpErAgDbqDiPUBNjoWDVqBeDJSVM0h9fo3ghNKOMDM+S+VlbCYa57jrTB6gjXIMjMiZfiNYJlK2ci3lUqrbTcUP///09wxjKmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IBAjriiO; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f9eeca67c5so213571b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 14:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741643361; x=1742248161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXKoM7IHCNnDL4bGGgo6X4RmiFQAWr4zM9r6iJDxnDs=;
        b=IBAjriiO6emdA1KNoGMHhNRvAWTfW+Og9+NDix2U7s0c2E95KKfkTUmxXb3nLn4YjF
         HIAO1byD8XWc9z97fUnaNIkKtTC9gqsPcvsgTLNoovZdF/h5/kFfsVcGfAgsrdzaByQg
         Nw16G9piD6EWGhht6GpSHvKwFJY7WhVawVPpjlaSLGyeQrxkkL2yz62mOygs4inLVexI
         OQCQFudHYHFmV+p5R+L8CkPidtSGFUSt0aomHYXL7xKIcY90tKOmmgLh2JhdmBAqdsVF
         qZhnXcAyeILhuU0RNjHuW3oALHOf8lvuBXTyxjJFA+K24J0Fc/hObJdTMbwEE4kmiyEi
         hBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741643361; x=1742248161;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXKoM7IHCNnDL4bGGgo6X4RmiFQAWr4zM9r6iJDxnDs=;
        b=SuEba8p09CfzJSmyUfhMbrjV8l4wL/qmR38xGjfZg863eTVHymFa2wZdvvH/XC5YJC
         wvWPN53yvVYIhaSfsdX0Un+kmRzvGsXKBXkXkiS4B6EOCORD7MZf3fDMNHvfDkDppV16
         6xGsVIxHsCoZBCP7uh+dkQfNw+lSzT0anqauprQiZr7gPRe+7Tjmbgoue6KTd/f2qkt6
         p6a2TsAnorVCkJLkeQvzS3qjHsRT4Qs4n9wVbbeR1KBt4RT1wz9gB8ul0nuwuHWFvWUr
         a9zB1RPOZIPpSTklNnURZnAohf3fKKNaciCHJ8HMy2SZeSSxACNq98xJRaVRmd76Zhc5
         2l3w==
X-Forwarded-Encrypted: i=1; AJvYcCWzlAPc56JZg2s7fqDiexfeLyrjOYw0EQIWp6DfeXXc0Q8Wa7+VhV0UL3ntvDMd3c96eX4CPv+6Odk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWdwax613AY3PqNtiRXeRuNCdQZ8huiPfPuhk2KGikgRYBY8x
	w7DooFZ/M+xFlmyP6H/shLfLj/tWMG9An78dL3/H4OyBnCZa//ityny/T+3YHvlsE6n5AwvUW7a
	Xan4=
X-Gm-Gg: ASbGncuxAEJmIPJF4x3UxKORCcW6pUPvF1TYtKS7ggCVANuE+sesIcJfvrotEg0eNvu
	v09qjSDCH/l0Ej/JjKAFUK33u/GH6Yl01AmTyoF0OFF9LxamNqLTACi70B1eh5VaLq4s3i2uJDG
	Nou4E9CbrMiBQadJtcoRzu9P4Hx0uzdU/YPRwgC8B/A2DniCel5AaQTfHTCAk6ZZUYQesIdacwA
	DOZ2lLI4/gdt3n31xmDCQ4Abc/q3N9hrqhmPUfWMcjhcDGr3iKyFHDUIHTN5fwOR5c+reBviflK
	94RqRuE3+VKqhlcJ9OUtn/sRzNCVU4QmIZqk2ki3jVcyUFtr5aRDpmlJJuexHDsTmH/bBB8uPOs
	QWegsRw==
X-Google-Smtp-Source: AGHT+IEZqMDNKyibgwe+LV2qA4U3yAPty+EVPgdACxQY+vRGOKo+CxT7w1II0LUEJ1d6RJssX/i8Lg==
X-Received: by 2002:a05:6808:6507:b0:3f8:d6c8:9545 with SMTP id 5614622812f47-3f8d6c897dfmr3158081b6e.7.1741643361367;
        Mon, 10 Mar 2025 14:49:21 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f68efbcb2esm2259339b6e.20.2025.03.10.14.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 14:49:19 -0700 (PDT)
Message-ID: <b282990a-de51-4120-abde-9b628847d9f9@baylibre.com>
Date: Mon, 10 Mar 2025 16:49:18 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] iio: adc: Use iio_push_to_buffers_with_ts() to
 provide length for runtime checks.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309182100.1351128-1-jic23@kernel.org>
 <20250309182100.1351128-6-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250309182100.1351128-6-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 1:20 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This new function allows us to perform debug checks in the helper to ensure
> that the overrun does not occur.  Use it in all the simple cases where
> either a static buffer or a structure is used in the drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

...

> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index 9a020680885d..77c5dd414d36 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -706,8 +706,9 @@ static irqreturn_t ad4030_trigger_handler(int irq, void *p)
>  	if (ret)
>  		goto out;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_data.raw,
> -					   pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, st->rx_data.raw,

Would &st->rx_data be more correct? I guess it doesn't really matter in this case.

> +				    sizeof(st->rx_data.raw),
> +				    pf->timestamp);
>  
>  out:
>  	iio_trigger_notify_done(indio_dev->trig);

...

> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 18559757f908..4217d3963455 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -87,8 +87,9 @@ static irqreturn_t ad7266_trigger_handler(int irq, void *p)
>  
>  	ret = spi_read(st->spi, st->data.sample, 4);
>  	if (ret == 0) {
> -		iio_push_to_buffers_with_timestamp(indio_dev, &st->data,
> -			    pf->timestamp);
> +		iio_push_to_buffers_with_ts(indio_dev, &st->data,
> +					    sizeof(st->data),

This one has `s64 timestamp;` which should be aligned_s64.

> +					    pf->timestamp);
>  	}
>  
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> index 28b88092b4aa..def5f91dc343 100644
> --- a/drivers/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -155,8 +155,9 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>  	if (b_sent)
>  		goto done;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
> -		iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, st->rx_buf,

Does this one actually have enough room in rx_buf for 9 16-bit channels and a
an aligned timestamp?

__be16	rx_buf[12] __aligned(IIO_DMA_MINALIGN);


> +				    sizeof(st->rx_buf),
> +				    iio_get_time_ns(indio_dev));
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);

...

> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 631e83717167..3ffa11b2e060 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -679,8 +679,8 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
>  	if (ret)
>  		goto error_ret;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &st->data,
> -					   iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, &st->data, sizeof(st->data),

This one might need ALIGNED in the buffer declarations. I'm working on this
driver though, so can fix it up.

> +				    iio_get_time_ns(indio_dev));
>  error_ret:
>  	iio_trigger_notify_done(indio_dev->trig);
>  	/* The rising edge of the CONVST signal starts a new conversion. */
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 5a863005aca6..4eb586d473ce 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -474,8 +474,9 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
>  	if (ret < 0)
>  		goto out;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.scan,
> -					   iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, &st->data.scan,
> +				    sizeof(st->data.scan),

This one could use aligned_s64 on the timestamp.

> +				    iio_get_time_ns(indio_dev));
>  
>  out:
>  	iio_trigger_notify_done(indio_dev->trig);

...

> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index 87945efb940b..0369151c7db1 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -207,8 +207,8 @@ static irqreturn_t ad7923_trigger_handler(int irq, void *p)
>  	if (b_sent)
>  		goto done;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
> -					   iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, st->rx_buf, sizeof(st->rx_buf),

This one is similar to ad7298 but doesn't have a temperature channel, so
probably OK. Still could use ALIGNED in the buffer declaration to make it more
obvious that we have a timestamp.

> +				    iio_get_time_ns(indio_dev));
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> index a1e48a756a7b..5ffb4b5f5c99 100644
> --- a/drivers/iio/adc/dln2-adc.c
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -488,8 +488,8 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
>  		       (void *)dev_data.values + t->from, t->length);
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &data,
> -					   iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, &data, sizeof(data),

Could use aligned_s64 on timestamp_space.

> +				    iio_get_time_ns(indio_dev));
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);

...

> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index 8f1e6acea53b..92baf3f5f560 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -425,7 +425,8 @@ static irqreturn_t mxs_lradc_adc_trigger_handler(int irq, void *p)
>  		j++;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(iio, adc->buffer, pf->timestamp);
> +	iio_push_to_buffers_with_ts(iio, adc->buffer, sizeof(adc->buffer),

u32			buffer[10] __aligned(8);

Technically OK, but could use ALIGN. There are some other drivers like this
but I won't call all of them out since they should be OK.

> +				    pf->timestamp);
>  
>  	iio_trigger_notify_done(iio->trig);
>  

...

> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 5dbf5f136768..32e7938b3892 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1858,8 +1858,8 @@ static irqreturn_t stm32_adc_trigger_handler(int irq, void *p)
>  
>  	/* reset buffer index */
>  	adc->bufi = 0;
> -	iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
> -					   pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, adc->buffer, sizeof(adc->buffer),

u16			buffer[STM32_ADC_MAX_SQ + 4] __aligned(8);

Could use ALIGN for timestamp instead of assuming STM32_ADC_MAX_SQ * 2 is the
correct alignment. There are also a few more drivers like this that depend on
a macro being even or multiple of 4 to get the correct alignment, which seems
like it could be fragile, e.g. if a temperature channel was added.

> +				    pf->timestamp);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	/* re-enable eoc irq */

...


