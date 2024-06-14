Return-Path: <linux-iio+bounces-6272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDE4908E7F
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 17:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF2D1C251E3
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439FE15EFDF;
	Fri, 14 Jun 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ppNIaeTY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A1158DB1
	for <linux-iio@vger.kernel.org>; Fri, 14 Jun 2024 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378191; cv=none; b=EMPODmSQtbYhRV1JVzVAAyXKU3r9SW6Z0R1QEkxG9bafoa3qjMeUUA8snVsNe61/SEKEzyNTRGCZuZWuBsiPs5MpJMhvREWfG0QdOaJ6q1Pu1WozvzyGRZhm1bsKorT3kJOSnGxuHIvcbVedKKfrljLxFG0DoZKeE35JtICnj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378191; c=relaxed/simple;
	bh=82BKhcyYzugHO24SccvwRMSP84ffRJcHOxlx5YJViKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+IzAdNTzNCySySIgS2WrxXCN5fTNzov67bCO9qamX212sYiZsTbhGLcuyWrKGfaVK+yf01LrTj8+AR1skivWVGFIY4hOhau7bcC3B+Bjg3Uot7MWj0OKODNcyJN1er7Pv2vfAHtUCLYZVZ9tZA9wvBVcvVItYio28ZYxK6fej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ppNIaeTY; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2550aa6f994so1345290fac.3
        for <linux-iio@vger.kernel.org>; Fri, 14 Jun 2024 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718378187; x=1718982987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEXFcMzVkenGJ+BkWNtfk85Td7ZfJA69rDpGmACovwc=;
        b=ppNIaeTYeqQChHNTk6cs6u+UKAaveLvQ9zWw1uVt3/+B2ZE2+2I45N87AlbCMa0wTj
         ocdqmt/qQKPJr+xpBHqk1J3yTxdHzpEjBmW5kiWbyytDr68JG7tFcFcQjbGvTohmqLMt
         DA4jfhcBfsoZDOWpDuCLa4c9V2O+QjWmiWvz7dCHrrwoM2BFgFbCEPxGazNW0l5xUftO
         w+9YUFIGsgGrmDrKXWpLRLJyHwK1gClBpY0E5d0sf+1PrpsR1485jmhZn1uyHAhiGGrK
         +WmWoC+a3UOQktLhnBwY6XizEnpsVVxxgEDAEuyDEeKUWIfoaHhRBveXxrk74OKqyg6z
         /StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718378187; x=1718982987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEXFcMzVkenGJ+BkWNtfk85Td7ZfJA69rDpGmACovwc=;
        b=IacFofjHlk0Se2xB3CpmAFM4xegPhC8zxOkQoZL2RK5pQrlR2V+M/Az4MzzR0Qr1k9
         o1SoQ6VsZGOaA4i3dmM0jNySH8kyO1Yi0AynlBcDbc7CoCQHU+Xwl7YYq6lPEej0asqF
         8ubef6GLRvu1yW3XUj+9WjSpY2UP5WEoXv8nPxT1VvAfx0N4Mibui1yTtYj0zTPRBuyy
         JmeRpRCq+VCeuNvmr72P2Q/t9RAYvdQbnGEtUIltf9LP6IV7Z3cUfluWJHXIvro9dA9M
         fARctkcDwaXY7svcTwjokXcAGAmOonqav7IMHYGvSOrb+Gl1d3mKP2E91hO6D/fjyiYJ
         dTlA==
X-Forwarded-Encrypted: i=1; AJvYcCU/RLDChlxunmMkDb9OkzeMaGdiJWngOtrg/GUSutz+2KhIYHAVdh7KFYPz3vm84txz0d1k6J2KOUMNtE1emhKGNQhv5LkBSKF/
X-Gm-Message-State: AOJu0Yzpxx9KJUiHsHQrQ+tUkYOYoTHulxPsmzfJB1lZ/6gtFwXopdNg
	LODlr5d3+SJVVKnCDZuNudn9dB2pgGdX0ocVD2iQym4WZa0EMZ1hfUhW5HyO9A4=
