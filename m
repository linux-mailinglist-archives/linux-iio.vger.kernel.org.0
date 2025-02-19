Return-Path: <linux-iio+bounces-15787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB00A3BE6D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 13:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79BAB1895E42
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FBC1E231A;
	Wed, 19 Feb 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RUiNSgmM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62611E105E
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969152; cv=none; b=lCrMdJCvkEofrsRydVEiyPvhBgO/n2vmBsCsefw3jWF10T3hYhRXdovQo2PvZEGs2F70x0LCCo5lbHv43SXoLGyf8FCWxn+0vG4Mi+q25a5tyjWlEIDlPUz7K+5cfkrttgesyy+hISn0RNKb7xqQ8vyLYLBnFRcoWTw2XHlRGgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969152; c=relaxed/simple;
	bh=Y8CwLiqX18RZr6gzygHRPtgz+K1ZBBRvue0P09PHtQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4lS3dzoUkNF7kGyUkunnnXNgHo0/9L2yianIPyjrFnPGASAvTcp3RfhwRZ02mc4M8d25OSXIBfX8Ry8Eyrk0eD8E5Dh3nvLLGifRoo/6d1l7yT7k0zy4fbEDj6sE3qcOd5UeeJ2K/VJw+2J+lmGr3puKW+CogGry5xqzM/2MXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RUiNSgmM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abba1b74586so491520766b.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 04:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739969149; x=1740573949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Sq5QV8eGtCHs3O6c0NYjKJP/LjRctxkIqsa5Wv/aFU=;
        b=RUiNSgmMVGZXZxZRxv3zDThy6rLvaW+EXQbuRr61jSRDbBRh88jTmbo9MAwarpXGwI
         1JXFBmAa8wQNJ6IWmYoPYDw8DpaPoO036F6NnO3hg3O24up04XEfjvCSYjb7Bq81ALuC
         X9HGZ2l2J2NhAO2/hGUCnEOEz3yY8hUWpxIn597eYidLlnSmytXgQT34JQAO7GiOhFpx
         fDzR3Oc8vGoJCYPzOOSwY9vO7OOVPXWjJ7fa9OeqVvoNl2neoeK0pjt6ooK2q6nw7DIj
         thiVtSSvQ7Ag2VWKDUe+VR1rF+LcTSx+by+68xFEf7j6sEO1AC0WVh9roZF1mQFN8Il5
         /BOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969149; x=1740573949;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Sq5QV8eGtCHs3O6c0NYjKJP/LjRctxkIqsa5Wv/aFU=;
        b=Jvrlo0u+3DSKY17puS0RUe16eIeuLrL84cUqxY3/s24xW/Y4MYq6/x4lWLzXWe/hxE
         cMvfduxtq7eXEr+tLkWlT/VTttzFayHJ+9YYtqfjeWYAjE+WuHVaeyIyvknO09Bv8/xS
         V98BsRIQvZEI30ZLV6+2IWw96NWsZzTWsUswwp2fWjfiqycZoTte5cLo0Kszh6DraUJP
         AdvWNeh9iBT9cjTaUL7xdvMtb5XWG4E8LGMPI2aHdaHLkUIbG/pn4lkvDwqN9Hm9m0op
         La+S1+r4ljHuS2i0bQuCwmXTJXY7iUruIdadBjfROkrj9f2qSZaqbj9jZn2ptYutvLli
         VwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVup81FFc97kksJb1PVUTb3goantsxyXysxRAIPV1mZU+3eOTI3PEPZD6IkN10hdDczXq2R2M5y0Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6JWjvltnqBD2Q9ugUMtNb+U7JD9NFa4kckNH8iYJSOALfKE90
	swSAfQ/VBkb9UyC6ApCQSKYsGtXlCrPkkjafr9of1xP0nI9LBNE/6XmCyW4/9Tv4TG2oWMdn5GK
	2
