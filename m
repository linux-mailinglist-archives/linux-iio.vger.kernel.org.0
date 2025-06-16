Return-Path: <linux-iio+bounces-20694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C82ADA7DE
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 07:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03548188D6DF
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 05:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841B71DBB13;
	Mon, 16 Jun 2025 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXdsfeta"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A2F15DBC1;
	Mon, 16 Jun 2025 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750053411; cv=none; b=W0PW0RomhYFv+UrxDmgShBnTHl/Xrz3RVlM9FSAObNncozAHF7qMmpYTKn+zjWITecdASP2pI/b4MKFwOGyC5wRgEjdSUi8krWANT9uw7UbloeqZmar4rLgcMv+YH/jXkwiyPUH0GdOZnPhetL2uMEHDf7oSs3EPNyXRbhHA/H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750053411; c=relaxed/simple;
	bh=2flmwofvUOmWgNk9cpEPSJhCsvXuQty5S/9F8RzXJmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pz+ar9C/7M/SfJO2uApZXO1HucUdin8EWhUmMKYbGlNJVM5hG9hnyb0/9gSZ1BUByFpymlVFSgAEkNAasVfWlaUCIX5GXvn2B/2HtzuIZR4xJ/WFIcE1Dg5INZj1EuNXOr7t3pGsysC9BQ384J8Stv1xS23bLLQu21hIKmpPmlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXdsfeta; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553644b8f56so4159859e87.1;
        Sun, 15 Jun 2025 22:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750053407; x=1750658207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkIqRqBOYA2VWKJUWUO3o+ZmSEfLGMo/CQL8xJvgZM0=;
        b=GXdsfetarzTqRVmXviaqU7iEopMLG98owc7EZxV4UEGu7nGg1n+A88aRyp09dAt7w6
         GzI+haWbXp89x261sd9LcElHaUAPTO9Ndx9idpE9u9WI15ZCLEVuwIhB9zLr7bwtj5x2
         HcpHfam6G5Y4MiYBmOlW2RNn0Sss90JqYY1hgnGrWqiEgkTvYwbiMUtJHQBFKjuQUP8B
         GMjN19nm7H9UXdx8ZsZy+PcZqytW45EKyBFPuiCXFZGnEM0fxOcc5mWDsLiPImJAat5Q
         QaJzrcVFWgnqYgFDi/IQ9ykVSo4njPLSY7AJgbnaq1X++XrYK934swjUGQMeU6C3flsW
         c7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750053407; x=1750658207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkIqRqBOYA2VWKJUWUO3o+ZmSEfLGMo/CQL8xJvgZM0=;
        b=MhvcrCKQVvetqt1qHr9BtYu4E15UCv4lscC453fbN3+A8noPZ2uom5lM8+XTD/mkb/
         Tzn5NS+ueS1FN+NFqhT370O2t9GZzhNwuv6CNiGabMysRJFjDvmO5DbRiuE1pMXEu/Ej
         lX6fVPW7txf7E52DJt0ewpgdI6JXt6qI+MIP+IwRjh6sTwjetDum5TDhAIQH0H62RuD5
         nTpTvhSM5jQXRM4FphN2pTvrFyUKXTp2UF+XJ6u8D+mUTF19N9+7U4LqgrnrQg82LMqF
         fxG+qJxVxW5HoZJsIp5H4TiabqONMuu9SGHaXfpeBv5UtXV9ALZQ/kItFkkDEemAfp/s
         UbIA==
X-Forwarded-Encrypted: i=1; AJvYcCVRT07yO9AbBmqt06drqr32V3o1Y491gyFr3hnnhoq7tBrsE+BAzl1mbwiFUF2Na9EhpPQ21deN/RQ1Z/wQ@vger.kernel.org, AJvYcCW/ZH0zeAFJhjK3z/cUGG6gNfjsksc46X/Kbmha/A/iHRwy05eabFQnJ8wt0d3x4XAzQ+69zQnZ/XqI@vger.kernel.org, AJvYcCXlcJZNT/srrmgtkpzftltGuw4ssgWef5t/hPZQ2u/ZnnR6a9LhdAIjwppvtvS5t7oJAjOZXgAUedPB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw07y8oLTUIXsQ6wvhehscmT8dtQSSvNRZSqEyfrLy84KHBM4j3
	Ow+CE0mfms55uQd3ilje6pAkE+7MoEq/BiJU32YJXqKGYKl0gqI/UoO0
X-Gm-Gg: ASbGncvUU0XSDB9y17HxQkTzavQh1Rv4qnCU5qoJyITx3Xc8Zv7qVlM4k0XTMoV+3wb
	pTSzNm+hhzgoU3nUiikby+x98vBZfK05+/AtxuLpHHIO85JFMcs1isBI0RH3lX/qHJoJRZcldhD
	XGcPQ6hUumY6HbnUABKYBd1WFi3H/MEMfyNLmTVkxcqn3whuwCrRH3Pe+NTmf3IJdISRVh3K+io
	fE114YZN2F7NIfAxgzbyGQ0424PWr6tbc9gofVRZe6rZVfuiQ/994WuoI6FPIPMVnmxm4kVRxGs
	cH/lRm+nhEycVfaOYf2geAI8OWSsicEuLH4k8xfbFlrFLDtQZ8nuFf47G3kECp9fqZGeggBr43u
	ayGhJqVsgeuI7MeAzV/qJSiASlZn08mjmJsNSYdtSviMN6xNh1VLXKw==