X-Google-Smtp-Source: AGHT+IFO1xK0In15roboxefh1WiLKyHXcMeYqg8d+QLpQa84F3+WTT+qE0PYj1wMXasjehJfMzVnYA==
X-Received: by 2002:a05:6870:4728:b0:254:8c7a:6c97 with SMTP id 586e51a60fabf-2584298504fmr3493907fac.30.1718378187574;
        Fri, 14 Jun 2024 08:16:27 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7fc6sm991687fac.18.2024.06.14.08.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 08:16:27 -0700 (PDT)
Message-ID: <a9e4b62f-7021-4939-82a5-8b2089cd7193@baylibre.com>
Date: Fri, 14 Jun 2024 10:16:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] iio: adc: ad7292: use
 devm_regulator_get_enable_read_voltage
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
 <20240612-iio-adc-ref-supply-refactor-v2-3-fa622e7354e9@baylibre.com>
 <f45d0cba3e3fc087d0a3b8c5af5401a5c38ec162.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <f45d0cba3e3fc087d0a3b8c5af5401a5c38ec162.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/14/24 10:11 AM, Nuno Sá wrote:
> On Wed, 2024-06-12 at 16:03 -0500, David Lechner wrote:
>> This makes use of the new devm_regulator_get_enable_read_voltage()
>> function to reduce boilerplate code.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>> v2 changes:
>> * avoid else in return value check
>> * use macro instead of comment to document internal reference voltage
>> ---
>>  drivers/iio/adc/ad7292.c | 36 ++++++------------------------------
>>  1 file changed, 6 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
>> index 6aadd14f459d..87ffe66058a1 100644
>> --- a/drivers/iio/adc/ad7292.c
>> +++ b/drivers/iio/adc/ad7292.c
>> @@ -17,6 +17,8 @@
>>  
>>  #define ADI_VENDOR_ID 0x0018
>>  
>> +#define AD7292_INTERNAL_REF_MV 1250
>> +
>>  /* AD7292 registers definition */
>>  #define AD7292_REG_VENDOR_ID		0x00
>>  #define AD7292_REG_CONF_BANK		0x05
>> @@ -79,7 +81,6 @@ static const struct iio_chan_spec ad7292_channels_diff[] = {
>>  
>>  struct ad7292_state {
>>  	struct spi_device *spi;
>> -	struct regulator *reg;
>>  	unsigned short vref_mv;
>>  
>>  	__be16 d16 __aligned(IIO_DMA_MINALIGN);
>> @@ -250,13 +251,6 @@ static const struct iio_info ad7292_info = {
>>  	.read_raw = ad7292_read_raw,
>>  };
>>  
>> -static void ad7292_regulator_disable(void *data)
>> -{
>> -	struct ad7292_state *st = data;
>> -
>> -	regulator_disable(st->reg);
>> -}
>> -
>>  static int ad7292_probe(struct spi_device *spi)
>>  {
>>  	struct ad7292_state *st;
>> @@ -277,29 +271,11 @@ static int ad7292_probe(struct spi_device *spi)
>>  		return -EINVAL;
>>  	}
>>  
>> -	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
>> -	if (!IS_ERR(st->reg)) {
>> -		ret = regulator_enable(st->reg);
>> -		if (ret) {
>> -			dev_err(&spi->dev,
>> -				"Failed to enable external vref supply\n");
>> -			return ret;
>> -		}
>> -
>> -		ret = devm_add_action_or_reset(&spi->dev,
>> -					       ad7292_regulator_disable, st);
>> -		if (ret)
>> -			return ret;
>> -
>> -		ret = regulator_get_voltage(st->reg);
>> -		if (ret < 0)
>> -			return ret;
>> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
>> +	if (ret < 0 && ret == -ENODEV)
> 
> ret != -ENODEV?

yup, I messed this one up

> 
> - Nuno Sá
> 


