Return-Path: <linux-iio+bounces-14646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F98A201DB
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 00:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFFE3A623B
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 23:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4751A1DF261;
	Mon, 27 Jan 2025 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eijv0JFS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006481DED76
	for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021677; cv=none; b=diEOgwMYZaQmRVenD2tAAms40YAHDG3B2sMSt+FqZ4tjY7srHJz1TgEKVgCUNvsHNKyH+coS/N2gA3I6PbxFT6MFrhT/+k8uJswxL0JAX5cK2aFa2kWoPnE+u2rVZkLQwmsLkuks7Dv0E1bOn/eJCpkwgQFNM8EPoONO79FV3fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021677; c=relaxed/simple;
	bh=ZhTim9zucw235FoWB0yKshnJisPkmKNGRB7FZmrJi8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfRMHGnXKmF9OxKhSaTZxzJ6LSxX4deBhLidV/yrbSBxDxjbZq/ZTPxIVnhF9anG/Rd3XiRSAy1gRP5Uskj86y4jjhJQLf3byTAvUxpY8yqxvnxOvf/6U9Zbkpqkx+3QUPa7Sah8FnHe7nlzErNMEWL9GmoGdEFfDg46R7UAXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eijv0JFS; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2adc2b6837eso1445300fac.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 15:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738021674; x=1738626474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zj9pcMMVgp4HQXKodFRNu0/WkE6xV+1IDSiA1yELFNg=;
        b=eijv0JFSzq3H5eSKAC4P2Holwz1lMi0J9GLOCL5jeAHw3etRFXvj0L/mgzjc3hvVaJ
         ToA34tM/BFhI3N89l4eSI9ndzEsvWoCx8Qmxrudo5saRWsBoF1HSfuHyGUNuORktcEHY
         8CUrvedkhqWq2bhcHidlWHaYtClnaokC/kNi5lo+tJfvadyBu2R7fxHNSlGnrMuUwwt/
         H906C4c++BGW0cdAQRSztjE1hj2YVtd7BzfGy3OhOJICpjeuTlItWngbFzWF33FunTxU
         RMev6l8F9lqwGRW9xxcp+sCJ0LPd1qOMzC5fmWO3A9+6EM2wggXGjFaKCE9jx8oBdpjL
         7VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738021674; x=1738626474;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zj9pcMMVgp4HQXKodFRNu0/WkE6xV+1IDSiA1yELFNg=;
        b=XqKfUUj0RWHr0gV4avvJxz9bIi/8+bspn2RLbXMG3+ereUWUFiXKT/JZjZ2OoacdbG
         rEOMtgb2Dk8HNmxD5m0UUrJaAs3o51pas4XheKoeFHD2PqueJDzDVE/SGD9yETUfp/zP
         KppSnBNp4htgFsazIVtIDVBv8dkmgRk64KJspCpYuyfERQkaAa8d272z4qnwjGwkqzDT
         C3TYdfnRFlNpe8isGYsBRfoGyZzpL8WWk8i4Q2dNFfs+Ci0cRZIgAHKokCrUxMoXvNyA
         ZYcdgwcEGlF6cjj/WEGIHmcRArDX06VI6jFbaDD1rCkery3kzBT6TVigGNuiqG96u1zk
         RjBw==
X-Forwarded-Encrypted: i=1; AJvYcCWnRoNhjLbqP2X6TcAot90QTuUsQ86IRYJ4AVozeekLMCHqkRxvZbGs8O3xOMYeuxN3P9s2peVpZIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw871P62JeWus+ckvjpiXylZ5gTzWkeaJg3NIamgR3wBrBED/0w
	iKAT/vcT7kqh8KtlKwkeYM1MbFk2PpyxgEPgxIGk27pSbvxW9R1Q0MFI4Ub6ef8=
X-Gm-Gg: ASbGncv8F5pAbwvBBOnlTIdZ8Ywh6AqMCok6hJcwX+a1e6stHExeBPnXBVm1+0O44x+
	Wo8rp6tIyl4i2JprSDQsWrJeazpdyfwLQF1gxUoO484fVmP7xDXt00Hw3+asNTwlF3XFH/a25QD
	O35qMP/DPSD1zkNBhJdkwoiKIrZwaKpq5MU4P02CcEJIJ8GMVBOVNqA6S8c2hfHoq4gHGX1qLDo
	37DjW1qiFMCLHFd/oRkQVTwQPGXhIWu6Csp9pXtMn5INfYlSeoqjNvaX21w5ulSxE4Y8p7LfzAl
	Fql9Bm/ItHJp+qkXVIlOw9Ve5iljpwZmJA7SgvpEpMSaF4zs3L29
X-Google-Smtp-Source: AGHT+IF/BjQ2vfcU7AR2KFWOh60J8qCWDJIXaHZ5HGLcMJiuX5mst+T96QDPq/tWpXq+LexE1xiBAQ==
X-Received: by 2002:a05:6871:2281:b0:29e:2695:5214 with SMTP id 586e51a60fabf-2b1c0c54d73mr22519741fac.25.1738021673942;
        Mon, 27 Jan 2025 15:47:53 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b28f0facaesm3055861fac.1.2025.01.27.15.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 15:47:52 -0800 (PST)
Message-ID: <e6591d04-bbe6-4bde-a429-a4e6fc7abd9c@baylibre.com>
Date: Mon, 27 Jan 2025 17:47:51 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] iio: adc: ad7768-1: add multiple scan types to
 support 16-bits mode
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <8bff69133cddd7e6be714781ea7655a427a6c32e.1737985435.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <8bff69133cddd7e6be714781ea7655a427a6c32e.1737985435.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/25 9:13 AM, Jonathan Santos wrote:
> When the device is configured to Sinc5 filter and decimation x8,
> output data is reduced to 16-bits in order to support 1 MHz of
> sampling frequency due to clock limitation.
> 
> Use multiple scan types feature to enable the driver to switch
> scan type in runtime, making possible to support both 24-bit and
> 16-bit resolution.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v2 Changes:
> * Included the ".shift" value back to scan_type.
> * Changed the number of bytes from regmap_read instead of shifting the 
>   ADC sample value when the word size is lower (16-bits).
> ---
>  drivers/iio/adc/ad7768-1.c | 73 ++++++++++++++++++++++++++++++++------
>  1 file changed, 62 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index e3ea078e6ec4..7686556c7808 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -136,6 +136,15 @@ struct ad7768_clk_configuration {
>  	enum ad7768_pwrmode pwrmode;
>  };
>  
> +enum ad7768_scan_type {
> +	AD7768_SCAN_TYPE_NORMAL,
> +	AD7768_SCAN_TYPE_HIGH_SPEED,
> +};
> +
> +static const int ad7768_mclk_div_rates[4] = {
> +	16, 8, 4, 2,
> +};
> +
>  static const struct ad7768_clk_configuration ad7768_clk_config[] = {
>  	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
>  	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
> @@ -150,6 +159,23 @@ static const struct ad7768_clk_configuration ad7768_clk_config[] = {
>  	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
>  };
>  
> +static const struct iio_scan_type ad7768_scan_type[] = {
> +	[AD7768_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.realbits = 24,
> +		.storagebits = 32,
> +		.shift = 8,
> +		.endianness = IIO_BE,
> +	},
> +	[AD7768_SCAN_TYPE_HIGH_SPEED] = {
> +		.sign = 's',
> +		.realbits = 16,
> +		.storagebits = 32,

Why not make storagebits 16 here?

> +		.shift = 16,
> +		.endianness = IIO_BE,
> +	},
> +};
> +


