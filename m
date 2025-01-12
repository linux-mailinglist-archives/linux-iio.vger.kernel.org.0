Return-Path: <linux-iio+bounces-14254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18257A0AB5C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 18:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C0E7A1D4C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA15F1C07DB;
	Sun, 12 Jan 2025 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ACQIe+jn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D4153BE4
	for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736704276; cv=none; b=a2Ff5HJ/pl4jq9Su5AqE4q3xnn6wIOzxcXSy4Yj9geqjGYcZWytMxX1iDI9XarxCWJyd6IlFRupF4dG5oOvgq/FHfeAHnXvU9rFbFFZglPmhKnUvn5QO+bYaAosvQOJy9uyPsvg+LF3y1Xxly4IVdq29z9xGd7rD/OnnIrT40WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736704276; c=relaxed/simple;
	bh=JEg+CjL6j4vaRPnFnrjXYayJ9GfUnrA3Z8TQF+eHbXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YaERPe/dBVa8jskVS0DXUYwsmcU0ZbPEhT+BslKianaqCbGcEZIMnPv8Shh8EKNymysD4FVH4KcpG0XDQ/qIM1JLTxopU43NmiyABmWTW9yURS55h1uwAd6eno7EDzKj03IgTSPjpTTg8A253o8bHHMKSF6KFKutsBXXo+Liq5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ACQIe+jn; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f89aa7a101so446797eaf.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736704272; x=1737309072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=77F0rHiG5G/8w55gp0qJMQWluPA7lhqHoQD4izaVvec=;
        b=ACQIe+jn8MQO6LhEq5GP0R8VjED3CUoQdQkKnBuyi6063zgMTIUL90rJ4iWErlG6/E
         WAFWywxees4bKVXwwP3PwEnBLjSnbslQicmAVlO1bYaXoLXDMD5Lkc1HDLL9XXmShvBv
         1DC5jJeAEugOS06IJrOHlu0knZYWQ6KWN80MxZG3vXj/AFazhLloFaHcEOr6rJl5EnNS
         T0rh50fv4E87dIQyIJBQqnnaLKQhhAg5K6RQ66tWiBYcvi0kJCeUGd6i7geV8C3wrNcj
         Wo/xs2MI9VXWjD7Eq1PTjx1sJVrt5OdSOdVnLWZC5IGUOB84OmXOL6PqWdF+R/DpLg1E
         YcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736704272; x=1737309072;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77F0rHiG5G/8w55gp0qJMQWluPA7lhqHoQD4izaVvec=;
        b=xBA3uhZxM/5GUVVHnG3jb9+XbJ8jUQ7HL8Yr6pixsyVV0jli9RrwIhGUphdGTI6sDP
         dkYBrrjuS6YiOWwYSag3f+W3aBycgu7jWCg2kUPPYCvfhuH/lpQqUvz1+5QKaiE+frD4
         Et3f/i/X2CSuWKOL1RrRWHBFxX2xdHUP2p06CYkhTdTcKGgJfH2IENq11B0V+vngF0RT
         GvooCf2Dw8FKw5V3EOaInJp07dm6/UEQT1Qk5Rt6CWKL28YcCw6EfUnPmdD4Uwqw2XMn
         eOmkVllrVHfS9y3ec3wPFAt9kShQCzSCcd0WZGQzXAA+Oys/mVztN7dYUQ5gC2mZbbqt
         3yUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXegoLWyRuQuHfgihwEgT4OEW363qPXjV+GSrVY5v3LabLmCy1iaHsHXovgQ2xpv3MawoRbpj6E8Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJZ0CDODPPPw+zFwlgrnywUquraSpexXP3vqa54tOFjyePCA+
	TdOWm+ntL8Hgq63i6lwZANq0Phj8pGsf2dfsZ4UT5GjgC/W0hcFUCkBvTF4P7OI=
X-Gm-Gg: ASbGncuAD/MQRA/j1gxmduIntHLZwgH/wl7u2V+QESSxnEAp9EoRPGbEU4re6K+Tf0Z
	Kj2jrhRHqY4kX8mCJyOiwnxdMOa9fiHtPTH+r1umliIVuDU9oZlP6VV5MrIt1kWCSDdr1VGgz/8
	y09Lh24G89c8vMjqKvlF+qNtCp/IdGaIfov4Q+vcZ6wh+AVGzdb3w39ffVK+I12OCmtc9Hzg8UG
	H6r6Ta7nOT7D4268KHd5GpVpdGMUKwSecJiOY63BSANJ0jbmtLp/551K2QUAEvKd38xH8GTYHC8
	RNm6ZQ9Fw01SZ24PUA==
