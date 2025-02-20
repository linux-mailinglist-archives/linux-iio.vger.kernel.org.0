Return-Path: <linux-iio+bounces-15901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5C6A3E6E8
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 22:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B48117DC98
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 21:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CC3265616;
	Thu, 20 Feb 2025 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NnOmxCW4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14CC264631
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 21:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087715; cv=none; b=VWqLHXjNgOEwQpx0CSFNWwEerTZmXeUROziKY5zySDEA5JcJbbtY6+4EIptdd83PnJz+31LGN6uQUcX0kz5cQfxX+fOw6cUzfCOGGXim3zGMNwZK90g7UR4ZecwYhlCKUaf0enf/tStO5aq6pBNNDy5dA/+gMUuj0p46EmTz5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087715; c=relaxed/simple;
	bh=teD/oNsKx5RGV7eNFlPlZDTqmNgYlA6f2tN2uGCtX64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlF+66tyqjM0CjP84Ht4vS1ABMXKAPO7OTNIjO4fDFUf+6J7ddqwAiuU4x35/TU+8J+bvPjSpOJdh5541JHbDwlXd6bAZyYqcGsr994Kl08vHmcp4QIkIe96xYBoRZTUTVYe8RsvE2SK/s9Vic2f91nXWMqyAPvjuv1dFE53Oy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NnOmxCW4; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f408052bdcso532792b6e.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 13:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740087711; x=1740692511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rzkvNxfjrcmizqsZPYWmSMGgPflTiVYxAgW1kHG5PY4=;
        b=NnOmxCW4d+8alqAVEt1MMKvu9Vj75bIendB7q+NCBTrfLambEPZ9ddzZhQpcImLxxb
         gM/+EHTH88SA1jNGTnoqK0uFkg0m/URENG+Z+eGxlJt/JCtGCrJTJuVnlqL1vFXV9flj
         DcOmmyxHgzCzFq8xGkG06aPju4zL2ioyOw8Z4KWpj7SH0E9yrrEPgUF688C8jzs1MirH
         fwwBn6l09PyDuVh9McYLxj+gmmDdwa3uK9kaQorQbVKgEyXoF6/y/GapAEgY5VUIunDX
         Te7OJsx3Ylb96Q+CppRLEEbRyIfrfMac4l5q2r7bCZ+AvH/6Nh3N6r/9BkMhjpH558je
         KNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740087711; x=1740692511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzkvNxfjrcmizqsZPYWmSMGgPflTiVYxAgW1kHG5PY4=;
        b=BgaddvExs58kI/gjOgM+jESIJE8S+Oi8g/HWnazz2rYnqIxzZ4HHxm3PNu+DxPZD/k
         iKsbKawVx8uFH7S0feE+s3cOYHVXDDGAjlXjxOTnh6Qdgvg1yflFQmRBvsFSGolcK8Je
         4BsedOr1NbATzEf1+xxrhCHVoC69vZ+o57EApuoYuWaw2GXBfN0YPxPo99ybWweMnGM5
         IVUi1vpf27lXcwzc5dJ/F5Ya2uOEA+NtMRZ67cPOhPBnLm1yRRCc88LtiI9ipvTJ0dQx
         RrnS76RL6vaK1BlLwGDzgLeaohLkIDknVXmNunbNoIQ6nH0NE+zhSrwp8dUPBlN0IN/Q
         jHZw==
X-Forwarded-Encrypted: i=1; AJvYcCVMFdHq6Vnd9qA61+C6kTL8REk9MHMX+kpHDakAL08gIJVef7f9q4KsCFc9gq08yVBofd/Wt1OYUAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJ32UZb424NwAIVTa/Ic8NHgbUw1+u4r1sCdsOfoQvpZyU9YF
	s+XoUYJ6jH+v+k0k5/GweoBlc3I46xH/o/FGDkdwFV1BVawh0xYfn0e/juinQX0=
