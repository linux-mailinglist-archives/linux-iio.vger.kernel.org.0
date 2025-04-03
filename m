Return-Path: <linux-iio+bounces-17565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EF7A79B26
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 07:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7CA3B678D
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 05:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3C918FDD8;
	Thu,  3 Apr 2025 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNB/FTcK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323ED8460;
	Thu,  3 Apr 2025 05:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743657409; cv=none; b=m4cL4ak+bupfClNRVjcsAgujjtt9v9GItoanzPBU8mMrkgp5cLS8SnUkA4rNCdm/CU0hnjoTloBp8kaQ1nSby21DByCdxeWlJe8QtiMnM4+xGOEiQjkZyG6VAnllNgb4syxJrcVUK1sfikr2C9tlB4Jp6R+6V3AAXw05H+Rsbr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743657409; c=relaxed/simple;
	bh=lNEwq541WDDDm2IgFe5/GIfhWT4xyzg68oQsT7TD30c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9lyG7ikv9WMHs1/4q+KxrIssSRQxIwjaoXz1s25qzEk3WWjIUl2FrwJZvvsXhxBW2k7Mc/WgxTy20pa7WOEjhlpM1f0SVidaa9PrM1a46x631fpHZ2NuOWoLmG0+69CZgLT08MkvTsDogmeYslaEaCYDNi28cVHLnuM6VaJz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNB/FTcK; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30db1bc464dso4434851fa.0;
        Wed, 02 Apr 2025 22:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743657405; x=1744262205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUnfrWM8O0y0Hox6uRP5nfk3TnR4bWTw87hOsdjgoNg=;
        b=NNB/FTcK+tMMyZ6dUau4j02MiRiTHzcKpMSXCDLBr1F5xUwfVQfZDj3cgn8MzwcS2I
         qKHgMwfRkXmEmyPIPnOLRrHcem3UxpMwcAxzQoqEtbLeCTFJH4kiOQM+hVodU9Np1Wmh
         6xbGPEjiANlS3p9P+v4eadfqwdIUOaEXZSByfUIccDuaiw0giRgUOfQTQiepj1naECP9
         yK5tpvRLtYF8N41eWVVaxGul/+jx5lQRDzk6uEBBZOhPFREfeo/Sp96v4pBuWdOrw93p
         mkbRy35rGVUzkaeGIShPIIS634MVxrYBgdmjvSSyWlIWeQnoZLP5OgPIA6nUqsfW8X5J
         HoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743657405; x=1744262205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUnfrWM8O0y0Hox6uRP5nfk3TnR4bWTw87hOsdjgoNg=;
        b=To773Nr74UJOhCeDiHyP5hhfWjaVRtf283pRSbQakfYH9ha6VwDfpKd+nce0MtuREE
         IH9igaEio2NSU9lYZMflVqoOHRyMo+lQmFD+tSswOJvWAQ7VHyqxUQ2n3k6NcGXzPFQa
         LcMUFi3+U3/GUzlJ9olmnaZImV7p/B4X9Q2eSA4AG9cr3CNv0FcKAJPIV8uHDXDlnhi8
         Ob9dlQpBOemqbfJdWiLO5thW1uxcDHNaGU8wCviKvbZX8eBkHzGnOpuMBkf2/fG5J65C
         EF95GwF7kDAe2iEMsBn61GZ0oM0l+Mag+57D6jSuuRtgxXtlbqm9PNPf1aAFU/D7bIVI
         EpCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQr5dbfbI5jdckJG4r5ztbYNBqQreHObGvssDvm4PbjdOUUzgN/KqnX45T88w6IsCZnXx3b9UyMWMs@vger.kernel.org, AJvYcCVqIFa8vVOw6rJIq1lNmhdUr1Nr8nuAHlqQDyvVzJa4maERMh9X6GuoQ+jfS2R6l2xWcBlulK9tq45M@vger.kernel.org, AJvYcCWNv/U8Tm8m/D+SmUIRVaKEjgsgy+3elbj2b0OOt2+vqU9p07gmE93a6iihQEn/SKn5/bnj1naPWmOqHS6F@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+r/kaCwb5QcNhWpjroElLvxtRMqcy8ReRi+TFTxCDv22yEkst
	23pJaVj0TclpOiZRkhP/iCj0CYQd7h2x5HeTsQTdk8GFv54zxgMW
X-Gm-Gg: ASbGncsAojDXjcrLyrjVn4tbA5w0cj6DRylsEh4WSiZ0isw9LobTPWbRhi/+q5QkgnQ
	ehidnNeQgJxeDhDrn4NsIv13IVBNDOEw0dDZFKg9F0gFpmO4FX7B073P4eHI/jyohoiQTWVr8d3
	KNfiezYwgHa+lTtWu/EFZNM4PXY9tj28h1Y9+upGmu0quGVZIdzXVr328eoHAeEEcRPtWjwHeYl
	nsPyySpGGAfLnbd7msLGEgCrbbmMWm66t0xVmo3CMv4ng73ZJvtYYQPRmHm4PSVAVCZ5I/YhSq9
	SKN9q8OaLlCzbCdLKoO3s0xCa/ZSvDwegF63HsfqkhYvo+CP4EGN1HISP55DLCrhtWDRG4z6WN3
	UnckdCe8pQI4WpVL7Qx+Jvd1J0Q==