X-Google-Smtp-Source: AGHT+IF4t7826/HsDktRAkqzz8n3571xUPLVuGPlPMyBSr6j0fGBDJfK1Ia8NfneFADMf09PUGSg5w==
X-Received: by 2002:a05:6512:4022:b0:553:5d3c:e444 with SMTP id 2adb3069b0e04-553b6ed8c99mr1775937e87.25.1750053407252;
        Sun, 15 Jun 2025 22:56:47 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1ab307sm1405083e87.137.2025.06.15.22.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jun 2025 22:56:46 -0700 (PDT)
Message-ID: <1dbf4ce4-f43d-46b8-bd49-bc634f7c7697@gmail.com>
Date: Mon, 16 Jun 2025 08:56:45 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] iio: adc: ti-adc128s052: cleanup changes
To: Sukrut Bellary <sbellary@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250614091504.575685-1-sbellary@baylibre.com>
 <20250614091504.575685-4-sbellary@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250614091504.575685-4-sbellary@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/06/2025 12:15, Sukrut Bellary wrote:
> Arrange device IDs in alphabetical and numerical order. new device ID addition
> can follow the same convention. Also, arrange the structures in order.
> This is a cosmetic change only, and the functionality remains unchanged.
> 
> Co-developed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/adc/ti-adc128s052.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 2b206745e53d..fbf15c83c127 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -112,27 +112,27 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>   
>   #define ADC128_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 12)
>   
> -static const struct iio_chan_spec adc128s052_channels[] = {
> +static const struct iio_chan_spec adc122s021_channels[] = {
>   	ADC128_VOLTAGE_CHANNEL(0),
>   	ADC128_VOLTAGE_CHANNEL(1),
> -	ADC128_VOLTAGE_CHANNEL(2),
> -	ADC128_VOLTAGE_CHANNEL(3),
> -	ADC128_VOLTAGE_CHANNEL(4),
> -	ADC128_VOLTAGE_CHANNEL(5),
> -	ADC128_VOLTAGE_CHANNEL(6),
> -	ADC128_VOLTAGE_CHANNEL(7),
>   };
>   
> -static const struct iio_chan_spec adc122s021_channels[] = {
> +static const struct iio_chan_spec adc124s021_channels[] = {
>   	ADC128_VOLTAGE_CHANNEL(0),
>   	ADC128_VOLTAGE_CHANNEL(1),
> +	ADC128_VOLTAGE_CHANNEL(2),
> +	ADC128_VOLTAGE_CHANNEL(3),
>   };
>   
> -static const struct iio_chan_spec adc124s021_channels[] = {
> +static const struct iio_chan_spec adc128s052_channels[] = {
>   	ADC128_VOLTAGE_CHANNEL(0),
>   	ADC128_VOLTAGE_CHANNEL(1),
>   	ADC128_VOLTAGE_CHANNEL(2),
>   	ADC128_VOLTAGE_CHANNEL(3),
> +	ADC128_VOLTAGE_CHANNEL(4),
> +	ADC128_VOLTAGE_CHANNEL(5),
> +	ADC128_VOLTAGE_CHANNEL(6),
> +	ADC128_VOLTAGE_CHANNEL(7),
>   };
>   
>   static const char * const bd79104_regulators[] = { "iovdd" };
> @@ -216,27 +216,27 @@ static int adc128_probe(struct spi_device *spi)
>   }
>   
>   static const struct of_device_id adc128_of_match[] = {
> -	{ .compatible = "ti,adc128s052", .data = &adc128s052_config },
> +	{ .compatible = "rohm,bd79104",  .data = &bd79104_config    },
>   	{ .compatible = "ti,adc122s021", .data = &adc122s021_config },
>   	{ .compatible = "ti,adc122s051", .data = &adc122s021_config },
>   	{ .compatible = "ti,adc122s101", .data = &adc122s021_config },
>   	{ .compatible = "ti,adc124s021", .data = &adc124s021_config },
>   	{ .compatible = "ti,adc124s051", .data = &adc124s021_config },
>   	{ .compatible = "ti,adc124s101", .data = &adc124s021_config },
> -	{ .compatible = "rohm,bd79104",  .data = &bd79104_config },
> +	{ .compatible = "ti,adc128s052", .data = &adc128s052_config },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, adc128_of_match);
>   
>   static const struct spi_device_id adc128_id[] = {
> -	{ "adc128s052", (kernel_ulong_t)&adc128s052_config },
>   	{ "adc122s021",	(kernel_ulong_t)&adc122s021_config },
>   	{ "adc122s051",	(kernel_ulong_t)&adc122s021_config },
>   	{ "adc122s101",	(kernel_ulong_t)&adc122s021_config },
>   	{ "adc124s021", (kernel_ulong_t)&adc124s021_config },
>   	{ "adc124s051", (kernel_ulong_t)&adc124s021_config },
>   	{ "adc124s101", (kernel_ulong_t)&adc124s021_config },
> -	{ "bd79104",	(kernel_ulong_t)&bd79104_config },
> +	{ "adc128s052", (kernel_ulong_t)&adc128s052_config },
> +	{ "bd79104",	(kernel_ulong_t)&bd79104_config	   },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(spi, adc128_id);


