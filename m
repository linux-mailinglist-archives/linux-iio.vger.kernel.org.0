Return-Path: <linux-iio+bounces-23593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F3BB3EC9D
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 18:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714084801CB
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E352DF156;
	Mon,  1 Sep 2025 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HY723NAh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66022DF13C
	for <linux-iio@vger.kernel.org>; Mon,  1 Sep 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756745283; cv=none; b=VDe5nKmEEumAAFK7VDbaL12+r+3TY8PjNt7fotqht6eA+ipOQlMgbT88HRSR4raQDGsmUD2YMsKug7NmrNM57x3l/0mEWrUKKQczp6LuD5mTwzIYrq9cNmKZY5EbY8GEJEoLQyt08mtHl/X+A/0ZEi8gAJcrvBnAgpQjFK3Cz68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756745283; c=relaxed/simple;
	bh=fkryIHu4I1xIx2CWEKCdM9po9RrcPxRizn7i/jnNbiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gw1YgndrJJVhGyRnYvaFwbONah94puY3wbantPWncFEhpgJXz1NOgAx9qofUkFnpDbgbbl46lQTVw+yuJRHMsaED3oahaMcoCTz/EOo6tXMo7jGL9cZCdrSQxr9gsdcVArZkMMwN2hDNBCirsEAdU8+RZbNJaWvv5vouZCv0gFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HY723NAh; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-30ccec928f6so2230126fac.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Sep 2025 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756745280; x=1757350080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmhTGKLssoVeGJ2/TQJ8RgkIS6rn9bKv2i70wU++5KI=;
        b=HY723NAhJukyBMQYQ1aCbZ5Gke9Z8m7owqwCoBy70lILZ9DPH5JL8oLz6Hqo9djoqg
         ZZKMaLMUpWM7pK1t6w6DZY1WDjc5vh9F+4f7QBUnzFJVSeunu0uEFLrNNz87xVGBijcT
         RL+Pdp1Ip5Wfva5+yp7cRTDWNPNc3F8f4Y8hzh/7UnjE+nvBPG1ZgA/w8JNDhA8CnZfG
         mxQwfzGjhulnvR/86UTesEy5vW1ga/3NOdgtaorJ0g8qEYscjLL8UorxhhlC4N3MvnPT
         +CiTS8cCd0nlukYuf9uIfVZrIXqd4wVoU04l0cz9193Inwq5RgewepeURrrXs0OGtusK
         c8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756745280; x=1757350080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmhTGKLssoVeGJ2/TQJ8RgkIS6rn9bKv2i70wU++5KI=;
        b=f6MZXmJwFMNfGF+TD6CLKlewhtBa2XTtcDtX7Cn+GuVbRL6das/vmmeWt4xlFhu+aQ
         EHpixSWHld5cEmj7efzbV+aKmHwCxBRBGVlFAC7386AOLi4WKzQlGh1lsltMyCSY43xQ
         2+LUgxx4c+nFUq3hbjeSRijMYhJfcUjGzbi324hyNWEAJ47hT2h4GSEVe4oiW+584Jjw
         pTWeRzF4bx4uhbmR+fmhh6YZVzVF06nrf6Gq/q+FeAFaaBLzyGQWowqKyqiTQuUGWwtq
         WEF9uUvDbImwFGzL3lgfsfF3lJak2Yi8DEy7jXAoIJm8xB8ctm+TQIxDjrVlJdGN8Ol8
         haQg==
X-Forwarded-Encrypted: i=1; AJvYcCXPkQaL2VEGuGLDpv5yqwQv6GBMFd/fx75MXlcgz4rR71fEdCcBjeTnJRrOuq+pWhi12SjZF2c6bEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPismMmDo7nfAUppF5uxEfpX3OlDVyntHuK6eD9FCAHy+ArtpB
	apUZNCqN7Jp76k5WIMRAHDfqGA1mpQPPeUizQoFlIT4PjPhnvwDsrdRezHaAz8csHxo=
