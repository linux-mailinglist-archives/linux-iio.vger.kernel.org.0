Return-Path: <linux-iio+bounces-15788-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2A4A3BE70
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 13:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB683A4193
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47061E04BB;
	Wed, 19 Feb 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HARHGJkF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E717543
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969199; cv=none; b=mH4S2uEwvbrocnZwGssxPHa0+G/pozKpgBHLxWGHhGRv8/5kaSPB2u7vH/dO+tBVBzk+4si8MwHT2CS69T8ZOi6vDLKi0O4pCSsGEyLiZ3+hxbXM0X+JBKaim9dwtw2a4oh5QhXph0NfmaguK407p33SYZu3+XUTlNomhlaxnoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969199; c=relaxed/simple;
	bh=lhTiyk0w/MEPxYnQZTnwG1mmLC1GJKQNTb5NpYAhZ8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GiDJLgWc3eXwE96O40nbOlCAioaGHg2Jqwk3YgArWMTvov9brHmJs8M0SO54XYa7MTOMmiDYzuSMxx3Hy+KHLHfqZX17zpo138WU5K7Fux3pWTLBMqd3XACPVt1gaISjdE83Ni6c9Sc9+DYzRczkG5SBF+39KzyRTdP7uuNbQOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HARHGJkF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so8434141a12.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 04:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739969196; x=1740573996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0mAP4quUGlhrutbX2u+WBymCEnObYYL6n/wt0GebXs=;
        b=HARHGJkF1v55l3XxNRh8LhyZ9dhohhFRcz9ZayOg8WHRaMpRbzy6QW3hrCMyqCQzV1
         eQnCSezs+YFrVnexrmvA+zUkssEAUgaSPl7woSnncyTpxAa1zjz0q6UvPJmlRFlkvg2S
         V1S8wCEcQbNPOYbBV0XdbIiSqPxy4uMKdZyXs63p1VsfUjD9vRtOeg1bflxN4pJsxKQT
         LdCTCTPgNro5K6jYb9ZUoaiCVc94dcZmOuh5RBBGUYyO2x+hkiZQrW0Rold9MQ+Y/an7
         h325XTO0ti6mO3LZBns7B6O4jcgQq5Uy5cq7YeBwblC4R6oTi6a8t2SRtIsJau22yxBj
         bH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969196; x=1740573996;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0mAP4quUGlhrutbX2u+WBymCEnObYYL6n/wt0GebXs=;
        b=B9oR27TPxOyuWZ05k/LedMV6y7updU7+qeB7i4t7k+3wkT/hEPSFLrUwS37VdbMqrV
         0X/HepUh08B1c1lPPtmFfVHxJYf9KpTQuTju7vrm6HaG0rzarWsAFzXCmiWVmlXhxL6I
         ORUrGZYSQ5x5LZxUv0JRraJ+B90HaJJd7X8UMvWMIBBDAhG5OOlxY21CFW9AjKJwlrTa
         8WoD+6sFwNMk1Nh4ExgLGi00dyp562pLJZTo4uOegt7XMxz+Qjr2Srm5fP6xw0IvFzF+
         ZsPeb7uPflgXZOfV+KszaGAs2kRjrC0HPxy/Oo1h4Tr4t59F70F9Sm5KwcZp/YcqVZTk
         gsOg==
X-Forwarded-Encrypted: i=1; AJvYcCWkNb5wDyHggFsbr0tI4SmyAjw2Alc2dsYBdv3ERAmh/XoEENJ3R0KACJTgQTdI9yAictFPogBShRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvWsw2mj9cYuaZ8h9PP0OGLwUbJSK9o1ybi3Br4z5E3yLCKpx
	6lcG1QuoTFsRzsfVW8faXFGks3d+MloENjgVJdqZy4idWZ/EuBTx8SErFN5HAAU=
X-Gm-Gg: ASbGnctNF9p6N+NDBthnBNAWfIlv3FizNHwV57Hz6JYml/03SyC/ov4wgaE3XkwZkJa
	xQ9zeMlcrdugK416DhNcEsHj98wQXw+4rcSjtoj5Wpzw8V0/faeCvAb7nPXpnXw5XtACTTC9+5W
	GiUO/Wx/6xDnIYOVyq+uONOkCZVwW1Sz125VT5l7Pp4Rju4rP53nFJ3ocdDRYRF72Wg1KxLAHOA
	V/qsJv25gK9vTBVStKoXOu9+gKRYDLbgncegi/7bT2Lc6yMPcJp9Q7tCrm6hIIgfy5M8Q1XqO1O
	QXFLHJQrRs2vuk8Ll4MUIwk=
X-Google-Smtp-Source: AGHT+IGnsaK4zZmb6+3yQqrQryTnVic9h7q6kMQ/LJUs/L4dM5wNU9LXlf14w9nwS6cX8NQM0hO24A==
X-Received: by 2002:a05:6402:430f:b0:5df:b6e1:4690 with SMTP id 4fb4d7f45d1cf-5e03602e5eemr48004049a12.12.1739969195860;
        Wed, 19 Feb 2025 04:46:35 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbe441236fsm32249466b.176.2025.02.19.04.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 04:46:35 -0800 (PST)
Message-ID: <4330c770-db48-4017-ada8-1dddcfe44ba2@tuxon.dev>
Date: Wed, 19 Feb 2025 14:46:34 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/29] iio: adc: at91-sama5d2: Switch to sparse friendly
 iio_device_claim/release_direct()
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
 <20250217141630.897334-23-jic23@kernel.org>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250217141630.897334-23-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 17.02.2025 16:16, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 70d3dbb39b25..694ff96fc913 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1914,12 +1914,11 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
>  
>  		ret = at91_adc_read_info_locked(indio_dev, chan, val);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
>  		return ret;
>  
>  	case IIO_CHAN_INFO_SCALE:
> @@ -1932,12 +1931,11 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  		if (chan->type != IIO_TEMP)
>  			return -EINVAL;
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
>  
>  		ret = at91_adc_read_temp(indio_dev, chan, val);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
>  
>  		return ret;
>  
> @@ -1967,28 +1965,26 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
>  		if (val == st->oversampling_ratio)
>  			return 0;
>  
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
>  		mutex_lock(&st->lock);
>  		/* update ratio */
>  		ret = at91_adc_config_emr(st, val, 0);
>  		mutex_unlock(&st->lock);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
>  		return ret;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val < st->soc_info.min_sample_rate ||
>  		    val > st->soc_info.max_sample_rate)
>  			return -EINVAL;
>  
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
>  		mutex_lock(&st->lock);
>  		at91_adc_setup_samp_freq(indio_dev, val,
>  					 st->soc_info.startup_time, 0);
>  		mutex_unlock(&st->lock);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
>  		return 0;
>  	default:
>  		return -EINVAL;