X-Gm-Gg: ASbGncsmeNYRW3VEmHVLD56Dqng3H8DZu9ik5iuIyFeuEEJmYgh5T3B56lEaYZ8eHHt
	IFLfY+xLXdVqfHfoLdl40IPOtOciEgXA2U9KGNDYJMxGlraQnXW2OsAkcfPDpsjc+lFUiOA2h1b
	zz86O4Hcu9Qj8Sryg+bRhwAuViPC2PgM0T2x185CxpCl2XIRIhyuDVfkfGOqqt3Vh5ZgDfoKIlp
	IY3Nn+t+6dvb4JOZPPxf3fFFmT3Xgb7lASfPzXTiPiuVzP6fWH0/QIitWpF4abpNQfj2BKMjItL
	0p+lQ3cWGuXoD4eicH69njY=
X-Google-Smtp-Source: AGHT+IHENsTCqwj3JrkHlN4+KJrYXAkI/9ZI7JKOiuNmd/0qsu+Sar+p3NscLnRRGziPrfzd/WWy8g==
X-Received: by 2002:a17:907:784b:b0:ab6:4fa6:71e2 with SMTP id a640c23a62f3a-abb70b8aa8dmr1450964066b.22.1739969148898;
        Wed, 19 Feb 2025 04:45:48 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb91e9d96bsm660354166b.122.2025.02.19.04.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 04:45:48 -0800 (PST)
Message-ID: <1c14db5a-834e-443d-b4c3-6113da35966d@tuxon.dev>
Date: Wed, 19 Feb 2025 14:45:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/29] iio: adc: at91-sama5d2: Move claim of direct mode
 up a level and use guard()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Mike Looijmans <mike.looijmans@topic.nl>, Phil Reid
 <preid@electromag.com.au>, Marek Vasut <marek.vasut+renesas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>, Marek Vasut <marex@denx.de>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250217141630.897334-1-jic23@kernel.org>
 <20250217141630.897334-22-jic23@kernel.org>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250217141630.897334-22-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17.02.2025 16:16, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Move iio_device_claim_direct_mode() up one layer in the call stack,
> and use guard() for scope based unlocking to simplify error handling
> by allowing direct returns.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 42 +++++++++++++++---------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 8e5aaf15a921..70d3dbb39b25 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> @@ -1814,19 +1815,10 @@ static int at91_adc_read_info_locked(struct iio_dev *indio_dev,
>  				     struct iio_chan_spec const *chan, int *val)
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	ret = iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	mutex_lock(&st->lock);
> -	ret = at91_adc_read_info_raw(indio_dev, chan, val);
> -	mutex_unlock(&st->lock);
>  
> -	iio_device_release_direct_mode(indio_dev);
> +	guard(mutex)(&st->lock);
>  
> -	return ret;
> +	return at91_adc_read_info_raw(indio_dev, chan, val);
>  }
>  
>  static void at91_adc_temp_sensor_configure(struct at91_adc_state *st,
> @@ -1871,14 +1863,11 @@ static int at91_adc_read_temp(struct iio_dev *indio_dev,
>  	u32 tmp;
>  	int ret, vbg, vtemp;
>  
> -	ret = iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	ret = pm_runtime_resume_and_get(st->dev);
>  	if (ret < 0)
> -		goto unlock;
> +		return ret;
>  
>  	at91_adc_temp_sensor_configure(st, true);
>  
> @@ -1900,9 +1889,6 @@ static int at91_adc_read_temp(struct iio_dev *indio_dev,
>  	at91_adc_temp_sensor_configure(st, false);
>  	pm_runtime_mark_last_busy(st->dev);
>  	pm_runtime_put_autosuspend(st->dev);
> -unlock:
> -	mutex_unlock(&st->lock);
> -	iio_device_release_direct_mode(indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1924,10 +1910,17 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  			     int *val, int *val2, long mask)
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		return at91_adc_read_info_locked(indio_dev, chan, val);
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = at91_adc_read_info_locked(indio_dev, chan, val);
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
>  
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = st->vref_uv / 1000;
> @@ -1939,7 +1932,14 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  		if (chan->type != IIO_TEMP)
>  			return -EINVAL;
> -		return at91_adc_read_temp(indio_dev, chan, val);
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = at91_adc_read_temp(indio_dev, chan, val);
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		return ret;
>  
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*val = at91_adc_get_sample_freq(st);