X-Gm-Gg: ASbGncvrU5wUuXP5R0B0kuI76KXdSw7AerenLSLykEMAsx1SEWZ/3SL/DgiVGYNYEHG
	BxVPRfJIgN9TGAT1c+xO/CxHHnMekEuuqLDj7sJquxkqZJkHCr25Zfq/TzhY5s2k3mwEx2Hkh83
	uBzGFIzTNoXGbNaWj6WoumDvzdq3CjL50wlIcJGP5/3CA/4HJ4mDcjI7lfHxDtlLbQX2D9epT4i
	1+UExFBd/SHD1nw0Z52fYrHFb3xtbFhpqiN570CXRNA/osdKjo+t571Ta8G8O5BpAxnBn+JkHH2
	+0t+NOGImnk8hRfUT3JjG+BBQ+XVSVVSEA2SYf4erOPhYp/TJP0RSTfZ8+hCVMeZsQSXk7BzjEl
	CzYsFZ9+Xbnw3JJIHPYjXmQxbFgWEcJEHeKuoTZDSSgT5UzJerN0iH6WNsBmqFbJuwaLH4fO+N1
	8hTIrcArF6FfcgHSsW7w==
X-Google-Smtp-Source: AGHT+IFMcJUfkp0DBfp/hK2wpKwhpqBEsHP4VYRpkRr7ud68ywPh/oMdr28/f25+B6OHHS1ppf8vDg==
X-Received: by 2002:a05:6871:4b8a:b0:30b:85e1:d3ea with SMTP id 586e51a60fabf-31963183f91mr3959730fac.21.1756745279707;
        Mon, 01 Sep 2025 09:47:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e? ([2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7457428c153sm1091594a34.8.2025.09.01.09.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 09:47:58 -0700 (PDT)
Message-ID: <b6c2ac13-2781-49ba-964f-ca821b32e2a2@baylibre.com>
Date: Mon, 1 Sep 2025 11:47:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: iio: adc: ad7816: add mutex to serialize
 SPI/GPIO operations
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org
References: <20250831153741.8820-1-moahmmad.hosseinii@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250831153741.8820-1-moahmmad.hosseinii@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/25 10:37 AM, Mohammad Amin Hosseini wrote:
> From: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>
> 
> The ad7816 driver was accessing SPI and GPIO lines without
> synchronization, which could lead to race conditions when accessed
> concurrently from multiple contexts. This might result in corrupted
> readings or inconsistent GPIO states.
> 
> Introduce an io_lock mutex in the driver structure to serialize:
> - SPI transactions in ad7816_spi_read() and ad7816_spi_write()
> - GPIO pin toggling sequences
> - Updates to device state via sysfs store functions (mode, channel, oti)
> 
> The mutex ensures proper mutual exclusion and prevents race
> conditions under concurrent access.
> 
> Signed-off-by: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 4774df778de9..06567d048a6d 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -50,6 +50,7 @@ struct ad7816_chip_info {
>  	u8  oti_data[AD7816_CS_MAX + 1];
>  	u8  channel_id;	/* 0 always be temperature */
>  	u8  mode;
> +	struct mutex io_lock;	/* Protects SPI transactions and GPIO toggling */
>  };
>  
>  enum ad7816_type {
> @@ -67,13 +68,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  	int ret;
>  	__be16 buf;
>  
> +	mutex_lock(&chip->io_lock);

Could avoid the gotos by using:

	guard(mutex)(&chip->io_lock);

> +
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
> -	if (ret < 0) {
> -		dev_err(&spi_dev->dev, "SPI channel setting error\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto unlock;
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  
>  	if (chip->mode == AD7816_PD) { /* operating mode 2 */
> @@ -92,13 +93,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	ret = spi_read(spi_dev, &buf, sizeof(*data));
> -	if (ret < 0) {
> -		dev_err(&spi_dev->dev, "SPI data read error\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto unlock;
>  
>  	*data = be16_to_cpu(buf);
>  
> +unlock:
> +	mutex_unlock(&chip->io_lock);
>  	return ret;
>  }
>  
> @@ -107,12 +108,13 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
>  	struct spi_device *spi_dev = chip->spi_dev;
>  	int ret;
>  
> +	mutex_lock(&chip->io_lock);
> +
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	ret = spi_write(spi_dev, &data, sizeof(data));
> -	if (ret < 0)
> -		dev_err(&spi_dev->dev, "SPI oti data write error\n");
>  
> +	mutex_unlock(&chip->io_lock);
>  	return ret;
>  }
>  

...

> @@ -363,6 +371,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  	dev_set_drvdata(&spi_dev->dev, indio_dev);
>  
>  	chip->spi_dev = spi_dev;
> +	mutex_init(&chip->io_lock);

Prefer devm_mutex_init() instead.

>  	for (i = 0; i <= AD7816_CS_MAX; i++)
>  		chip->oti_data[i] = 203;
>  