X-Google-Smtp-Source: AGHT+IGo6U30lLCPfVEYuHbUU2svN+XQS4RolYNy9mZ6oSYmU0C6mOzGLsPpQarJYB1Hd0HHA1mvyw==
X-Received: by 2002:a2e:bc8f:0:b0:30c:4610:9e9e with SMTP id 38308e7fff4ca-30ef91cd073mr17825741fa.35.1743657405008;
        Wed, 02 Apr 2025 22:16:45 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f031bcdb1sm828641fa.80.2025.04.02.22.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 22:16:44 -0700 (PDT)
Message-ID: <1189b539-adb4-46f9-9783-c6577b57a304@gmail.com>
Date: Thu, 3 Apr 2025 08:16:43 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] iio: adc: ti-adc128s052: Simplify using
 be16_to_cpu()
To: David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1743573284.git.mazziesaccount@gmail.com>
 <feeabbfd3d3916c7497dfd94423ff83ef5f654f1.1743573284.git.mazziesaccount@gmail.com>
 <4c3e0d23-2582-4acf-8e90-542c8f8c385f@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <4c3e0d23-2582-4acf-8e90-542c8f8c385f@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/04/2025 00:04, David Lechner wrote:
> On 4/2/25 1:09 AM, Matti Vaittinen wrote:
>> The register data is 12-bit big-endian data. Use be16_to_cpu() to do
>> the conversion, and simple bitwise AND for masking to make it more
>> obvious.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> Revision history:
>> v1 => v2:
>>   - Fix commit msg to reflect the fact there was no bug
>>   - Drop Fixes tag
>>   - Use union for rx / tx buffer to avoid casting
>>   - Keep the shared message protected by the mutex
>> ---
>>   drivers/iio/adc/ti-adc128s052.c | 18 ++++++++++--------
>>   1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
>> index a456ea78462f..3e69a5fce010 100644
>> --- a/drivers/iio/adc/ti-adc128s052.c
>> +++ b/drivers/iio/adc/ti-adc128s052.c
>> @@ -28,32 +28,34 @@ struct adc128 {
>>   	struct regulator *reg;
>>   	struct mutex lock;
>>   
>> -	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
>> +	union {
>> +		__be16 rx_buffer;
>> +		u8 tx_buffer[2];
>> +	} __aligned(IIO_DMA_MINALIGN);
>>   };
>>   
>>   static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
>>   {
>>   	int ret;
>> +	char *msg = &adc->tx_buffer[0];
>>   
>>   	mutex_lock(&adc->lock);
>>   
>> -	adc->buffer[0] = channel << 3;
>> -	adc->buffer[1] = 0;
>> +	msg[0] = channel << 3;
>> +	msg[1] = 0;
>>   
>> -	ret = spi_write(adc->spi, &adc->buffer, 2);
>> +	ret = spi_write(adc->spi, msg, sizeof(adc->tx_buffer));
>>   	if (ret < 0) {
>>   		mutex_unlock(&adc->lock);
>>   		return ret;
>>   	}
>>   
>> -	ret = spi_read(adc->spi, &adc->buffer, 2);
>> -
>> +	ret = spi_read(adc->spi, &adc->rx_buffer, 2);
>>   	mutex_unlock(&adc->lock);
>> -
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
>> +	return be16_to_cpu(adc->rx_buffer) & 0xFFF;
> 
> 
> The cast isn't exactly beautiful, but this would save a lot of
> lines of diff and a few lines of code by avoiding the need for
> the union and the local msg variable.
> 
> 	return be16_to_cpup((__be16 *)adc->buffer) & 0xFFF;

Thanks again for the review David :)

I am unsure which way to go. I kind of like having the __be16 in the 
struct, as it immediately yells "data from device is big-endian". OTOH, 
I've never loved unions (and, it silences the above "yelling" quite a 
bit). I still think this might be the first time I really see a valid 
use-case for an union :) And, you're right this adds more lines, 
besides, the cast doesn't look that ugly to me. Yet, I originally had a 
cast probably as simple as this (and I also had the __be16 in the 
struct), and Jonathan suggested using union to avoid it...

At the end of the day, I suppose I am Okay with any of these 3 
approaches. Original cast, union or this cast you suggest. Jonathan, any 
preferences on your side?

> 
>>   }
>>   
>>   static int adc128_read_raw(struct iio_dev *indio_dev,
> 

Yours,
	-- Matti


