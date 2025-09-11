Return-Path: <linux-iio+bounces-23989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70048B53C0A
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 21:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE433A9B40
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 19:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288EA1A0BF3;
	Thu, 11 Sep 2025 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bBo1Debg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8DE1804A
	for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617282; cv=none; b=rYzBUJnZcfp5b/SF18+zq3QVtAaF3CBdC20/J7SAwMwrU8YDWbbIRvEo0GdwnP2+4cUaICL9NqXI1mK+WoGu+2bn5dobvBkl0SL93dMxhHjeiU24sdcd4mIDGXb0IH+OxlgkCbhIYxvh7T4f0aCvuJBeHb5JbJLqRQ+3tWMtRA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617282; c=relaxed/simple;
	bh=iNSdi8waQkKMEng9ruRDLzVSv65292Ob9iM0hJksiT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUJNkZTv3lJehU6B2bB9t4iT7jMd2DEb5s2cKmV3p7JqoCJpcNukRMK/YDup1W/FR8jS8E5ZqLFbm5yjPuG/c8LRfh8ORYCsYKe1IVKEfSmd49jlDYB4cHneB5NRH3EMq0TLd5zyDyrKrYuR6HdCZdN2eEKesyPqRfPm6IQe81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bBo1Debg; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61e6ee53d2dso255489eaf.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 12:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757617279; x=1758222079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fthKq2rW3gORdFxE06iIbkm3SFnx/Wct4rEjy2bskcs=;
        b=bBo1Debgcxq/z/Tdf9x7g3qFYatU+hs/r499zQrMyT9vrGwKn0z1EmHEKESVs9MvKE
         NTQPKjFt1ae0ihjRb502uh15Rjt1M7gdbAttqKiesFHWd4/Hfj3j85XcyHL+Hp0UpcOR
         Wmn2UGtPtSDKUYqOemR25ztePeJabyLhmTfX7ZvilvinyySn6HHR3IWEskWCiqcX05q0
         Qg5S+1ASClg+x1N9UWNRGQ+7MUXmzprNCO+9BkIk/RxmeuoKZYevrAdJ0EPHjO/yi/02
         1lo21w3f8KVzpmXhYXQzGYtUJ0IHTO2qbJuaZV56MUJ95jQLf9s9hOwnx7zWVMI5+rdd
         lPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617279; x=1758222079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fthKq2rW3gORdFxE06iIbkm3SFnx/Wct4rEjy2bskcs=;
        b=eC73HtyHxHa/mYZQfGA8shAUUXKxsaNPq+9LfKZJssvL35j6wX0ddpA01/x+PB29Py
         C0o5TbyXJSvdFh1xnVx+iCIIu0cQpeF2Nn8MI5BhSRFnBLkn2GqSDGkfgJ9l3Yql+kkN
         I4Oz2lWxB8UhSpZfUYtNMQN3EpNOWUH/cD9M3RJleQZcEiDyGisUA17hRCr3pqdCLDgq
         gJa7EPzargWhVefdInReMTiETtc0XStSg4/caT6rM1x0Ru7snU44sa2x9h9MotBywtYn
         XNJ6DBCqO4RZc7sRUUhO53yCLmnOn5Ih3e79cTaYKDr+47JF9zYIKAoBaFe1o+wJzIG2
         lxZw==
X-Forwarded-Encrypted: i=1; AJvYcCW31aYsPWSDNeLWuBKVKokxb+WiVY7InfkcNUNEE5oCMCvfD19DGOOj/nSXO7QMtk6IAemfRIuB9lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLEmlBVXMGYDoiGjZ3nK+APnFcHx6bDRuIpnE0XaklVYdYEP9d
	FjKd6Nrwa0dV6623i8U01LlFuoREehAPc3LLa3cZWk3RtLQQXwWsW6kU95lOcSOlxvc=