X-Google-Smtp-Source: AGHT+IE/yu5bRIO18vQW5iVW/+sm9OlyQ0eR+whXDMmijDKcTJUnVN9/DHijbBgaAapiA+K4zMWsrg==
X-Received: by 2002:a05:6870:1710:b0:29e:1325:760a with SMTP id 586e51a60fabf-2aa06668e92mr9650139fac.8.1736704272257;
        Sun, 12 Jan 2025 09:51:12 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ad80547c11sm2982541fac.18.2025.01.12.09.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 09:51:10 -0800 (PST)
Message-ID: <106d451d-2433-4343-9e22-d9f37b9a24db@baylibre.com>
Date: Sun, 12 Jan 2025 11:51:09 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/15] iio: adc: ad7768-1: add multiple scan types to
 support 16-bits mode
To: Jonathan Cameron <jic23@kernel.org>,
 Jonathan Santos <jonath4nns@gmail.com>
Cc: 111f571d-1d88-42f7-b9a5-4b1cb328e26b@baylibre.com,
 Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <170c5ca1b6c45b2114f248d9085588572d6269b4.1736201898.git.Jonathan.Santos@analog.com>
 <111f571d-1d88-42f7-b9a5-4b1cb328e26b@baylibre.com>
 <Z4M1QU8XQjAKqI4W@JSANTO12-L01.ad.analog.com>
 <20250112125037.442c56c9@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250112125037.442c56c9@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/25 6:50 AM, Jonathan Cameron wrote:
