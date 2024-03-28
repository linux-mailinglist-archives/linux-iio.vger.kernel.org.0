Return-Path: <linux-iio+bounces-3674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987FC886679
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 06:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED44282151
	for <lists+linux-iio@lfdr.de>; Fri, 22 Mar 2024 05:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB69DBA3F;
	Fri, 22 Mar 2024 05:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AtvEoIyZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF24C8C11
	for <linux-iio@vger.kernel.org>; Fri, 22 Mar 2024 05:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086824; cv=none; b=UoGGPS8oaL7DZO2iSVCgiqh06mkBgT85RdEF0KgkPWFL/caMFuJ7VkaNhBFU1RDke5JHy17fWtYLUmoJNEH/Z0FCjuTztCQvhux8yLCPbDhlzOFcW64KxqPvykzQPgVwsr5r9ZQx1vA6c4VYJbh6nK03ZkEKGuwJlKxrBiQM6TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086824; c=relaxed/simple;
	bh=JV7W9Ku7IWOPbssxkeHzsvNBP5t7FxanPEnEHuoDtn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaQHtwhx2Pp5d3lhboWh+D/LIYCDALJ5ddXdvWDgjJF5tpjDg1qAzecrHc4XDifk0al8ePGEwYlTnWS2d/AWNXkfSmBzs07GHOnt6PQQyUpYpj8YTkWdfzXlZQC3FCqNoQ76n3UdvB07qlmiYlZyoKOY0y9QOB2zZCZxg4+TS44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AtvEoIyZ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso190156466b.2
        for <linux-iio@vger.kernel.org>; Thu, 21 Mar 2024 22:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711086821; x=1711691621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lvjjIMgrLj2t99LvBKSf+/6gq3yKKlLGxdAZIjikVqg=;
        b=AtvEoIyZ2nggQ1rjR0KfHS0j+VWnC6Ftq6OFhXlyqWkSIu/1T8nF5Th8Sv6Zz/MNeH
         PI0+s1yA0hpPafFbzSJOxiev+nOcpny5sVuHL+kdsIIGW6TawM00K84FoTDoKTgkKCF2
         0m0YwUn5ujoScoKILO8Xfl+/jBtdY0sZD22jAzrHnfppZb+XrlDQzbYnUmawVh/vPrH0
         ZfWMOWdEtChMwnnTjfAAFsFaBanSjriJzM/x0iY8bR/iHufbu65mgecqw6DKFB1iWpT5
         iRSbFBDKTT8wy5puFcegGVU6DgDYKs9tDbxzSgWeNVby4eVudkC6+egegBzpb8XJlPIh
         jPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711086821; x=1711691621;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvjjIMgrLj2t99LvBKSf+/6gq3yKKlLGxdAZIjikVqg=;
        b=Hw+iMunAVWgDH8iNhMSZXkk3W3QiKDYKd5/cHJX4F4CMJuQJkqmwgjI3VUsKIWXBJO
         n96uzmBUZO2Z//pVQt3PJDlIcRiKK7VWt+l7kQR4ZpYCfYyiMl+pEGiKxQhF6z9AkIap
         FMrGQUw8SaOGbqco9w9nIC0jF8ZvcFUBQvFTa7H/rDdrzjZiKHIjPxRKDOspAFDcnrp7
         8KyOYmgK3pIWfOKrZMHqoDdOzVE8zLAy1j6C/KMUWUO9D0pt/9eN6Hy9jMAJHnoq8eJR
         J4DLDB9Daa1NeJD0IVHdthfjpXyv1Wb7uAS+eP4jyfoylf6Sr1O+fky2xxU7p1ALBxel
         9FOQ==
X-Gm-Message-State: AOJu0YxmUCNWHgmyNaPA9d9gY2s5A96XLv/HaXKbk+q1HSmHJdpPAHFX
	QSxyDvEiRzJJkZ64KXxXU+4wGP3oQKpULQLqk2APL7jna0/KrfGIySULw6vGUyA=