X-Gm-Gg: ASbGnctJ6ROFjoRLuE33+8Yz0Hx9QUQUUQCx5TfVqHM6I0eO1pPm+x39zUjkPFFtJxg
	4z/rHU8BitpFnjT3+YoUk9C8Nak0MR7vZo1A6vIHAQtKT62hh55oaSKq88lfH6sPM809Jkb9iBg
	ztc8m2/eumZZnZaS1ote6zWFbu5Wg6jGhhVYJELNVnhKqIQ4enyxbVlVftnH3yVW4ftpGlj9fIh
	AEHLrYc6oLLnYf1581RRJdkW86Nnii+KYaMunce6+lhH8/scgwS5GbJiPH3FShaf2CghZDi50kI
	aW5ZgUHaY1kkc8dau3OhSSVMx2McMAaJSddx0wNgp5f+YjDs+4gLolupPYLoRnpBQ6xTccN5mSa
	hTIdEVuayfP79jJkH6GpIBotfunGjnsfvY92g6+t52r2NT1G2UAKzyHuv7uMAgYpXbX93CImyNp
	J9lTchM6d6IQ==
X-Google-Smtp-Source: AGHT+IG/WjqpLxUF8gahCWiYxp4DdbPjm4+PK7gdmbSkpf8+fsZcBh3p4ZtjWEJ/jdx0r0UonKQdJA==
X-Received: by 2002:a05:6820:509:b0:621:a61e:c54 with SMTP id 006d021491bc7-621bed56e66mr291001eaf.2.1757617279052;
        Thu, 11 Sep 2025 12:01:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d684:59db:8b2a:5451? ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-621b7d83b68sm191994eaf.26.2025.09.11.12.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 12:01:18 -0700 (PDT)
Message-ID: <74607630-3ee3-43b0-88b0-37ea1bef6dc5@baylibre.com>
Date: Thu, 11 Sep 2025 14:01:17 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] iio: accel: bma220: split original driver
To: Petre Rodan <petre.rodan@subdimension.ro>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-4-e23f4f2b9745@subdimension.ro>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250910-bma220_improvements-v2-4-e23f4f2b9745@subdimension.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 2:57 AM, Petre Rodan wrote:
> In preparation for the i2c module, move the original code into multiple
> source files without any other functional change.
> 
> Create the additional bma220_core module.
> Fix checkpatch warning about GPL v2 license in bma220_spi.c.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> Changes:
> - split out open firmware table modification into separate patch
> - bma220_write_raw() exits without dev_err() based on similar feedback
>   from David
> - change includes in bma220.h
> - include bma220.h in bma220_core.c
> - add mutex.h and pm.h includes to bma220_core.c
> - cleanup struct spacing in bma220_spi.c
> ---
>  drivers/iio/accel/Kconfig       |   9 +-
>  drivers/iio/accel/Makefile      |   3 +-
>  drivers/iio/accel/bma220.h      |  19 +++
>  drivers/iio/accel/bma220_core.c | 313 ++++++++++++++++++++++++++++++++++++++++
>  drivers/iio/accel/bma220_spi.c  | 307 ++-------------------------------------
>  5 files changed, 354 insertions(+), 297 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 8c3f7cf55d5fa432a4d4662b184a46cd59c3ebca..2cc3075e26883df60b5068c73b0551e1dd02c32e 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -218,15 +218,20 @@ config BMA180
>  
>  config BMA220
>  	tristate "Bosch BMA220 3-Axis Accelerometer Driver"
> -	depends on SPI

I think we still want to keep `depends on SPI`. (And later add `|| I2C`)

There isn't much point in allowing this on systems that it can't
communicate with.


>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +	select BMA220_SPI if SPI
>  	help
>  	  Say yes here to add support for the Bosch BMA220 triaxial
>  	  acceleration sensor.
>  
>  	  To compile this driver as a module, choose M here: the
> -	  module will be called bma220_spi.
> +	  module will be called bma220_core and you will also get
> +	  bma220_spi if SPI is enabled.
> +
> +config BMA220_SPI
> +	tristate
> +	depends on BMA220
>  
>  config BMA400
>  	tristate "Bosch BMA400 3-Axis Accelerometer Driver"