X-Gm-Gg: ASbGncsOK1uvqYxNjqTYEjJiLwl3tRu2yM6o304V4zre0Ac6fmGdNiRAEgYew/Dh2sd
	k25FNToPCA1oBTrzuKdX0odmgMRE47FlCfdO2IAoc43AKsmjef2jXuaumb6PoAYLG6eR4C/5P4h
	5zi/OmqkPVsfGQnZS9yfwidSdezMv2Rr+Acfdc4Op4vD8SUrBbSbjUKbRKQWQ4MCrpwF8NI6QJH
	b2HSOMI8lDJfLQIEu0OKeWsbrsHZVtGroBgv4wS79E/8MF3PLHzOWquwHYS7nV640RtRRdcWxXg
	++gyxSQIETdRi9ACuCAx0ov9KhB45B3r9Gsi2QkAt3Rj1jRjpZKM
X-Google-Smtp-Source: AGHT+IEY05XEGaQWK4ngyH/Pv19afkOgy82nwu7ulTs9vg3rVUHa4lOByzk4QFuWXD0qIcvj4+idew==
X-Received: by 2002:a05:6808:3085:b0:3f3:d159:16f8 with SMTP id 5614622812f47-3f4246d4b95mr868836b6e.19.1740087710997;
        Thu, 20 Feb 2025 13:41:50 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3f7e34401sm2743312b6e.38.2025.02.20.13.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 13:41:49 -0800 (PST)
Message-ID: <90be675e-9916-4db9-8a87-fde4148ba8e5@baylibre.com>
Date: Thu, 20 Feb 2025 15:41:47 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 08/17] iio: adc: ad7768-1: convert driver to use
 regmap
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <51aa3df84b50bf981bea65690d54feddd3d98a89.1739368121.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <51aa3df84b50bf981bea65690d54feddd3d98a89.1739368121.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 12:17 PM, Jonathan Santos wrote:
> Convert the AD7768-1 driver to use the regmap API for register
> access. This change simplifies and standardizes register interactions,
> reducing code duplication and improving maintainability.
> 
> Create two regmap configurations, one for 8-bit register values and
> other for 24-bit register values.
> 
> Since we are using regmap now, define the remaining registers from 0x32
> to 0x34.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v3 Changes:
> * Included a second register map for the 24-bit register values.
> * Added register tables to separate the 24-bit from the 8-bit values.
> 
> v2 Changes:
> * New patch in v2.
> ---

Should also add a `select REGMAP_SPI` line to the Kconfig
for this driver to avoid compile errors for random configs.

>  drivers/iio/adc/ad7768-1.c | 148 +++++++++++++++++++++++++------------
>  1 file changed, 101 insertions(+), 47 deletions(-)
> 


...

> @@ -260,15 +297,21 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
>  		return ret;
>  


I think we should set ret = -EINVAL; here, otherwise the ret from above
can survive and we return 0 even though no read or write was done if
the requested register was not valid.

>  	if (readval) {
> -		ret = ad7768_spi_reg_read(st, reg, 1);
> -		if (ret < 0)
> -			goto err_release;
> -		*readval = ret;
> -		ret = 0;
> +		if (regmap_check_range_table(st->regmap, reg, &ad7768_regmap_rd_table))
> +			ret = regmap_read(st->regmap, reg, readval);
> +
> +		if (regmap_check_range_table(st->regmap24, reg, &ad7768_regmap24_rd_table))
> +			ret = regmap_read(st->regmap24, reg, readval);
> +
>  	} else {
> -		ret = ad7768_spi_reg_write(st, reg, writeval);
> +		if (regmap_check_range_table(st->regmap, reg, &ad7768_regmap_wr_table))
> +			ret = regmap_write(st->regmap, reg, writeval);
> +
> +		if (regmap_check_range_table(st->regmap24, reg, &ad7768_regmap24_wr_table))
> +			ret = regmap_write(st->regmap24, reg, writeval);
> +
>  	}
> -err_release:
> +
>  	iio_device_release_direct_mode(indio_dev);
>  
>  	return ret;