X-Google-Smtp-Source: AGHT+IHKnmAxdeXQT2EGVL7vwgAwS0U1rboWtZYtZ0sxG5Vx45HUEfizPByTIvOV/mR9yqlqaLY8Vg==
X-Received: by 2002:a17:906:e0d1:b0:a46:eaa6:ce88 with SMTP id gl17-20020a170906e0d100b00a46eaa6ce88mr832218ejb.55.1711086821264;
        Thu, 21 Mar 2024 22:53:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id jt19-20020a170906ca1300b00a46a9cdcfa5sm634053ejb.162.2024.03.21.22.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 22:53:40 -0700 (PDT)
Message-ID: <51e3683f-be53-4bb7-a994-ffd05744a745@linaro.org>
Date: Fri, 22 Mar 2024 06:53:38 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] iio: accel: adxl345: Update adxl345
To: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
References: <20240322003713.6918-1-l.rubusch@gmail.com>
 <20240322003713.6918-2-l.rubusch@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240322003713.6918-2-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 01:37, Lothar Rubusch wrote:
> Move driver wide constants and fields into the header.

Why?

> Let probe call a separate setup function. Provide

Why?

> possibility for an SPI/I2C specific setup to be passed
> as function pointer to core.

Why?

Your commit message *MUST* explain why you are doing things.

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345.h      |  44 +++++++++++-
>  drivers/iio/accel/adxl345_core.c | 117 +++++++++++++++++--------------
>  drivers/iio/accel/adxl345_i2c.c  |  30 ++++----
>  drivers/iio/accel/adxl345_spi.c  |  28 ++++----
>  4 files changed, 134 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index 284bd387c..01493c999 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -8,6 +8,39 @@
>  #ifndef _ADXL345_H_
>  #define _ADXL345_H_
>  
> +#include <linux/iio/iio.h>
> +
> +/* ADXL345 register definitions */
> +#define ADXL345_REG_DEVID		0x00
> +#define ADXL345_REG_OFSX		0x1E
> +#define ADXL345_REG_OFSY		0x1F
> +#define ADXL345_REG_OFSZ		0x20
> +#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
> +#define ADXL345_REG_BW_RATE		0x2C
> +#define ADXL345_REG_POWER_CTL		0x2D
> +#define ADXL345_REG_DATA_FORMAT		0x31
> +#define ADXL345_REG_DATAX0		0x32
> +#define ADXL345_REG_DATAY0		0x34
> +#define ADXL345_REG_DATAZ0		0x36
> +#define ADXL345_REG_DATA_AXIS(index)	\
> +	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
> +
> +#define ADXL345_BW_RATE			GENMASK(3, 0)
> +#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
> +
> +#define ADXL345_POWER_CTL_MEASURE	BIT(3)
> +#define ADXL345_POWER_CTL_STANDBY	0x00
> +
> +#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
> +#define ADXL345_DATA_FORMAT_SPI         BIT(6) /* spi-3wire */
> +#define ADXL345_DATA_FORMAT_2G		0
> +#define ADXL345_DATA_FORMAT_4G		1
> +#define ADXL345_DATA_FORMAT_8G		2
> +#define ADXL345_DATA_FORMAT_16G		3
> +#define ADXL345_DATA_FORMAT_MSK		~((u8) BIT(6)) /* ignore spi-3wire */
> +
> +#define ADXL345_DEVID			0xE5
> +
>  /*
>   * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
>   * in all g ranges.
> @@ -23,11 +56,20 @@
>   */
>  #define ADXL375_USCALE	480000
>  
> +enum adxl345_device_type {
> +	ADXL345,
> +	ADXL375,
> +};
> +
>  struct adxl345_chip_info {
>  	const char *name;
>  	int uscale;
>  };
>  
> -int adxl345_core_probe(struct device *dev, struct regmap *regmap);
> +extern const struct adxl345_chip_info adxl3x5_chip_info[];
> +
> +int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> +		       const struct adxl345_chip_info *chip_info,
> +		       int (*setup)(struct device*, struct regmap*));

Last setup argument is entirely unused. Drop this change, it's not
related to this patchset. Neither explained.

Best regards,
Krzysztof