> On Sun, 12 Jan 2025 00:21:37 -0300
> Jonathan Santos <jonath4nns@gmail.com> wrote:
> 
>> On 01/07, David Lechner wrote:
>>> On 1/7/25 9:26 AM, Jonathan Santos wrote:  
>>>> When the device is configured to Sinc5 filter and decimation x8,
>>>> output data is reduced to 16-bits in order to support 1 MHz of
>>>> sampling frequency due to clock limitation.  
>>>
>>> We aren't going to get a 1 MHz sample rate without SPI offload support so maybe
>>> we should save this patch until then?
>>>
>>> In this patch, we are still reading 24-bits per sample, so we aren't really
>>> getting any benefit. It is probably fine for now to leave it as 24-bit even if
>>> the last 8 bits are all 0 or just noise.  
>>
>> Indeed we cannot achieve 1 MHz yet, but I believe it is good have this
>> now so it is more mature for the time SPI offload is supported. Also, will
>> allow us to backport this patch to other repos.
>>
>>>
>>> Also, the datasheet says:
>>>
>>> 	this path allows viewing of wider bandwidth; however, it is quantization
>>> 	noise limited so that output data is reduced to 16 bits
>>>
>>> So this doesn't actually seem related to higher sample rates. There is a CONVLEN
>>> bit in the INTERFACE_FORMAT register that globally reduces the output size to
>>> 16-bit, which I suspect would be what we will need for achieving the highest
>>> sample rate when we add SPI offload support.
>>>   
>>
>> Right, that is true, but the reason we did this patch was to fix the
>> output size when we configure the filter to sinc5 decx8. The datasheet
>> says:
>>
>> 	To configure the sinc5 filter for 1.024 MSPS output data rate,
>> 	write 001 to the FILTER bits [6:4] of the DIGITAL_FILTER register
>> 	(Register 0x19). The ADAQ7768-1 automatically changes the decimation
>> 	rate to 8 and output data length is reduced to 16 bits from 24 bits 
>> 	due to the maximum speed limitation of the digital serial interface.
>>
>> In this case we don't even need to change the value of CONVLEN
>>
>>>>
>>>> Use multiple scan types feature to enable the driver to switch
>>>> scan type in runtime, making possible to support both 24-bit and
>>>> 16-bit resolution.
>>>>
>>>> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
>>>> ---
>>>>  drivers/iio/adc/ad7768-1.c | 65 ++++++++++++++++++++++++++++++++------
>>>>  1 file changed, 56 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
>>>> index 9741a6d47942..5e4e7d387f9a 100644
>>>> --- a/drivers/iio/adc/ad7768-1.c
>>>> +++ b/drivers/iio/adc/ad7768-1.c
>>>> @@ -134,6 +134,11 @@ struct ad7768_clk_configuration {
>>>>  	enum ad7768_pwrmode pwrmode;
>>>>  };
>>>>  
>>>> +enum ad7768_scan_type {
>>>> +	AD7768_SCAN_TYPE_NORMAL,
>>>> +	AD7768_SCAN_TYPE_HIGH_SPEED,
>>>> +};
>>>> +
>>>>  static const char * const ad7768_vcm_modes[] = {
>>>>  	"(AVDD1-AVSS)/2",
>>>>  	"2V5",
>>>> @@ -145,6 +150,10 @@ static const char * const ad7768_vcm_modes[] = {
>>>>  	"OFF",
>>>>  };
>>>>  
>>>> +static const int ad7768_mclk_div_rates[4] = {
>>>> +	16, 8, 4, 2,
>>>> +};
>>>> +
>>>>  static const struct ad7768_clk_configuration ad7768_clk_config[] = {
>>>>  	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
>>>>  	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
>>>> @@ -159,6 +168,21 @@ static const struct ad7768_clk_configuration ad7768_clk_config[] = {
>>>>  	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
>>>>  };
>>>>  
>>>> +static const struct iio_scan_type ad7768_scan_type[] = {
>>>> +	[AD7768_SCAN_TYPE_NORMAL] = {
>>>> +		.sign = 's',
>>>> +		.realbits = 24,
>>>> +		.storagebits = 32,  
>>>
>>> What happened to .shift = 8, ? If there is a reason for removing it, please add
>>> that to the commit description.
>>>   
>>
>> Sorry, will fix this
>>
>>>> +		.endianness = IIO_BE,
>>>> +	},
>>>> +	[AD7768_SCAN_TYPE_HIGH_SPEED] = {
>>>> +		.sign = 's',
>>>> +		.realbits = 16,
>>>> +		.storagebits = 32,  
>>>
>>> I guess it doesn't matter much since we are reading one sample at a time, but
>>> I would expect storagebits to be 16 instead of 32. Or if it really needs to be
>>> 32, does it need shift = 16?
>>>   
>>
>> This is because the hw is configured to return the samples in a 32 bits
>> format, so if storage is 16 we will get wrong data.

Ah, right, I was forgetting that the data is already coming separately through
the IIO backend interface on a different bus from SPI. So that would be the
comment Jonathan is looking for. :-)

> 
> Currently we only support one channel (daisy chain mode support might change
> that). Not particularly painful to repack and it doubles the data we can fit
> in a fifo of a given size.
> 
> If this is tricky because of later patches, throw in a common on why.
> 
> 
>>
>>>> +		.endianness = IIO_BE,
>>>> +	},
>>>> +};
>>>> +
>>>>  static int ad7768_get_vcm(struct iio_dev *dev, const struct iio_chan_spec *chan);
>>>>  static int ad7768_set_vcm(struct iio_dev *dev, const struct iio_chan_spec *chan,
>>>>  			  unsigned int mode);  
>>>
>>> ...
>>>   
>>>> @@ -308,6 +329,15 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
>>>>  	ret = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, &readval, 3);
>>>>  	if (ret < 0)
>>>>  		return ret;
>>>> +
>>>> +	/*
>>>> +	 * When the decimation rate is set to x8, the ADC data precision is reduced
>>>> +	 * from 24 bits to 16 bits. Since the AD7768_REG_ADC_DATA register provides
>>>> +	 * 24-bit data, the precision is reduced by right-shifting the read value
>>>> +	 * by 8 bits.
>>>> +	 */
>>>> +	if (st->dec_rate == 8)
>>>> +		readval = readval >> 8;  
>>>
>>> Why not change size of ad7768_spi_reg_read() instead of reading 3 bytes and
>>> throwing one away?
>>>   
>>
>> Right, i will check this and fix in the next version
>>
>>>>  	/*
>>>>  	 * Any SPI configuration of the AD7768-1 can only be
>>>>  	 * performed in continuous conversion mode.  
> 


