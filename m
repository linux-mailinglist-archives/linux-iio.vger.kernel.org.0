Return-Path: <linux-iio+bounces-27534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 175AFD0133A
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 07:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C75E3069D4F
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 06:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E8A318EFB;
	Thu,  8 Jan 2026 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHsuhpPV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A7301002
	for <linux-iio@vger.kernel.org>; Thu,  8 Jan 2026 06:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767852379; cv=none; b=MtRz41QlLWRVsXwiD8Ul+nZ7QEaVXL+6sVYHsH85B1o/qBfyaiAs2DaQ1lqHgtk5YVORE6rB7Q+Es/KnKfAqUctM2QfK9asVM9S98HQjAtUEs19TKi9FXHc6eJv3kxZcChcXrvyHEhXWVQRi/HY6Da1rJLmbZjE/0Jf+s1DNS0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767852379; c=relaxed/simple;
	bh=KLxIkXnhLy5AQiTjeWELfJxBNcfjk273PSXJZ7+3llM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLbovFIMHHh0hK5bCgMAMH7tlS6XyW0no3erNI0H6YmqhOhb1mpaJSK08J7Sb/gl50yG3oatC65k2wqFdkIGcCLrvbz4crIaMcMYFJTlfcMGm5yLoofK8bSDFUoM3uCACOh6Z2XbdEWqMLSIqWefWSpb5WKkT3ZTpW587mRJeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHsuhpPV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b6c13b68dso1119497e87.0
        for <linux-iio@vger.kernel.org>; Wed, 07 Jan 2026 22:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767852376; x=1768457176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwFZe9VzUZgEZC6AGvQFK4i98g/XBUDvNY20cqi3O5Y=;
        b=MHsuhpPV6UBZrwt6ct/+elmz+f9VL5fZAKbUu/fRIx1ZR88JD6l9uIPuj5/toSPiR9
         CrCLMZO5vt0n7S5R37PQpcUhzlTzovaeP5pU57gn61nF+ThY3HI2TQ0aF+uf1E93aYkZ
         bZos5DpKblT3tGWpg98/kbTB7m5A+YyEcFv2diQZIpjK9C9NH2IbATP3IBHWxd9PfJ6H
         JX7PFg6AUZsLvuCkvUpB3wJucUpdbJSkgAbniAm6i/jTPpkv0uHQya34LFFhTUYjy852
         wvTgUEYoang1Gd9PjnQkLFtLIyuzjJTcR/mE7w3kf3iF2ZimPF1rORU5Dny5aLSLUW5V
         UVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767852376; x=1768457176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwFZe9VzUZgEZC6AGvQFK4i98g/XBUDvNY20cqi3O5Y=;
        b=thr9QLUfHtJHlLnOAxZ9I6fd+mxg3aGSQsj+w4yp57mZUdUqyFOfyRLfS6B3Wbnyzo
         mVzde2cIfO/PJT+TFicrkRfJe8RvOrQf6vx/k8qGl3NktlFM0v34/wpbqvzqwUqPpT3Q
         CLVAXyBjq2Xj7vbeenxwdNP3ePrIEmQinxjpeGXwkXqhVcPlWIn7ruaNjy7QBnDstPNr
         wOugmhf203d3UiXunxsiSATCejA48bS1F+Xbey61f72mCxiM64ueETGolYYHTANTMiDB
         eOX3hriZFBDYEtbMzivSOlwP0otndg2lAIclrQuDW+F5bUnATiSA3GlXMKHkDMVrPOpG
         DH+A==
X-Gm-Message-State: AOJu0Yz+4zzLe733egM9ku7MquKJbKn0wKoRtk3Ls1aEIrVMtFPALKnY
	7/bzOU5BTSctnkPez6DTlMGipYrg+n/dKp35RSINizHwMY//2ar93O0g
X-Gm-Gg: AY/fxX6cMjSCAZpxhGWoIoxdipE1uwJRGWHBsa17TjephJtd4CeSyQAi/wGqDnapD3O
	9dxSQq/UKApbVa8SlRZCit0BgTg880UpcKRqudI9kE60qyRETKMehYciX4huSpA4npp1Yyaeq8g
	b7IrUB4mC91LocBS5zCRZdQ/bXXpOyzRiH/zhA1C+fXpgZzJQ4EXEi2EaC3IKY6lazLI0OMivMa
	NOsUGnv9UlyDSI403bOIGtg3zkD9miK+VT2H9Vku9/KbIrjg1eRav9dkQfomdrT1cHLk1o5UExN
	qpBIAOyUL+Vd7It26jYvtl7tRt/7B7HVKoxBm/wtFEPV/nLsJEPDQdkUOmccCIma3cEg30NDLnr
	TbYluCxm5ka7E2pD60A40ZiiZDPgVzJe0iteSsnoHD5xeYjGjlVO8ynPvvJRcrz2WGadYuIJ4YI
	pmG5fVGsCcSMEfyhwP4pMOBqoaEbBn7x6CJ8bu04YYZ2GJLVqx0KpBBcG4AYgY5NvKAN6u
X-Google-Smtp-Source: AGHT+IEEHo1bQ0j/1YRp4GIECoHoO18+cOgMbneVC1WjDIWd41k0XXdOs0UlgVyYSH/RGaDuDJoBKQ==
X-Received: by 2002:a05:6512:3b9d:b0:59b:79eb:968 with SMTP id 2adb3069b0e04-59b79eb0a1amr41509e87.0.1767852375512;
        Wed, 07 Jan 2026 22:06:15 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b6fa7f0acsm1013946e87.99.2026.01.07.22.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 22:06:14 -0800 (PST)
Message-ID: <fd506e0f-9e52-498d-8e35-077ab52efbd7@gmail.com>
Date: Thu, 8 Jan 2026 08:06:13 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7476: Remove duplicate include
To: Chen Ni <nichen@iscas.ac.cn>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260107082920.2151042-1-nichen@iscas.ac.cn>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260107082920.2151042-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/01/2026 10:29, Chen Ni wrote:
> Remove duplicate inclusion of linux/bitops.h.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

I would also appreciate having the includes alphabetically ordered as 
Andy suggested. This, however, is a fine fix as it is so:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/adc/ad7476.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 1bec6657394c..21d3f6aae972 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -16,7 +16,6 @@
>   #include <linux/gpio/consumer.h>
>   #include <linux/err.h>
>   #include <linux/module.h>
> -#include <linux/bitops.h>
>   #include <linux/delay.h>
>   
>   #include <linux/iio/iio.h>


-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

